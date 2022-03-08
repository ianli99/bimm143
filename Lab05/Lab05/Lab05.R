#' ---
#' title: "Lab 5: Data Visualization with ggplot2"
#' author: "Yushi Li (A15639705)"
#' date: "Feb 5th, 2022"
#' ---


# Lab 5 Data Visualization


# Q.1 For which phases is data visualization important in our scientific 
# workflows
# A. All of the above.


# Q.2 True or False? The ggplot2 package comes already installed with R?
# A. False


# Q.3 Which plot types are typically NOT used to compare distributions of 
# numeric variables?
# A. Network graphs


# Q.4 Which statement about data visualization with ggplot2 is incorrect?
# A. ggplot2 is the only way to create plots in R.


# install ggplot2
# install.packages(ggplot2)


# load ggplot2
library(ggplot2)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Specifying a data set with ggplot()
ggplot(cars)


# Specifing aesthetic mappings with aes()
ggplot(cars) +
  aes(x = speed, y = dist)


# Specifing a geom layer with geom_point()
ggplot(cars) + 
  aes(x = speed, y = dist) + 
  geom_point()


# Q.5 Which geometric layer should be used to create scatter plots in ggplot2?
# A. geom_point()


# Q.6 In your own RStudio can you add a trend line layer to help show the 
# relationship between the plot variables with the geom_smooth() function?
ggplot(cars) + 
  aes(x = speed, y = dist) + 
  geom_point() + 
  geom_smooth()


# Q. 7 Q. Can you finish this plot by adding various label annotations with the 
# labs() function and changing the plot look to a more conservative 
# “black & white” theme by adding the theme_bw() function:
ggplot(cars) + 
  aes(x = speed, y = dist) + 
  geom_point() + 
  labs(title = "Stopping Distances vs. Speed of Cars",
       x = "Speed (mph)",
       y = "Distance (ft)",
       subtitle = "A basic dot plot",
       caption = "Dataset: 'cars'") + 
  geom_smooth(method="lm", se=FALSE) + 
  theme_bw()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Adding more plot aesthetics through aes()
# Loading genes from URL
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)


# Q.8 Use the nrow() function to find out how many genes are in this dataset. 
# What is your answer?
nrow(genes)
# A. 5196


# Q.9 Use the colnames() function and the ncol() function on the genes data 
# frame to find out what the column names are (we will need these later) and how
# many columns there are. How many columns did you find? 
colnames(genes)
ncol(genes)
# A. 4 columns were found.


# Q.10 Use the table() function on the State column of this data.frame to find 
# out how many ‘up’ regulated genes there are. What is your answer? 
table(genes$State)
# A. 127 genes are up-regulated.


# Q.11 Using your values above and 2 significant figures. What fraction of total
# genes is up-regulated in this dataset? 
round(table(genes$State)/nrow(genes)*100, 2)
# A. 2.44% of total genes are up-regulated.


# Q.12 Complete the code below to produce the following plot:
ggplot(genes) + 
  aes(x = Condition1, y = Condition2) +
  geom_point()
# Mapping color to State
p <- ggplot(genes) + 
  aes(x = Condition1, y = Condition2, col=State) +
  geom_point()
p
# Change colors
q <- p + scale_color_manual(values = c("blue", "grey", "red"))
q


# Q.13 Nice, now add some plot annotations to the p object with the labs() 
# function so your plot looks like the following:
q + labs(title = "Gene Expression Changes upon Drug Treatment",
         x = "Control (no drug)",
         y = "Drug Treatment") +
  theme_bw()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# OPTIONAL: Going Further
# installation & loading
# install.packages("gapminder")
library(gapminder)
# alternatively, use URL to install

# install.packages("dplyr")  ## uncoment to install if needed
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)


# Q.14 Complete the code below to produce a first basic scater plot of this 
# gapminder_2007 dataset:
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp) +
  geom_point()


# adding more varables to aes()
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) +
  geom_point(alpha=0.5)

# color by pop
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, color = pop) +
  geom_point(alpha=0.8)

# adjusting point size
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, size = pop) +
  geom_point(alpha=0.5)
# changing scale
ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop), alpha=0.5) + 
  scale_size_area(max_size = 10)


# Q.15 Can you addapt the code you have leaqrned thus far to reproduce our 
# gapminder scatter plot for the year 1957? What do you notice abouyt this 
# plot is it easy to compare with the one for 2007?
gapminder_1957 <- gapminder %>% filter(year==1957)
ggplot(gapminder_1957) + 
  aes(x = gdpPercap, y = lifeExp, color=continent,
      size = pop) +
  geom_point(alpha=0.7) + 
  scale_size_area(max_size = 10) 


# Q.16 Do the same steps above but include 1957 and 2007 in your input dataset
# for ggplot(). You should now include the layer facet_wrap(~year) to produce
# the following plot:
gapminder_1957 <- gapminder %>% filter(year==1957 | year==2007)
ggplot(gapminder_1957) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, color=continent,
                 size = pop), alpha=0.7) + 
  scale_size_area(max_size = 10) +
  facet_wrap(~year)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Combining Plots (example)
# install.packages("patchwork")
library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) /
  p4


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Session info
sessionInfo()