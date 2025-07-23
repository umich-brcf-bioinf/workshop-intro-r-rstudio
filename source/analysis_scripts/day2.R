# =========================================================================
# Data Transformation with dplyr
# =========================================================================

# -------------------------------------------------------------------------
# Ensure libraries and data are loaded

library(tidyverse)
gm97 = read_csv('data/gapminder_1997.csv')

# Filter the data for countries in Africa
filter(gm97, continent == 'Africa')

# To see the entire table
data.frame(filter(gm97, continent == 'Africa'))

# Base R way to do the same thing
gm97[ gm97$continent == 'Africa', ]

# Answer to the exercise
filter(gm97, country == 'United Kingdom')

# Filter the data for African countries with populations > 10M
filter(gm97, continent == 'Africa' & pop >= 10000000)

# Filter for high population and low population countries
filter(gm97, pop <= 1000000 | pop >= 1000000000)

# What if we create a "contradictory" logical condition?
filter(gm97, pop <= 1000000 & pop >= 1000000000)

# If we want to add a column that combines information across columns, use mutate
mutate(gm97, gdp = pop * gdpPercap)

# Save the resulting table as a new object
gm97_gdp = mutate(gm97, gdp = pop * gdpPercap)
gm97_gdp

# Add a column that doesn't rely on existing data
mutate(gm97, hello = 'hello')

# Preview any number of lines, here, 20
print(gm97_gdp, n = 20)

# The pipe operator, let's you combine these functions intuitively
# Filter for countries in Oceania, then show a subset of the columns
gm97 %>% filter(continent == 'Oceania') %>% select(country, continent, pop)

# Exercise, does this work?
gm97 %>% 
  select(country, pop) %>% 
  filter(continent == 'Oceania')
# NO, but this does:
gm97 %>% 
  select(country, continent, pop) %>% 
  filter(continent == 'Oceania')

gm97 %>% filter(continent == 'Oceania') %>% select(country, pop)

# What is the mean of the populations of the countries on Oceania?
gm97 %>% filter(continent == 'Oceania') %>% summarize(mean_pop = mean(pop))

# Do the same thing, but on the whole dataset
gm97 %>% summarize(mean_pop = mean(pop))

# Rather than repeating the code for Oceania for each continent, use group_by()
# Compute the mean population per continent
gm97 %>% group_by(continent) %>% summarize(mean_pop = mean(pop))

# How many countries are on each continent?
gm97 %>% group_by(continent) %>% summarize(num_countries_per_continent = n())

# Here's the base R version of the above
table(gm97$continent)

# Report multiple summaries in a single table
gm97 %>% group_by(continent) %>% 
  summarize(mean_pop = mean(pop), n_countries = n())

# Let's recapitulate the result of summary() using summarize()
# and let's do it on the population column, and save it as an object
gm97_pop_stats = gm97 %>% 
  group_by(continent) %>% 
  summarize(
    min_pop = min(pop),
    median_pop = median(pop),
    mean_pop = mean(pop),
    max_pop = max(pop)
  ) %>% 
  arrange(median_pop)
gm97_pop_stats

# Write the resulting table to file
write_csv(gm97_pop_stats, file = 'results/tables/gm97_pop_stats.csv')

# ------------------------------------------------------------

# Let's create our first plot with the gm97 data
ggplot(data = gm97)

# Iteratively building our plot
ggplot(gm97) + 
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') +
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_x_log10()

# Iteratively building our plot
ggplot(gm97) + 
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') +
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_color_brewer(palette = 'Set2')

# RColorBrewer has a lot of color scales
RColorBrewer::display.brewer.all()
RColorBrewer::brewer.pal.info

# Iteratively building our plot
ggplot(gm97) + 
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') +
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  aes(size = pop / 1000000) + 
  labs(color = 'Continent', size = 'Population (in millions)')

# -------------------------------------------------------------------------
# Recapitulate the above plot with more concise code

ggplot(data = gm97) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) + 
  geom_point() + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?')

# -------------------------------------------------------------------------
# Read in full gapminder dataset

gm = read_csv('data/gapminder_data.csv')

# Let's plot mean life expectancy per continent over time
# First, let's summarize life expectancy per year per continent
summarized_life_exp = gm %>% 
  group_by(year, continent) %>% 
  summarize(mean_life_exp = mean(lifeExp))
summarized_life_exp

# Create a line graph of this underlying table
ggplot(summarized_life_exp) +
  aes(x = year, y = mean_life_exp, color = continent) +
  geom_line()

# Let's save this plot
ggsave(
  filename = 'results/figures/mean_life_exp_per_continent.png',
  width = 8,
  height = 4,
  units = 'in',
  dpi = 300
)

# Let's rotate the x-axis labels for this plot
ggplot(data = gm97) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) + 
  geom_point() + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
