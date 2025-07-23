3 + 2

6 + 8

6 + 8

# =========================================================================
# Introducing R and RStudio
# =========================================================================

# -------------------------------------------------------------------------
# Get current working directory
getwd()

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
# Load the tidyverse package

library(tidyverse)

# -------------------------------------------------------------------------
# Load the gapminder 1997 data

gm97 = read_csv('data/gapminder_1997.csv')

# -------------------------------------------------------------------------
# Examples of good variable names, and writing over an existing variable

age = 26
age

wizard_name = 'Tom Riddle'
wizard_name

wizard_name = 'Harry Potter'
wizard_name

# CamelCase is another way to name long variable names

# -------------------------------------------------------------------------
# Error: Example of variable name with space

favorite number = 12

# -------------------------------------------------------------------------
# Error: Example of variable name beginning with number

1number = 3

# -------------------------------------------------------------------------
# Example of case-sensitivity of variable names

Flower = 'marigold'
Flower

flower = 'rose'
flower

# -------------------------------------------------------------------------
# Example of camelCase variable name

favoriteNumber = 12
favoriteNumber

# -------------------------------------------------------------------------
# Example of a function that needs arguments to function

read_csv()

# -------------------------------------------------------------------------
# Examples of functions with no required arguments
Sys.Date()

getwd()

# -------------------------------------------------------------------------
# Example of a function with multiple arguments
round(3.1415, 2)

# -------------------------------------------------------------------------
# Put a "?" in front of a function to see it's manual page

?round

# -------------------------------------------------------------------------
# Example of named arguments

round(x = 3.14159, digits = 2)

# -------------------------------------------------------------------------
# Use help.search() when the name of the function isn't known

help.search('Chi-squared test')

# -------------------------------------------------------------------------
# Example of not closing quotes

#read_csv('data/gapminder_1997.csv)

# -------------------------------------------------------------------------
# Example of not closing parentheses

#round(3.1415, 2

# =========================================================================
# Data Transformation with dplyr
# =========================================================================

# -------------------------------------------------------------------------
# Ensure libraries and data are loaded

library(tidyverse)
gm97 = read_csv('data/gapminder_1997.csv')

# -------------------------------------------------------------------------
# Preview the data

gm97

# -------------------------------------------------------------------------
# Summarize all column values

summary(gm97)

# -------------------------------------------------------------------------
# Calculate the mean life expectancy over the dataset

summarize(gm97, avgLifeExp = mean(lifeExp))

summarize(gm97, mean(lifeExp))

# -------------------------------------------------------------------------
# Base R approach to calculating the mean life expectancy

mean(gm97$lifeExp)
# mean(data.frame(gm97[, 5]))

# Cody's question about rounding the result
round(mean(gm97$lifeExp))

summarize(gm97, avgLifeExp = round(mean(lifeExp)))

# Protip: As often as you can, reference columns by their names

# -------------------------------------------------------------------------
# Determine the distinct continents present in the dataset

distinct(gm97, continent)

# -------------------------------------------------------------------------
# Base R approach to determining the distinct continents

unique(gm97$continent)

# -------------------------------------------------------------------------
# Sort the data by life expectancy
# NOTE: Default is ascending order

arrange(gm97, lifeExp)

# -------------------------------------------------------------------------
# Sort the data by descending life expectancy

arrange(gm97, desc(lifeExp))

# Note: You can arrange by multiple columns to break ties
arrange(gm97, desc(lifeExp), gdpPercap)

arrange(gm97, desc(gdpPercap))

# -------------------------------------------------------------------------
# Select country, year, and lifeExp columns from the table

select(gm97, country, year, lifeExp)

# -------------------------------------------------------------------------
# Remove the year column

select(gm97, -year)

# -------------------------------------------------------------------------
# Create a new table by selecting columns of an existing table

gm97_subset = select(gm97, country, year, lifeExp)
gm97_subset

# -------------------------------------------------------------------------
# Write the subsetted table to file

write_csv(gm97_subset, file = 'results/tables/gm97_subset.csv')

# Raymond was doing this:
mean(data.frame(gm97[,5]))
#. but wanted to do this:
mean(data.frame(gm97)[,5])
# Sorry about this!