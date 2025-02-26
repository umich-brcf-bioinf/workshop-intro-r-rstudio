# Welcome! We're excited to give you an introduction to R and RStudio at ABRF. 

library(tidyverse)

phenotypes_by_species = iris %>% 
    group_by(Species) %>% 
    summarize(
        mean_sepal_length = mean(Sepal.Length),
        mean_sepal_width = mean(Sepal.Width),
        mean_petal_length = mean(Petal.Length),
        mean_petal_width = mean(Petal.Width))

phenotypes_by_species

ggplot(iris, aes(x = Species, y = Petal.Width, fill = Species)) + 
    geom_boxplot() +
    theme_bw() + 
    labs(title = 'Petal Width by Species', x = 'Species' , y = 'Petal Width')
