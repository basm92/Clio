Clio
================

## Introduction

Clio is an R package that serves as a bridge between the user and the
website [Clio Infra](www.clio-infra.eu), a repository containing
publicly available data on various aspects of economic history at the
country level. This package is designed to quickly and efficiently
extract data, allowing the user to make large queries. This way, the
user is not confined to manually downloading Excel files, and the
associated filtering and merging process. The package also facilitates
transparent and reproducible data collection, and it is ‘typo robust’ to
a certain extent, to prevent annoyance.

## Functions

The package is designed to be very easy to use and contains only four
(key) functions:

  - clio\_overview()

This function provides an overview of all available variables on
clio-infra. It has no arguments, and returns a dataframe with all
variables, their title, and availability (from and to). The function’s
goal is to aid the user in browsing the variables, without having to go
back and forth to the website.

  - clio\_overview\_cat()

This function allows the user to browse through various categories of
data available. It is meant to be used in the following way: first, call
it without argument. That gives you a vector of currently available
categories of data. Secondly, call it again with a character vector of
one of the categories as an argument:

``` r
clio_overview_cat("production")
```

This will give the user an overview of variables *within* a certain
category. Note that the function does not support looking at two
categories at the same time. The `_get` equivalent of this function, the
function that actually provides the data to the user, does, however.

  - clio\_get()

`clio_get` returns a data frame on the basis of a couple of arguments: -
variables: You can select variables with the help of clio\_overview() or
clio\_overview\_cat(). You can enter multiple variables using
`c(var1,var2)`. - countries: You can enter one, or multiple countries,
also using `c(country1, country2)`. Defaults to all countries available
in the query. - from, to: condition the dataset on a certain time
period. If ineffective, no warning will be given. - list = FALSE: create
a list instead of a merged data.frame. - mergetype = inner\_join. Select
a merge type, `inner_join, outer_join, left_join, right_join`. Ignored
in case of `list = TRUE`.

  - clio\_get\_cat()

`clio_get_cat` accepts *categories* as inputs, as well as combinations
of categories using `c(cat1, cat2)`. All other arguments are passed on
to `clio_get`.

## Demonstration

``` r
head(clio_overview(),10)
```

    ##            variable_name from   to  obs
    ## 1      Cattle per Capita 1500 2010 7456
    ## 2    Cropland per Capita 1500 2010 6226
    ## 3       Goats per Capita 1500 2010 7037
    ## 4     Pasture per Capita 1500 2010 5963
    ## 5        Pigs per Capita 1500 2010 6841
    ## 6       Sheep per Capita 1500 2010 6835
    ## 7           Total Cattle 1500 2010 7457
    ## 8         Total Cropland 1500 2010 6191
    ## 9  Total Number of Goats 1500 2010 7037
    ## 10  Total Number of Pigs 1500 2010 6841

All categories of data are shown below:

``` r
clio_overview_cat()
```

    ##  [1] "Agriculture"       "Demography"        "Environment"      
    ##  [4] "Finance"           "Gender Equality"   "Human Capital"    
    ##  [7] "Institutions"      "Labour Relations"  "National Accounts"
    ## [10] "Prices and Wages"  "Production"

Browse through the database by feeding arguments to
`clio_overview_cat()`. It is
    typo-robust.

``` r
clio_overview_cat("Finanze")
```

    ##                                                 variable_name from   to   obs
    ## 1                                  Exchange Rates to UK Pound 1500 2013 15572
    ## 2                                 Exchange Rates to US Dollar 1500 2013 11765
    ## 3                                               Gold Standard 1800 2010 14359
    ## 4                            Long-Term Government  Bond Yield 1727 2011  2849
    ## 5 Total Gross Central Government  Debt as a Percentage of GDP 1692 2010  7134

``` r
clio_overview_cat("prices end weeges")
```

    ##         variable_name from   to   obs
    ## 1   Income Inequality 1820 2000   866
    ## 2           Inflation 1500 2010 16676
    ## 3 Labourers Real Wage 1820 2008  5053

