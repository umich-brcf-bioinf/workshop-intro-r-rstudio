# install.packages("remotes")
# library(remotes)
# remove.packages('klippy');
# remotes::install_github("umich-brcf-bioinf/workshop-klippy");
# install.packages("kable")
# devtools::install_github("haozhu233/kableExtra")

library(rmarkdown)
library(klippy)
library(kableExtra)

# The html from the files below don't have the nav bar

render('source/workshop_setup/preworkshop_checklist.md', output_dir='html/workshop_setup/')
render('source/workshop_setup/setup_instructions.Rmd', output_dir='html/workshop_setup/')
render('source/workshop_setup/setup_instructions_advanced.md', output_dir='html/workshop_setup/')

# The html from the files below do have the nav bar, so if you make changes 
# that impact the navbar (e.g. file name changes or reordering) you should 
# re-knit all of them.

#render_site('source/instructor-cheatsheet.Rmd');
#render_site('source/analysis-scripts.Rmd');
render_site('source/index.md')
render_site('source/workshop-intro.Rmd')

render_site('source/r-01-introduction.Rmd')
render_site('source/r-02-exploration-dplyr.Rmd')
render_site('source/r-04-bioconductor.Rmd')
render_site('source/r-05-help.Rmd')
render_site('source/r-03-exploration-ggplot.Rmd')

render_site('source/irr-on-great-lakes.Rmd')
render_site('source/workshop-wrap-up.Rmd')
render_site('source/analysis_scripts.Rmd')


#clean_site(preview=TRUE)
