+++
title = "Don't drink the water and don't breathe the air"
description = "How bad an idea is it to visit South Africa"
date = "2016-12-05"

+++

I recently read a [rather interesting article about air pollution in South Africa](http://www.theigc.org/blog/the-cost-of-air-pollution-in-south-africa/). This is particularly interesting to me, since I will be visiting the country in the near future - if I spend 12 days there, roughly how much life expectancy will that cost me?

## Data

* The article suggested that 27 000 premature deaths across South Africa were caused by "chronic exposure to fine [Particulate Matter (PM)]". 
* Independently, the WHO has figures for [premature deaths and DALYs lost to outdoor air pollution](http://www.who.int/quantifying_ehimpacts/national/countryprofile/mapoap/en/).
* Statistics South Africa estimates [population at 55.91 million and life expectancy at ~62.4 years](http://www.statssa.gov.za/publications/P0302/P03022016.pdf)

## Assumptions

* The IGS and WHO mean the same thing when they talk about premature deaths (note that this implies that I am assuming that PM is the only form of air pollution).
* South Africa has a near-global-average ratio of premature deaths to DALYs lost.
* The average life expectancy lost per-person is a strictly linear function of cumulative air pollution exposure.

## Calculation (note aggressive rounding)

```
za_premature_deaths = 27000 deaths/year
global_population = 6.2 x10^7
death_conversion_factor = (1.1 DALYs/1000 capita * global_population)/ 865000 deaths = 0.08 DALYs/death
za_dalys = za_premature_deaths * death_conversion_factor = 2160/year
individual_za_dalys = za_dalys / 55.91 x10^6 people = 4 x10^-5 dalys/year/person
```

Using this factor, I can multiply it by 12 days to get my reduction in life expectancy of 41 seconds.

Compare this to an average person living in South Africa for all of their lives (all 62.4 years). They will have lost nearly a day of life expectancy.

Intuitively, this feels quite small, given that later in the same article, the authors state that "these premature deaths cost the economy $20 billion (2011 International $), or 6% of South Africa’s 2012 GDP". Maybe I've made an arithmetic error, or my assumptions are much worse than I had expected. Maybe air pollution in South Africa really isn't that big a deal (except on statistical scales). Maybe air pollution only kills those who were on the point of dying from other causes anyway.

I'm really not sure. Either way, I'll be watching out for [their paper](http://www.theigc.org/project/health-costs-of-energy-related-air-pollution-in-south-africa/), come March.