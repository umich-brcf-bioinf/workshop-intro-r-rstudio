library(tidyverse)

# Read in the gapminder dataset
gapminder_1997 = read_csv('data/gapminder_1997.csv')


# Which African countries have a population at least 10,000,000 in 1997?
filter(gapminder_1997, continent == 'Africa' & pop >= 10000000)

# Look for countries with very large populations or very small populations?
# Less than 1,000,000 or more than 1,000,000,000
filter(gapminder_1997, pop <= 1000000 | pop >= 1000000000)

# Here's an example of a contradictory logical condition
# Less than 1,000,000 and more than 1,000,000,000
filter(gapminder_1997, pop <= 1000000 & pop >= 1000000000)

# We can add columns with the mutate() function
# Let's find GDP = pop * gdpPercap
mutate(gapminder_1997, gdp = pop * gdpPercap)

# To see the whole thing, wrap it in data.frame()
data.frame(mutate(gapminder_1997, gdp = pop * gdpPercap))
View(mutate(gapminder_1997, gdp = pop * gdpPercap))

# Let's keep this tibble around
gapminder_gdp_1997 = mutate(gapminder_1997, gdp = pop * gdpPercap)
gapminder_gdp_1997

# Let's execute our first pipe command, combining filter() and select()
gapminder_1997 %>% filter(continent == 'Oceania') %>% select(country, continent, pop)

gapminder_1997 %>% select(country, pop) %>% filter(continent == 'Oceania')
# With each transition of the %>% there is a new (hidden) table

# What is the mean population of the countries of Oceania?
gapminder_1997 %>% 
  filter(continent == 'Oceania') %>% 
  summarize(oceania_mean_pop = mean(pop))

# To take the mean over the entire data set, remove the filter part
gapminder_1997 %>% summarize(global_mean_pop = mean(pop))

# If we want to compute population means per continent, use group_by()
gapminder_1997 %>% 
  group_by(continent) %>% 
  summarize(mean_pop = mean(pop))

# How many countries do we have data for on each continent?
gapminder_1997 %>% 
  group_by(continent) %>% 
  summarize(num_countries_per_continent = n())

# The base R way to count elements of a column
table(gapminder_1997$continent)

# Let's summarize gapminder_1997 by continent, and report the min, median, and max populations for the countries on those continents.
gapminder_1997 %>% 
  group_by(continent) %>% 
  summarize(
    min_pop = min(pop),
    median_pop = median(pop),
    max_pop = max(pop)
  )

###############
# Visualization with ggplot2

# Incrementally build our plot
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') + 
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent)

# Let's log transform the x-axis values
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') + 
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) + 
  scale_x_log10()

# Let's change the colors of the points to a different set
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') + 
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_color_brewer(palette = 'Set2')

# The RColorBrewer package provides all sorts of color palettes
RColorBrewer::brewer.pal.info
RColorBrewer::display.brewer.all()

# Does population play a role in this trend?
# Let's try adding a size aesthetic to see.
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') + 
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_color_brewer(palette = 'Set2') +
  aes(size = pop)

# Let's change the scale of the population legend by dividing by 1,000,000
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') + 
  aes(y = lifeExp) + 
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_color_brewer(palette = 'Set2') +
  aes(size = pop/1000000) +
  labs(size = 'Population (in millions)') +
  labs(color = 'Continent')

# You can group common functions into a single call, with multiple arguments
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) +
  geom_point() +
  scale_color_brewer(palette = 'Set2') +
  labs(
    x = 'GDP Per Capita',
    y = 'Life Expectancy',
    color = 'Continent',
    size = 'Population (in millions)')

# Let's experiment with a boxplot
ggplot(data = gapminder_1997) + 
  aes(x = continent, y = lifeExp) +
  geom_boxplot()

# Let's add another geometry to see the individual life expectancies on top of the box plot
ggplot(data = gapminder_1997) + 
  aes(x = continent, y = lifeExp) +
  geom_boxplot() + 
  geom_point()

# Let's change geom_point() to geom_jitter()
ggplot(data = gapminder_1997) + 
  aes(x = continent, y = lifeExp) +
  geom_boxplot() + 
  geom_jitter(width = 0.15)

# Order of layers matters
ggplot(data = gapminder_1997) + 
  aes(x = continent, y = lifeExp) +
  geom_jitter(width = 0.15) +
  geom_boxplot()
  
# ggplot2 has a variety of themes
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) +
  geom_point() +
  scale_color_brewer(palette = 'Set2') +
  labs(
    x = 'GDP Per Capita',
    y = 'Life Expectancy',
    color = 'Continent',
    size = 'Population (in millions)') +
  theme_bw()

# How can we change the size of the text in the plots?
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) +
  geom_point() +
  scale_color_brewer(palette = 'Set2') +
  labs(
    x = 'GDP Per Capita',
    y = 'Life Expectancy',
    color = 'Continent',
    size = 'Population (in millions)') +
  theme_bw() + 
  theme(text = element_text(size = 16))

# How to rotate axis label text?
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) +
  geom_point() +
  scale_color_brewer(palette = 'Set2') +
  labs(
    x = 'GDP Per Capita',
    y = 'Life Expectancy',
    color = 'Continent',
    size = 'Population (in millions)') +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

library(ggrepel)
# Let's highlight Brazil, China, India, and the United States
gapminder_1997_labels = gapminder_1997 %>% 
  mutate(label = ifelse(country %in% c('Brazil', 'China', 'India', 'United States'), country, ''))
gapminder_1997_labels

# Let's do a quick sanity check to make sure our labeling is correct
gapminder_1997_labels %>% filter(label != '')

# Let's actually add the labels to the plot for the countries of interest
ggplot(data = gapminder_1997_labels) +
  aes(
    x = gdpPercap, 
    y = lifeExp, 
    color = continent, 
    size = pop/1000000,
    label = label) +
  geom_point() +
  geom_text_repel(box.padding = 0.5, max.overlaps = Inf) + 
  scale_color_brewer(palette = 'Set2') +
  labs(
    x = 'GDP Per Capita',
    y = 'Life Expectancy',
    color = 'Continent',
    size = 'Population (in millions)') +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
