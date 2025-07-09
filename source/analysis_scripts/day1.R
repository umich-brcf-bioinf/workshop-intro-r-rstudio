library(tidyverse)

# Read in the gapminder dataset
gm97read_csv('data/gapminder_1997.csv')

# Does it matter if you use <- or = ?
# No, they are equivalent to each other.

name = 'Ben'
name

age = 26
age

name = 'Harry Potter'

1number = 3
# Variable names cannot begin with numbers

Flower = 'marigold'
flower = 'rose'
# Variable names in R are case sensitive
# We recommend avoiding capitalization differences in variable names

favorite number = 12
# Spaces are not allowed in variable names

# Try to assign Ben to name without quotes
name = Ben
# In this case, R thinks Ben is the name of a variable, which doesn't exist

age_string = '26'
# This is a character for 26, instead of a number, it cannot be used in numerical calculations

# Guidelines on naming objects
# 1. Make them explicit and brief
# 2. Names can't start with numbers or contain spaces
# 3. Object names are case-sensitive
# 4. Use _ or . to separate words in variables names OR camelCase. Be consistent in your choice.
# 5. Some words are "protected", like if, else, etc

# Let's try read_csv() without arguments
read_csv()

# Not every function. requires arguments
Sys.Date()
getwd() # Gets the current working directory

# Some functions have more than one argument
round(3.1415, 2)

# You can get help for functions by putting ? in front of the name
?round

# It's often good to explicitly state the parameters and their values
round(x = 3.1415, digits = 2)

# Look at a more complex function
?read_csv
# There are too many parameters here to call the function positionally

# You can search for functions in "plain English"
help.search('Chi-squared test')

??`Chi-squared test`
# Does the equivalent of the above or if the package isn't loaded yet

a = 'b'
mean(a)

# Let's read in gampinder_1997 again
gm97read_csv('data/gapminder_1997.csv')
gapminder_1997

# Let's look at the summary() of gapminder_1997
summary(gapminder_1997)

# We can summarize specific columns with summarize()
summarize(gapminder_1997, avgLifeExp = mean(lifeExp))

# We can assign this to a variable with
avg_life_exp = summarize(gapminder_1997, avgLifeExp = mean(lifeExp))
avg_life_exp

# In base R you would do:
mean(gm97$lifeExp)

# The distinct() function finds unique values
distinct(gapminder_1997, continent)

# The base R way to do that
unique(gm97$continent)

# Use the arrange() function to determine which country has the highest life expectancy?
arrange(gapminder_1997, lifeExp)
# This isn't quite what we want, reverse the ordering with desc()
arrange(gapminder_1997, desc(lifeExp))
arrange(gapminder_1997, -lifeExp)

# If you want to know the column names of a data frame use colnames()
colnames(gapminder_1997)

# Which country has the highest GDP per capita in 1997?
arrange(gapminder_1997, desc(gdpPercap))
arrange(gapminder_1997, -gdpPercap)

# If you'd like to select a subset of columns use the select()
select(gapminder_1997, country, year, lifeExp)

# You can drop columns by putting a - in front of the column name
select(gapminder_1997, -year)

# Save a modified version of gapminder_1997
gapminder_column_subset = select(gapminder_1997, country, year, lifeExp)
gapminder_column_subset

# Save this modified version of gapminder
write_csv(x = gapminder_column_subset, file ='gapminder_column_subset.csv')

# select() works on columns, and filter() works on rows
# Filter for countries in Africa
filter(gapminder_1997, continent == 'Africa')

# Find the United Kingdom in this data
filter(gapminder_1997, country == 'United Kingdom')

# Which African countries have a population at least 10,000,000 in 1997?
filter(gapminder_1997, continent == 'Africa' & pop >= 10000000)

# Look for countries with very large populations or very small populations?
# Less than 1,000,000 or more than 1,000,000,000
filter(gapminder_1997, pop <= 1000000 | pop >= 1000000000)

# Here's an example of a contradictory logical condition
# Less than 1,000,000 and more than 1,000,000,000
filter(gapminder_1997, pop <= 1000000 & pop >= 1000000000)