``` r
clio_get(c("income inequality", "labouresrs real wage"))
```

    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 5,702 x 5
    ##    ccode country.name  year `Income Inequality` `Labourers Real Wage`
    ##    <dbl> <chr>        <dbl>               <dbl>                 <dbl>
    ##  1    24 Angola        1820                48.9                 NA   
    ##  2    32 Argentina     1820                47.1                 NA   
    ##  3    40 Austria       1820                53.4                 NA   
    ##  4    56 Belgium       1820                62.4                 16.6 
    ##  5   204 Benin         1820                48.0                 NA   
    ##  6    76 Brazil        1820                47.1                 NA   
    ##  7   120 Cameroon      1820                56.2                 NA   
    ##  8   124 Canada        1820                45.1                 NA   
    ##  9   152 Chile         1820                47.1                 NA   
    ## 10   156 China         1820                44.9                  3.71
    ## # … with 5,692 more rows

``` r
clio_get(c("infant mortality", "zinc production"))
```

    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 14,570 x 5
    ##    ccode country.name    year `Infant Mortality` `Zinc Production`
    ##    <dbl> <chr>          <dbl>              <dbl>             <dbl>
    ##  1   191 Croatia         1810               175                 NA
    ##  2   246 Finland         1810               200.                 0
    ##  3   826 United Kingdom  1810               141                  0
    ##  4    40 Austria         1820               188.                 0
    ##  5   191 Croatia         1820               150                 NA
    ##  6   246 Finland         1820               198.                 0
    ##  7   250 France          1820               182                  0
    ##  8   528 Netherlands     1820               179                 NA
    ##  9   826 United Kingdom  1820               153                  0
    ## 10    40 Austria         1830               251.                 0
    ## # … with 14,560 more rows

``` r
clio_get(c("biodiversity - naturalness", "xecutive Constraints  (XCONST)"), 
         from = 1850, to = 1900, 
         countries = c("Armenia", "Azerbaijan"))
```

    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 12 x 5
    ##    ccode country.name  year `Biodiversity - natural… `Executive Constraints  (X…
    ##    <dbl> <chr>        <dbl>                    <dbl>                       <dbl>
    ##  1    51 Armenia       1850                    0.903                          NA
    ##  2    31 Azerbaijan    1850                    0.908                          NA
    ##  3    51 Armenia       1860                    0.899                          NA
    ##  4    31 Azerbaijan    1860                    0.900                          NA
    ##  5    51 Armenia       1870                    0.896                          NA
    ##  6    31 Azerbaijan    1870                    0.892                          NA
    ##  7    51 Armenia       1880                    0.892                          NA
    ##  8    31 Azerbaijan    1880                    0.883                          NA
    ##  9    51 Armenia       1890                    0.888                          NA
    ## 10    31 Azerbaijan    1890                    0.873                          NA
    ## 11    51 Armenia       1900                    0.884                          NA
    ## 12    31 Azerbaijan    1900                    0.863                          NA

``` r
clio_get(c("Zinc production", "Gold production"), 
         from = 1800, to = 1920, 
         countries = c("Botswana", "Zimbabwe", 
                       mergetype = inner_join))
```

    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 242 x 5
    ##    ccode country.name  year `Zinc Production` `Gold Production`
    ##    <dbl> <chr>        <dbl>             <dbl>             <dbl>
    ##  1    72 Botswana      1800                NA                 0
    ##  2   716 Zimbabwe      1800                NA                 0
    ##  3    72 Botswana      1801                NA                 0
    ##  4   716 Zimbabwe      1801                NA                 0
    ##  5    72 Botswana      1802                NA                 0
    ##  6   716 Zimbabwe      1802                NA                 0
    ##  7    72 Botswana      1803                NA                 0
    ##  8   716 Zimbabwe      1803                NA                 0
    ##  9    72 Botswana      1804                NA                 0
    ## 10   716 Zimbabwe      1804                NA                 0
    ## # … with 232 more rows

