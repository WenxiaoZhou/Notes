# Data Manipulation with dplyr

# (1)Transforming Data with dplyr
#Understanding the data
library(dplyr)
help(glimpse) #within dplyr package
setwd("/Users/zhouwenxiao/Desktop/Study/R/Datacamp/Data Analyst with R/Data Manipulation with dplyr")
counties<-readRDS("counties.rds")
#take a look at data using glimpse() function
glimpse(counties)
#select columns
#select 'state','county','population','poverty' columns
counties %>% select(state,county,population,poverty)


#arrange observations
#sort the selected table using `public_work` variable in descending order
counties_selected <- counties %>%
  select(state, county, population, private_work, public_work, self_employed)
counties_selected %>%
  arrange(desc(public_work))


#filter for conditions
#find only the counties that have a population above one million(1000000)
#and also only state of California
counties_selected %>%
  filter(population>1000000,state=='California')
#Finally, you can combine multiple conditions together in a filter

#filter & arrange together
counties_selected %>%
  # Filter for Texas and more than 10000 people
  filter(state=="Texas", population>10000) %>%
  # Sort in descending order of private_work
  arrange(desc(private_work))

#calculate the number of government employees
#within the counties data frame, unemployment is a percentage variable, same 
#as public_work variable
counties_selected<-counties %>%
  select(state, county, population, public_work)
counties_selected %>% 
  # add a new column public_workers with the number of people employed in public work
  mutate(public_workers=population*public_work/100) %>%
  # sort in descending order of the public_workers column
  arrange(desc(public_workers))

#calculate the percentage of women in a county
counties_selected <- counties %>%
  # Select the columns state, county, population, men, and women
  select(state,county,population,men,women)
counties_selected %>%
  mutate(proportion_women=women/population)

counties %>%
  # Select the five columns 
  select(state,county,population,men,women) %>%
  # Add the proportion_men variable
  mutate(proportion_men=men/population) %>%
  # Filter for population of at least 10,000
  filter(population>=10000) %>%
  # Arrange proportion of men in descending order
  arrange(desc(proportion_men))



# (2) Aggregating Data
#counting by region
#Finding the number of counties in each region
counties_selected <- counties %>%
  select(county, region, state, population, citizens)
counties %>%
  count()
counties %>% 
  count(state)
counties_selected %>%
  count(region,sort=TRUE)
#Count the number of counties in each state, weighted based on the `citizens` column, and sorted in descending order
counties_selected <- counties %>%
  select(county, region, state, population, citizens) %>%
  count(state,wt=citizens,sort=TRUE)
counties_selected

#walk: which offers a percentage of people in each county that walk to work, to add a new column and count based on it
counties_selected <- counties %>%
  select(county, region, state, population, walk)
counties_selected %>%
  # Add population_walk containing the total number of people who walk to work 
  mutate(population_walk = population * walk / 100) %>%
  # Count weighted by the new column, sort in descending order
  count(state, wt = population_walk, sort = TRUE)

#summarizing
counties_selected <- counties %>%
  select(county, population, income, unemployment)
#summarize the counties dataset to find the following columns:
#min_population (smallest population)
#max_unemployment (maximum unemployment)
#average_income (mean of the income variable)
counties_selected %>%
  # Summarize to find minimum population, maximum unemployment, and average income
  summarize(min_population=min(population),
            max_unemployment=max(unemployment),
            average_income=mean(income))

#summarize by state
#land_area: shows the land area in square miles
#summarize both population and land area by state, and
#find the density (in people per square miles)
counties_selected <- counties %>%
  select(state,county, population, land_area)
counties_selected %>%
  group_by(state) %>%
  summarize(total_area = sum(land_area),
            total_population = sum(population)) %>%
  # Add a density column (people per square mile)
  mutate(density=total_population/total_area) %>%
  # Sort by density in descending order
  arrange(desc(density))

#summarize by state and region
counties_selected <- counties %>%
  select(region, state, county, population)
counties_selected %>%
  # Group and summarize to find the total population
  group_by(region, state) %>%
  summarize(total_pop = sum(population)) %>%
  # Calculate the average_pop and median_pop columns 
  # Notice that the tibble is still grouped by region, use another 
  # summarize() step to add more columns under this grouping
  
  #the average state population in each region
  #the median state population in each region 
  summarize(average_pop=mean(total_pop),
            median_pop=median(total_pop))
#The final result includes four regions' average population and median population by two columns


#selecting a county from each region
counties_selected <- counties %>%
  select(region, state, county, metro, population, walk)
#Find the county in each region with the highest percentage of citizens who walk to work
counties_selected %>%
  group_by(region) %>%
  top_n(1,walk)

#finding the highest income state in each region
#group_by(), summarize(), top_n()
counties_selected <- counties %>%
  select(region, state, county, population, income)
counties_selected %>%
  group_by(region, state) %>%
  # Calculate average income
  summarize(average_income=mean(income)) %>%
  # Find the highest income state in each region
  top_n(1,average_income)
# From our results, we can see that the New Jersey in 
# the Northeast is the state with the highest 
# average_income of 73014.


#Using summarize, top_n,count together
#Answer the following questions:
# In How many states do more people live in metro areas than non-metro areas?
counties_selected <- counties %>%
  select(state, metro, population)
c3<-counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  # Extract the most populated row for each state
  top_n(1, total_pop) %>%
  # Count the states with more people in Metro or Nonmetro areas
  ungroup()   %>%
  # (firstly, since most data operations are done on groups defined by variables. group_by() takes an existing table and converts it into a grouped tbl where operations are performed "by group". ungroup() removes grouping.)
  count(metro)


