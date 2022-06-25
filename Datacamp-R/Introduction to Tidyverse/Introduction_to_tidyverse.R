# Introduction to the Tidyverse

# (1) Data Wrangling
setwd("/Users/zhouwenxiao/Desktop/Study/R/Datacamp/Introduction to Tidyverse")
library(gapminder)
library(dplyr)
glimpse(gapminder)
str(gapminder)

# Filter the gapminder dataset for the year 1957
gapminder %>% 
  filter(year==1957)
# Filter for China in 2002
gapminder %>%
  filter(country=='China' , year==2002)
# Filter for the year 1957, then arrange in descending order of population
gapminder %>%
  filter(year==1957) %>%
  arrange(desc(pop))


# Use mutate to change lifeExp to be in months, named it as lifeExpMonths
gapminder %>% mutate(lifeExpMonths=12*lifeExp)

#Now combine all three steps together to answer the following question:
#Find the countries with the highest life expectancy, in months, in the year 2007
# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
  filter(year==2007)  %>%
  mutate(lifeExpMonths=12*lifeExp) %>%
  arrange(desc(lifeExpMonths))


# (2) Data Visualization
library(ggplot2)
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# a scatter plot with GDP per capita on the x-axis and life expectancy on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()

#log scale
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

#color
# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952,aes(x=pop,y=lifeExp,color=continent)) +
  geom_point() +
  scale_x_log10()
#size
# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent,size=gdpPercap)) +
  geom_point() +
  scale_x_log10()

# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952,aes(x=pop,y=lifeExp)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~continent)

#faceting by year
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder,aes(x=gdpPercap,y=lifeExp,color=continent,size=pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year)



# (3) Grouping and Summarizing
library(gapminder)
library(dplyr)
#summarize() function
# Summarize to find the median life expectancy
gapminder %>%
  summarize(medianLifeExp=median(lifeExp))
# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>%
  filter(year==1957)  %>%
  summarize(medianLifeExp=median(lifeExp),
            maxGdpPercap=max(gdpPercap)) 

# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder  %>%
  filter(year==1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp=median(lifeExp),
            maxGdpPercap=max(gdpPercap))

#group by two variables combined
# Find median life expectancy and maximum GDP per capita in each continent/year combination
gapminder  %>%
  group_by(continent,year) %>%
  summarize(medianLifeExp=median(lifeExp),
            maxGdpPercap=max(gdpPercap))


by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
#Be sure to add expand_limits(y = 0) to make sure the plot's y-axis includes zero
ggplot(by_year,aes(x=year,y=medianLifeExp)) +
  geom_point() +
  expand_limits(y=0)

# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent<-gapminder  %>%
  group_by(continent,year) %>%
  summarize(medianGdpPercap=median(gdpPercap))

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent,aes(x=year,y=medianGdpPercap,color=continent)) +
  geom_point() +
  expand_limits(y=0)


# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007<- gapminder %>%
  filter(year==2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp=median(lifeExp),
            medianGdpPercap=median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007,aes(x=medianGdpPercap,y=medianLifeExp,color=continent)) +
  geom_point()




# (3) Types of Visualizations
#Visualizing median GDP per capita by continent
# Summarize the median gdpPercap by continent in 1952
by_continent<-gapminder %>%
  group_by(continent) %>%
  filter(year==1952)  %>%
  summarize(medianGdpPercap=median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent,aes(x=continent,y=medianGdpPercap)) +
  geom_col()

#Another example
#Visualizing GDP per capita by country in Oceania
# Filter for observations in the Oceania continent in 1952
oceania_1952<-gapminder %>% filter(continent=="Oceania", year==1952)
oceania_1952
# Create a bar plot of gdpPercap by country
ggplot(oceania_1952,aes(x=country,y=gdpPercap)) +
  geom_col()

#Visualizing median GDP per capita over time
# Summarize the median gdpPercap by year, then save it as by_year
by_year<- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap=median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year,aes(x=year,y=medianGdpPercap)) +
  geom_line() +
  expand_limits(y=0)


#Visualizing median GDP per capita by continent over time
# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent<-gapminder %>%
  group_by(year,continent) %>%
  summarize(medianGdpPercap=median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent,aes(x=year,y=medianGdpPercap,color=continent)) +
  geom_line() +
  expand_limits(y=0)


#Visualizing the population
gapminder_1952 <- gapminder %>%
  filter(year == 1952) %>%
  mutate(pop_by_mil = pop / 1000000)

# Create a histogram of population (pop_by_mil)
ggplot(gapminder_1952,aes(x=pop_by_mil)) +
  #set the number of bins to 50
  geom_histogram(bins=50)

#also can set "binwidth" parameter within the geom_histogram

#log scale
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952,aes(x=pop)) +
  scale_x_log10()+
  geom_histogram()



#Comparing GDP per capita across continents
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# Create a boxplot comparing gdpPercap among continents
p<-ggplot(gapminder_1952,aes(x=continent,y=gdpPercap)) +
  geom_boxplot() +
  scale_y_log10()

# Add a title to this graph
p+ggtitle("Comparing GDP per capitaacross continents")



























































































