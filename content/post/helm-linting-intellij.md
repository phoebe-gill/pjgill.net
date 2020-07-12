+++
title = "Enabling custom Kubernetes resource support in IntelliJ"
date = "2020-07-12"
tags = ["gds", "software"]
+++

At work, we're using a [Kubernetes cluster](https://github.com/alphagov/gsp/) with a lot of custom resources. These custom resources allows us to configure access to databases, queues, and more.

However, this does mean that most IDEs refuse to handle our Kubernetes charts due to the presence of these resources. I've recently found a solution to this problem using [IntelliJ Ultimate](https://www.jetbrains.com/idea/).[^1]

[^1]: unfortunately, this requires the JetBrains Kubernetes plugin, which is not available for the free community edition of IntelliJ.

I've written a [small python script](https://gist.github.com/bjgill/dad40bbec2263f8a96b083b1b3fa6e18) to extract the definitions from the default `kubectl` output. This produces a set of files that IntelliJ will happily ingest.

```
$ python get_crds.py -h
usage: get_crds.py [-h] destination

Extract Kubernetes Custom Resource Definitions (CRDs) from the raw output of
`kubectl get crds -o yaml` for use by IntelliJ Ultimate.

positional arguments:
  destination  Directory to put the CRDs in

optional arguments:
  -h, --help   show this help message and exit

$ kubectl get crds -o yaml | python get_crds.py tmp/crds
Finished creating CRDs. Now go to Preferences -> Languages & Frameworks -> Kubernetes and add all the CRDs in tmp/crds.
$
```

Once you've done this, you'll find that syntax highlighting/linting/godo definition/etc. works for all your Kubernetes templates, including those using resources with custom definitions.