``` r
clio_get(c("Armed conflicts internal", "Gold production", "Armed conflicts international"), 
         mergetype = inner_join)
```

    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 34,559 x 6
    ##    ccode country.name  year `Armed conflicts… `Gold Productio… `Armed Conflicts…
    ##    <dbl> <chr>        <dbl>             <dbl>            <dbl>             <dbl>
    ##  1    12 Algeria       1681                 0              0                   1
    ##  2    24 Angola        1681                 0              0                   1
    ##  3    32 Argentina     1681                 0              0                   0
    ##  4    51 Armenia       1681                 0              0                   0
    ##  5    36 Australia     1681                 0              0                   0
    ##  6    40 Austria       1681                 0              0                   0
    ##  7    31 Azerbaijan    1681                 0              0                   0
    ##  8    68 Bolivia       1681                 0              0                   0
    ##  9    72 Botswana      1681                 0              0                   0
    ## 10    76 Brazil        1681                 0              1.5                 0
    ## # … with 34,549 more rows

The kind of merge is customizable . The argument name is \(mergetype\).
And it takes the values full\_join (default), left\_join, inner\_join,
outer\_join, etc. if you have loaded `dplyr`.

``` r
clio_get_cat("finanz", list = F, from = 1800, to = 1900)
```

    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 7,074 x 8
    ##    ccode country.name  year `Exchange Rates… `Exchange Rates… `Gold Standard`
    ##    <dbl> <chr>        <dbl>            <dbl>            <dbl>           <dbl>
    ##  1    40 Austria       1800            10.1             NA                  0
    ##  2   124 Canada        1800             1.08            NA                  0
    ##  3   156 China         1800             3.64            NA                  0
    ##  4   208 Denmark       1800             5.09            NA                  0
    ##  5   276 Germany       1800            11.9              3.00               0
    ##  6   372 Ireland       1800             1.11            NA                  0
    ##  7   380 Italy         1800             5.24            NA                  0
    ##  8   428 Latvia        1800             3.78            NA                 NA
    ##  9   528 Netherlands   1800            11.3              2.61               0
    ## 10   616 Poland        1800            21.3             NA                  0
    ## # … with 7,064 more rows, and 2 more variables: `Long-Term Government Bond
    ## #   Yield` <dbl>, `Total Gross Central Government Debt as a Percentage of
    ## #   GDP` <dbl>

``` r
clio_overview_cat()
```

    ##  [1] "Agriculture"       "Demography"        "Environment"      
    ##  [4] "Finance"           "Gender Equality"   "Human Capital"    
    ##  [7] "Institutions"      "Labour Relations"  "National Accounts"
    ## [10] "Prices and Wages"  "Production"

``` r
clio_get_cat(c("agriculture", "environment"),
             countries = "Netherlands",
             mergetype = inner_join, from = 1850, to = 1900)
```

    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 6 x 20
    ##   ccode country.name  year `Cattle per Cap… `Cropland per C… `Goats per Capi…
    ##   <dbl> <chr>        <dbl>            <dbl>            <dbl>            <dbl>
    ## 1   528 Netherlands   1850            0.397            0.235          0.00352
    ## 2   528 Netherlands   1860            0.386            0.229          0.00352
    ## 3   528 Netherlands   1870            0.389            0.223          0.00352
    ## 4   528 Netherlands   1880            0.362            0.217          0.00352
    ## 5   528 Netherlands   1890            0.335            0.211          0.00352
    ## 6   528 Netherlands   1900            0.320            0.204          0.00352
    ## # … with 14 more variables: `Pasture per Capita` <dbl>, `Pigs per
    ## #   Capita` <dbl>, `Sheep per Capita` <dbl>, `Total Cattle` <dbl>, `Total
    ## #   Cropland` <dbl>, `Total Number of Goats` <dbl>, `Total Number of
    ## #   Pigs` <dbl>, `Total Number of Sheep` <dbl>, `Total Pasture` <dbl>,
    ## #   `Biodiversity - naturalness` <dbl>, `CO2 Emissions per Capita` <dbl>, `SO2
    ## #   Emissions per Capita` <dbl>, `Total CO2 Emissions` <dbl>, `Total SO2
    ## #   Emissions` <dbl>

