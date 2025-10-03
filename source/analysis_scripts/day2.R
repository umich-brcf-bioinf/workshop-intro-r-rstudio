# =========================================================================
# Data visualization with ggplot
# =========================================================================

# -------------------------------------------------------------------------
# Ensure libraries and data are loaded
setwd('~/IRR')
library(tidyverse)
gm97 = read_csv('data/gapminder_1997.csv')

# Let's create our first plot
ggplot(data = gm97) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') +
  aes(y = lifeExp) +
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_color_brewer(palette = 'Set2')

# The built-in color scales from RColorBrewer
RColorBrewer::display.brewer.all()
# In tabular form
RColorBrewer::brewer.pal.info

ggplot(data = gm97) +
  aes(x = gdpPercap) +
  labs(x = 'GDP Per Capita') +
  aes(y = lifeExp) +
  labs(y = 'Life Expectancy') +
  geom_point() +
  labs(title = 'Do people in wealthier countries live longer?') +
  aes(color = continent) +
  scale_color_brewer(palette = 'Set2') + 
  aes(size = pop/1E6) +
  labs(size = 'Population (millions)') +
  labs(color = 'Continent')

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

# Preview the first few lines
head(gm)
# Preview the last few lines
tail(gm)

# See the dimensions of a table
dim(gm)

# See the structure of the data
str(gm)

# Let's jump in by trying to plot life expectancy over time
ggplot(data = gm) +
  aes(x = year, y = lifeExp, color = continent) +
  geom_point()

# This plot is okay, but what if we want to clarify it
# by showing the mean life expectancy per year for each continent?
life_exp_by_year_continent = gm %>% 
  group_by(year, continent) %>% 
  summarize(mean_life_exp = mean(lifeExp))

# Look at this resulting table
View(life_exp_by_year_continent)

# Plot the mean life expectancy per year / continent as a line graph
ggplot(data = life_exp_by_year_continent) + 
  aes(x = year, y = mean_life_exp, color = continent) +
  geom_line()

# What if we wanted to plot a line for each country, to see the trends over time?
ggplot(data = gm) + 
  aes(x = year, y = lifeExp, color = continent) +
  geom_line()

# This isn't quite what we wanted. But, if you look at the documentation, there's a group aesthetic.
ggplot(data = gm) + 
  aes(x = year, y = lifeExp, color = continent, group = country) +
  geom_line()

# How could we see the distribution of life expectancy per continent?
ggplot(data = gm) + 
  aes(x = continent, y = lifeExp) + 
  geom_boxplot() +
  geom_jitter(width = 0.15)

# Maybe geom_violin() is better here
# Here we can control width and size to make it nicer
ggplot(data = gm) + 
  aes(x = continent, y = lifeExp) + 
  geom_violin() + 
  geom_jitter(width = 0.1, alpha = 0.5)

ggplot(data = gm) + 
  aes(x = continent, y = lifeExp) + 
  geom_jitter(width = 0.1, alpha = 0.5) +
  geom_violin(alpha = 0.5)

# How can we create a histogram of life expectancy?
ggplot(data = gm97) + 
  aes(x = lifeExp) +
  geom_histogram(binwidth = 5)

# How can we split a plot into different facets on a categorical variable? In other words, how can we split this plot to see the relationship per continent?
ggplot(data = gm97) + 
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point() +
  facet_wrap(vars(continent))

# You may prefer to have the continents stacked so that each plot occurs in its own row
ggplot(data = gm97) + 
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point() +
  facet_grid(rows = vars(continent))

?ggsave

# Let's save the previous plot
ggsave(filename = 'results/figures/first_saved_plot.png', height = 6, width = 6, units = 'in', dpi = 300)

# Save our very nice plot as object
scatter_plot = ggplot(data = gm97) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) + 
  geom_point() + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?')
# View the plot
scatter_plot

# Save this scatter_plot
ggsave(filename = 'results/figures/nice_scatterplot.png', plot = scatter_plot, width = 8, height = 8, units = 'in', dpi = 300)

# There are built-in themes that control axes backgrounds, borders, etc.
scatter_plot + theme_bw()

# How can I rotate x-axis labels by 90 degrees?
scatter_plot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# How can I label certain countries on this plot next to their data point?
library(ggrepel)

# We are going to add another column to this table, where countries not of interest have '' and the countries of interest are have their country names
# Let's label Brazil, China, India, United States
gm97_labels = gm97 %>% 
  mutate(label = ifelse(country %in% c('Brazil', 'China', 'India', 'United States'), country, ''))
View(gm97_labels)

# Let's add to the existing code to get our text labels
ggplot(data = gm97_labels) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000, label = label) + 
  geom_point() + 
  geom_text_repel(box.padding = 0.5, max.overlaps = Inf) + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?')

# If you get into a funny plotting state, try resetting the graphical output with
dev.off()

# Let's de-couple the color and size from the labels
ggplot(data = gm97_labels) + 
  aes(x = gdpPercap, y = lifeExp, label = label) + 
  geom_point(aes(color = continent, size = pop/1000000)) + 
  geom_text_repel(box.padding = 0.5, max.overlaps = Inf) + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?')

# Adjusting the box.padding made each label have a leader
ggplot(data = gm97_labels) + 
  aes(x = gdpPercap, y = lifeExp, label = label) + 
  geom_point(aes(color = continent, size = pop/1000000)) + 
  geom_text_repel(box.padding = 1, max.overlaps = Inf) + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?')

ggsave(filename = 'results/figures/fancy_plot.pdf', height = 8, width = 8, units = 'in', dpi = 300)

# Chris's suggestion
p = ggplot(data = gm97_labels) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000, label = label) + 
  geom_point() + 
  scale_color_brewer(palette = 'Set1') + 
  labs(x = 'GDP Per Capita', y = 'Life Expectancy', color = 'Continent', size = 'Population (in millions)',
       title = 'Do people in wealthier countries live longer?')

plotly::ggplotly(p)
