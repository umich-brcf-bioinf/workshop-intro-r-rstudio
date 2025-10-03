3+2

7+5

# =========================================================================
# Introducing R and RStudio
# =========================================================================

# -------------------------------------------------------------------------
# Get current working directory
getwd()

# Set a different working directory
setwd('~/IRR')

# -------------------------------------------------------------------------
# Create directory structure

dir.create('scripts', recursive = TRUE, showWarnings = FALSE)
dir.create('results/figures', recursive = TRUE, showWarnings = FALSE)
dir.create('results/tables', recursive = TRUE, showWarnings = FALSE)
dir.create('results/rdata', recursive = TRUE, showWarnings = FALSE)

# Load the tidyverse package
library(tidyverse)

# Load the gapminder dataset
setwd('~/IRR')
gm97 = read_csv('data/gapminder_1997.csv')

# To see what an object is, execute the name of object
gm97

# Examples of good object names
age = 26
wizard_name = 'Tom Riddle'
wizard_name = 'Harry Potter'

# Examples of bad object names
# No spaces
favorite number = 12

# Cannot start with numbers
1number = 3

# If I want '26' as a character object
character_age = '26'

# You must quote strings
bad_string = hello
good_string = 'hello'

# Object names are case-sensitive
Flower = 'marigold'
flower = 'rose'
# It's not recommended to do this

# Example of a function needs arguments
read_csv()

# Example of a function that doesn't need arguments
Sys.Date()

getwd()

# Some functions require more than one argument
round(3.1415, 2)

# How to figure out what arguments a function has / needs
?round

# Be explicit about the arguments in a function call
round(x = 3.1415, digits = 2)

# Use help.search() to find a function for chi-square test
help.search('Chi-squared test')

# An example of forgetting to close quote
read_csv('data/gapminder_1997.csv')

# An example of not closing parenthesis
round(3.1415, 2)

# Using an object as a parameter in a function
file = 'data/gapminder_1997.csv'
read_csv(file)

### Back from break
# -------------------------------------------------------------------------
# Set current working directory
setwd('~/IRR')

# -------------------------------------------------------------------------
# Create directory structure

dir.create('scripts', recursive = TRUE, showWarnings = FALSE)
dir.create('results/figures', recursive = TRUE, showWarnings = FALSE)
dir.create('results/tables', recursive = TRUE, showWarnings = FALSE)
dir.create('results/rdata', recursive = TRUE, showWarnings = FALSE)

# -------------------------------------------------------------------------
# Ensure libraries and data are loaded

library(tidyverse)
gm97 = read_csv('data/gapminder_1997.csv')

# To view an object, execute it's name
gm97

# The View() function opens a table in RStudio
View(gm97)

# Use the summary() function to summarize all columns
summary(gm97)

# What is the average life expectancy over the entire dataset?
summarize(gm97, mean(lifeExp))

# If I want to name the result in a nicer way...
summarize(gm97, avgLifeExp = mean(lifeExp))

# Find the distinct values in a column with distinct()
# This is a good way to detect data entry errors
distinct(gm97, continent)

# We may want to sort a table according to a particular column
# Which country has the highest life expectancy?
arrange(gm97, lifeExp)

# From this result, it seems like arrange() default is ascending order
# Use the desc() function
arrange(gm97, desc(lifeExp))
# Japan has the highest lifeExp

# Which country has the highest gdpPercap in 1997?
arrange(gm97, desc(gdpPercap))

# Select particular columns from a table with select()
select(gm97, country, year, lifeExp)

# Use select() to remove a particular column
# Remove the year column
select(gm97, -year)

# Let's go back and sort by multiple columns
arrange(gm97, continent, lifeExp)
View(arrange(gm97, continent, lifeExp))

# NOTE, none of the above operations have changed EITHER gm97 or the file
# We have to assign the result to a new object to save the result
gm97_subset = select(gm97, country, year, lifeExp)
gm97_subset

# The above saves the result to a new object, but if we want a file...
write_csv(gm97_subset, file = 'results/tables/gm97_subset.csv')
# Be careful about overwriting files that already exist.

# Filter the data for only countries in Africa
filter(gm97, continent == 'Africa')
View(filter(gm97, continent == 'Africa'))

# Filter the data for the United Kingdom
filter(gm97, country == 'United Kingdom')

# This doesn't filter in the way that we expect because it should be ==.
filter(gm97, country = 'United Kingdom')

# Let's find all the countries in Africa with populations >= 10M
filter(gm97, continent == 'Africa' & pop >= 10000000)

# Let's find the most and least populous countries <= 1000000 or >= 1000000000
filter(gm97, pop <= 1000000 | pop >= 1000000000)

# What happens when you provide a contradictory condition?
filter(gm97, pop <= 1000000 & pop >= 1000000000)

# Let's add a column for gdp using mutate()
mutate(gm97, gdp = pop * gdpPercap)

# Save the result as a new object
gm97_gdp = mutate(gm97, gdp = pop * gdpPercap)

# The pipe operator (%>%) allows us to combine the above functions one after the other
# The operator has a keyboard shortcut Ctrl + Shift + m (%>%)
# filter for countries in Oceania and subset the columns
gm97 %>% filter(continent == 'Oceania') %>% select(country, continent, pop)

# To exemplify the other way without pipes
gm97_2 = filter(gm97, continent == 'Oceania')
gm97_3 = select(gm97_2, country, continent, pop)

# To see how pipes work, here is an example that doesn't work
gm97 %>% select(country, pop) %>% filter(continent == 'Oceania')
# Note, this doesn't work, because we removed the continent column

# Find the mean population of the countries on Oceania
gm97 %>% filter(continent == 'Oceania') %>% summarize(mean_pop = mean(pop))

# Note the difference on the wider data
gm97 %>% summarize(mean_pop = mean(pop))

# Compute the mean population per continent using group_by()
gm97 %>% group_by(continent) %>% summarize(mean_pop = mean(pop))

# How many countries are on each continent?
gm97 %>% group_by(continent) %>% summarize(count = n())
# You can group_by() multiple columns as well, it will find all unique combos