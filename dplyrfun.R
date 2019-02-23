#learning about he dplyr package
gapminder <- read.csv("data/gapminder_data.csv")

#subset in base R
mean(gapminder[gapminder$continent=="Africa","gdpPercap"])

#Tidyverse is a data tool set for data analysis

#load package
install.packages("dplyr")
library(dplyr)

#select columns 
year_country_gdp <- gapminder %>% select(year,country,"gdpPercap")
year_country_gdp_africa <- gapminder %>% filter(continent=="Africa")
  
head(year_country_gdp_africa)
  
#summarize by groups 

  gdp_bycontinents <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))
  
#calculate the avf life expec/country, which has longest and shortest
  lifeExp_bycountry <- gapminder %>%
    group_by(country) %>%
    summarize(mean_lifeExp=mean(lifeExp))
  lifeExp_bycountry %>%
  #using filter to show min and max
      filter(mean_lifeExp == min(mean_lifeExp) | mean_lifeExp == max(mean_lifeExp))
#using arrange to sort in ascending or descending 
  lifeExp_bycountry %>% arrange(mean_lifeExp) 
  lifeExp_bycountry %>% arrange(desc(mean_lifeExp))
  
  gapminder %>% 
    filter(year == 2007) %>%
    count(continent)
  #finding what years we have data for
  unique(gapminder$year)
  summarize(
    mean_life = mean(gapminder$lifeExp),
    se_life = sd(lifeExp)/sqrt(n())
  )
  
  #using mutate
gdp_pop_summary <- gapminder %>% 
  mutate(gdp_billions = gdpPercap*pop/10^9) %>%
  group_by(continent,year) %>%
  summarize(mean_gdp_bill = mean(gdp_billions))
head(gdp_pop_summary)

# documentation, what are you doing and why
#modular code: break up code into chunks 
#insert section under code: looks nice but allows us to toggle around code 

# new section -------------------------------------------------------------
# 
# now we are in this new  section and can run this region seperately  
# describe data set so people can use it and so you can too 
# go through and really document what it means 