``` r
clio_get_cat("Produzioni", from = 1700, list = F, mergetype = inner_join)
```

    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 1,197 x 15
    ##    ccode country.name  year `Aluminium Prod… `Bauxite Produc… `Copper Product…
    ##    <dbl> <chr>        <dbl>            <dbl>            <dbl>            <dbl>
    ##  1    36 Australia     1880                0                0              0  
    ##  2    76 Brazil        1880                0                0              0  
    ##  3   156 China         1880                0                0              0  
    ##  4   356 India         1880                0                0              0  
    ##  5   364 Iran          1880                0                0              0  
    ##  6   398 Kazakhstan    1880                0                0              0  
    ##  7   643 Russia        1880                0                0              3.2
    ##  8   724 Spain         1880                0                0             36.6
    ##  9   840 United Stat…  1880                0                0             27  
    ## 10    36 Australia     1881                0                0              0  
    ## # … with 1,187 more rows, and 9 more variables: `Gold Production` <dbl>, `Iron
    ## #   Ore Production` <dbl>, `Lead Production` <dbl>, `Manganese
    ## #   Production` <dbl>, `Nickel Production` <dbl>, `Silver Production` <dbl>,
    ## #   `Tin Production` <dbl>, `Tungsten Production` <dbl>, `Zinc
    ## #   Production` <dbl>

``` r
clio_get(c("Tin Production", "income inequality"), from = 1800, countries = c("Netherlands", "Russia"))
```

    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 225 x 5
    ##    ccode country.name  year `Tin Production` `Income Inequality`
    ##    <dbl> <chr>        <dbl>            <dbl>               <dbl>
    ##  1   643 Russia        1800                0                  NA
    ##  2   643 Russia        1801                0                  NA
    ##  3   643 Russia        1802                0                  NA
    ##  4   643 Russia        1803                0                  NA
    ##  5   643 Russia        1804                0                  NA
    ##  6   643 Russia        1805                0                  NA
    ##  7   643 Russia        1806                0                  NA
    ##  8   643 Russia        1807                0                  NA
    ##  9   643 Russia        1808                0                  NA
    ## 10   643 Russia        1809                0                  NA
    ## # … with 215 more rows

``` r
clio_get_cat("labor relation")
```

    ## Joining, by = c("ccode", "country.name", "year")
    ## Joining, by = c("ccode", "country.name", "year")

    ## # A tibble: 4,951 x 6
    ##    ccode country.name  year `Number of Days … `Number of Labou… `Number of Work…
    ##    <dbl> <chr>        <dbl>             <dbl>             <dbl>            <dbl>
    ##  1    32 Argentina     1927            363492                56            26888
    ##  2    36 Australia     1927           1713581               441           200757
    ##  3    40 Austria       1927            686560               216            35300
    ##  4    56 Belgium       1927           1658836               186            45071
    ##  5   100 Bulgaria      1927             57196                23             2919
    ##  6   124 Canada        1927            152570                74            22299
    ##  7   156 China         1927           7622029               117           881289
    ##  8   208 Denmark       1927            119000                17             2851
    ##  9   233 Estonia       1927              3067                 5              218
    ## 10   246 Finland       1927           1528182                79            13368
    ## # … with 4,941 more rows

Thank you for reading\! Questions and remarks: Github or
[e-mail](mailto:a.h.machielsen@uu.nl). If you have any improvements,
feel free to submit a PR. In case of issues: Feel free to [start a
thread](https://github.com/basm92/Clio/issues) or point them out
otherwise.
