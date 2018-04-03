+++
title = "Do we have a gender retention gap?"
description = "A pre-trial registration"
draft = false
date = "2018-04-03"
tags = ["diversity", "metaswitch"]
+++

# Introduction

My employer has now published their [UK gender pay](https://gender-pay-gap.service.gov.uk/viewing/employer-details?id=-b5hzCV7E5qgd1hklF2PxA%21%21) [gap figures](https://www.metaswitch.com/about/uk-gender-pay-gap). This has prompted me to pick up earlier thinking about retention.

Measuring diversity in recruitment is easy. HR will be monitoring this. From my experience, this figure (particularly for gender) is not considered top secret and will often be shared internally - some companies even make this number public.

Retention is both more difficult and more interesting. More difficult because companies are (somewhat understandably) more shy about their retention figures. More interesting, however, because my impression is that less effort has been put into improving retention of members of underprivileged groups than their recruitment. Whilst much of the gender gap is historical, it is my hypothesis that there may be a current gender gap in retention that will make fixing the gender gap in pay and seniority very difficult.

This, then, is my pre-trial registration. What follows is the proposed methods for a series of statistical experiments to determine whether my hypothesis is justifiable. For obvious reasons, I do not think I will be able to share the actual data or results externally. However, I hope that the methods used may be broadly interesting and useful.

# Method

The overall approach will be [frequentist](https://en.wikipedia.org/wiki/Frequentist_inference) in nature. I will describe three plausible null hypotheses, and will detail how I plan to test each. I plan to look for effects at the `p=0.05` level.

All three null hypotheses assume that male and non-male retention are equal. They differ in their modeling of how length of service affects retention.

## H_{0,0}

The simplest null hypothesis is:

> Male and non-male retention are equal if we assume that every employee has equal probability of leaving in any given unit of time.

For this experiment, you will need:

1. `N`: Total number of employees
2. `L`: Number of employees who left in the past year
3. `N'`: Total number of non-male employees
4. `L'`: Number of non-male employees who left in the past year

The overall probability of leaving is then `l = L/N`. You can then work out the 'probability' of observing `L'` or greater non-male leavers using the binomial cumulative distribution function:

```
P(H_{0,0} | L') = B(L' | N', l)
```

## H_{0,1}

The obvious problem with the first null hypothesis is that it is easily observed that people who have been with a company longer are more likely to stay. We recruit a higher-proportion of non-men than are in the company, so of course more non-men will leave. I fully expect `H_{0,0}` to be disproven at Metaswitch, but am not sure this will be very informative.

Let us address this objection by going to a silly extreme. Let us take a null hypothesis that assumes that people only ever leave in the year after joining. I think this is the null hypothesis that will give us the highest number of non-male leavers without breaking the overall assumption that there is no actual difference between the intrinsic male and non-male retention rates.

I fully expect that `H_{0,1}` will not be disproven at Metaswitch. If it is, that is likely very strong evidence for an alarmingly huge retention gap.

For this experiment, you will need:

1. `J`: Number of employees who joined in the past year
2. `L`: Number of employees who left in the past year
3. `J'`: Number of non-male employees who joined in the past year
4. `L'`: Number of non-male employees who left in the past year

You then use the same procedure as for `H_{0,1}` to get a probability from the binomial distribution `P(H_{0,1} | L') = B(L' | J', j)`.

## H_{0,2}

I fully expect Metaswitch to disprove `H_{0,0}`, and to fail to disprove `H_{0,1}`. This will leave us in an awkward position, where we are seemingly no further forward than when we started.

The solution, then, is a more complex null hypothesis - `H_{0,2}`. Here, we will take the assumption that all differences in retention are due to seniority to their logical conclusion.

I have not yet mapped this out fully. However, the approach here will be to start with:

1. `N(t)`: Distribution of employees by seniority
2. `L(t)`: Distribution of leavers by seniority
3. `N'(t)`: Distribution of non-male employees by seniority
4. `L'`: Number of non-male employees who left in the past year

Given inputs 1-3, it will be possible to construct a probability distribution for the number of non-male leavers. We can use this to test `H_{0,2}`.

Unfortunately, it seems likely that nobody outside HR will have access to the precise numbers required to construct 1-3. We will just have to do the best we can, and try to ensure that any additional assumptions we make do not compromise the experiment excessively.

Disproving `H_{0,2}` would be good evidence of some degree of gender retention gap.

## Caveats

* I am not a statistician. Hence, everything here is likely to be simplistic and naive. However, I've done enough statistics at university to be reasonably confident that I'm not doing anything excessively stupid.
* This experiment merely looks at whether there is a gender retention gap. If one exists, this experiment cannot give much/any indication of magnitude.
