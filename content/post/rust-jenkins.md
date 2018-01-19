+++
title = "Rust CI using Jenkins"
description = "An introductory guide"
draft = false
date = "2018-01-23"
tags = ["software", "metaswitch"]
+++

At Metaswitch, we use Jenkins extensively for CI. So, when we started writing (proprietary) Rust code, Jenkins was the obvious choice of CI system.

However, as a quick search revealed, few other people are using Jenkins for Rust – or, if they are, they’re not talking about it on the internet.
This, then, is the missing brief guide as to how to set up a simple CI pipeline for your Rust code in Jenkins.

This guide assumes familiarity with Rust, Jenkins and [Jenkinsfiles](https://jenkins.io/doc/book/pipeline/).

## Basic Jenkinsfile

We start off with some Jenkins slaves with docker installed. Rust compilation is slow enough as it is, so we use fairly large VMs – 8 vCPUs/8 GB RAM. We build our own docker containers which pin us to specific versions of Rust/Clippy/Rustfmt to ensure build repeatability. You could roll your own using https://hub.docker.com/r/ekidd/rust-musl-builder/.

We can then create a [Jenkinsfile](https://jenkins.io/doc/book/pipeline/) containing all the configuration we need for our CI pipeline as follows:

```jenkinsfile
pipeline {
    agent {
        table 'rust'
    }

    stages {
        stage('Build') {
            steps {
                sh "cargo build"
            }
        }
        stage('Test') {
            steps {
                sh "cargo test"
            }
        }
        stage('Clippy') {
            steps {
                sh "cargo +nightly clippy --all"
            }
        }
        stage('Rustfmt') {
            steps {
                // The build will fail if rustfmt thinks any changes are
                // required.
                sh "cargo +nightly fmt --all -- --write-mode diff"
            }
        }
        stage('Doc') {
            steps {
                sh "cargo doc"
                // We run a python `SimpleHTTPServer` against
                // /var/lib/jenkins/jobs/<repo>/branches/master/javadoc to
                // display our docs
                step([$class: 'JavadocArchiver',
                      javadocDir: 'target/doc',
                      keepAll: false])
            }
        }
    }
}
```

## Warnings

You have options as to how to deal with warnings. We have decided that our code must not produce warnings, so have denied warnings in our cargo config.

An alternative approach would be to make the build unstable if warnings are detected. We adopt this approach on our canary builds using beta and nightly Rust. To set this up, you will need to configure warning parsers for Rust and Clippy warnings:

{{< figure src="/rust-warning-parser.png" >}}

{{< figure src="/clippy-warning-parser.png" >}}

Then, add the following to the Jenkinsfile to check for Rust/Clippy warnings after a build has completed:

```
post {
    always {
        script {
            step([$class: 'WarningsPublisher',
                  canResolveRelativePaths: true,
                  canComputeNew: true,
                  unHealthy: '10',
                  healthy: '0',
                  unstableTotalAll: '0',
                  thresholds: [[$class              : 'FailedThreshold',
                                failureNewThreshold : '',
                                failureThreshold    : '',
                                unstableNewThreshold: '',
                                unstableThreshold   : '0']],
                  consoleParsers: [[parserName: 'Rustc Warning Parser'],
                                   [parserName: 'Clippy warnings']]])
        }
    }
}
```

## Raising GitHub issues

We have set up our CI system to raise GitHub issues on any build failure. Unfortunately, the GitHub plugin does not yet properly support the latest Jenkinsfile format. Thus, we set the following property inside script tags – this overrides anything in the options tag.

```
stage('Initialise') {
    steps {
        script {
            properties([[$class: 'GithubProjectProperty',
                        projectUrlStr: 'https://github.com/Metaswitch/<repo>/']])
        }
    }
}
```

And add the following step to the post section:

```
step([$class: 'GitHubIssueNotifier',
                  issueAppend: true,
                  issueTitle: '$JOB_NAME $BUILD_DISPLAY_NAME failed'])
```

## Thanks

Thanks to [Metaswitch](https://www.metaswitch.com/) for giving me time to write this guide.

This post is released under [CC0](https://creativecommons.org/publicdomain/zero/1.0/), with code under the [Unlicense](http://unlicense.org/).