# (3)Selecting and Transforming Data
#using a colon (:) can select variables that are consecutive
counties %>%
  # Select state, county, population, and industry-related columns
  select(state,county,population,professional:production) %>%
  # Arrange service in descending order 
  arrange(desc(service))
#use starts_with(), ends_with(), which finds the columns that end with a particular string
counties %>%
  # Select the state, county, population, and those ending with "work"
  select(state,county,population,ends_with("work")) %>%
  # Filter for counties that have at least 50% of people engaged in public work
  filter(public_work>=50)
counties %>%
  select(state,county,population,unemployment_rate=unemployment)
counties %>% 
  select(state,county,population,unemployment)  %>%
  rename(unemployment_rate=unemployment)
#renaming a column after counting 
counties %>%
  # Count the number of counties in each state
  count(state) %>%
  # Rename the n column to num_counties
  rename(num_counties=n)
#renaming a column as part of a select
counties %>%
  # Select state, county, and poverty as poverty_rate
  select(state,county,poverty_rate=poverty)


#Using transmute
counties %>%
  # Keep the state, county, and populations columns, and add a density column
  transmute(state,county,population,density=population/land_area) %>%
  # Filter for counties with a population greater than one million 
  filter(population>1000000) %>%
  # Sort density in ascending order 
  arrange(density)
#Choosing among the four verbs
# Change the name of the unemployment column
counties %>%
  rename(unemployment_rate = unemployment)
# Keep the state and county columns, and the columns containing poverty
counties %>%
  select(state, county, contains("poverty"))
# Calculate the fraction_women column without dropping the other columns
counties %>%
  mutate(fraction_women = women / population)
# Keep only the state, county, and employment_rate columns
counties %>%
  transmute(state, county, employment_rate = employed / population)



# (4) Case Study: The babynames Data Set
#Understanding the data
babynames<-readRDS("babynames.rds")
#take a look at data using glimpse() function
library(dplyr)
glimpse(babynames)
babynames %>%
  # Filter for the year 1990
  filter(year==1990) %>%
  # Sort the number column in descending order 
  arrange(desc(number))
#using top_n with babynames to find the most common name in each year
babynames %>%
  group_by(year) %>%
  top_n(1,number)
selected_names <- babynames %>%
  # Filter for the names Steven, Thomas, and Matthew 
  filter(name %in% c('Steven','Thomas','Matthew'))
library(ggplot2)
selected_names <- babynames %>%
  # Filter for the names Steven, Thomas, and Matthew 
  filter(name %in% c("Steven", "Thomas", "Matthew"))

# Plot the names using a different color for each name
ggplot(selected_names, aes(x = year, y = number, color = name)) +
  geom_line()


# Calculate the fraction of people born each year with the same name
babynames %>%
  group_by(year) %>%
  mutate(year_total = sum(number)) %>%
  ungroup() %>%
  mutate(fraction = number / year_total) %>%
  # Find the year each name is most common
  group_by(name) %>%
  top_n(1,fraction)


babynames %>%
  # Add columns name_total and name_max for each name
  group_by(name) %>%
  # name_total, with the sum of the number of babies born with that name in the entire dataset
  # name_max, with the maximum number of babies born in any year
  mutate(name_total=sum(number),
         name_max=max(number))

babynames %>%
  # Add columns name_total and name_max for each name
  group_by(name) %>%
  mutate(name_total = sum(number),
         name_max = max(number)) %>%
  # Ungroup the table 
  ungroup() %>%
  # Add the fraction_max column containing the number by the name maximum 
  mutate(fraction_max=(number/name_max))

names_normalized <- babynames %>%
  group_by(name) %>%
  mutate(name_total = sum(number),
         name_max = max(number)) %>%
  ungroup() %>%
  mutate(fraction_max = number / name_max)
names_filtered <- names_normalized %>%
  # Filter for the names Steven, Thomas, and Matthew
  filter(name %in% c("Steven", "Thomas","Matthew"))

# Visualize these names over time
ggplot(names_filtered,aes(x=year,y=fraction_max,color=name)) +
  geom_line()
#As you can see, the line for each name hits a peak at 1, although the peak year differs for each name



#Using ratios to describe the frequency of a name
babynames_fraction<-
  babynames %>%
  group_by(year) %>%
  mutate(year_total = sum(number)) %>%
  ungroup() %>%
  mutate(fraction = number / year_total)

babynames_fraction %>%
  # Arrange the data in order of name, then year 
  arrange(name,year) %>%
  # Group the data by name
  group_by(name) %>%
  # Add a ratio column that contains the ratio of fraction between each year 
  mutate(ratio=fraction/lag(fraction))

#Notice that the first observation for each name is 
# missing a ratio, since there is no previous year.

#Biggest jumps in a name
#to look further into the names that experienced the biggest jumps in popularity in consecutive years
babynames_ratios_filtered <- babynames_fraction %>%
  arrange(name, year) %>%
  group_by(name) %>%
  mutate(ratio = fraction / lag(fraction)) %>%
  filter(fraction >= 0.00001)
babynames_ratios_filtered %>%
  # Extract the largest ratio from each name 
  top_n(1,ratio) %>%
  # Sort the ratio column in descending order 
  arrange(desc(ratio)) %>%
  # Filter for fractions greater than or equal to 0.001
  filter(fraction>=0.001)









































