## Load the necessary libraries for this homework (gapminder, dplyr, ggplot2)
 
  library (gapminder)
  library (dplyr)
  library (ggplot2)

## Re-create plot #1------------------------------------------------------------
## gdpPercap on the X-axis and lifeExp on the y-axis
## Use color and points to identify continents. To do this we need to change the shapes and color by continent under the "aesthetics" portion of the geom_point command.
  
ggplot (data = gapminder, aes (x = gdpPercap, y = lifeExp, by = country)) +
    geom_point (aes(shape = continent, color = continent), size = 3) 
  
## Re-create plot #2. ----------------------------------------------------------
## First name the base plot from plot #1 as plot.1

  plot.1 <- ggplot (data = gapminder, aes (x = gdpPercap, y = lifeExp, by =   country)) +
    geom_point (aes(shape = continent, color = continent), size = 3) 
  
## log transform the gdpPercap (to lienarize the data) and add that to plot.1.  We can do this by using the coord_trans arguement in ggplot.  Name this plot "transformed.plot".
  
  transformed.plot <- plot.1 + coord_trans (x = "log10")
  transformed.plot
  
## Plot # 3: add a linear fit to the transformed.plot. -------------------------
 
  ggplot (data = gapminder, aes (x = gdpPercap, y = lifeExp)) +
    geom_point (aes(shape = continent, color = continent), size = 3) +
    coord_trans (x = "log10") +
    stat_smooth (method = "lm") + 
    ylim (20, 90)
  
## Plot #4: Plot the density functions of life expectancy for each continent. Facet by year. Alpha = .4 makes the colors translucent.-------------------------
  
  ggplot (gapminder, aes(x = lifeExp)) + 
    geom_density (alpha = .4, (aes(fill = continent, kernel = "gaussian"))) + 
                facet_wrap ( ~ year)

## Plot #5 Boxplots. Use facet_wrap to break the box plots into yearly panels.  Make each continent a different color by using colour = continent arguement in the geom_boxplot function.------------------------------------------------------
  
  ggplot (gapminder, aes(x = continent, y = lifeExp)) +
    geom_boxplot (aes(colour = continent)) + 
    facet_wrap (~ year)
  
## Plot #6.  alpha = .4 makes the colors translucent.  The fill = continent argument will make each continent a different color. 
  
  ggplot (gapminder, aes(x = lifeExp)) + 
    geom_density (aes(alpha = .4, fill = continent, kernel = "gaussian"))
  
## Plot 7. Plot the mean life expectancy on a density plot for Asia. This bit will determine the mean life expectancy for just Asia.-------------------------- 
  
  density <-
    gapminder %>%
    filter (continent == "Asia") %>%
    summarise (mean(lifeExp))

  ## this bit will filter out just Asia.  We can put this in our ggplot so we get the life expectancies of only Asia.
 
  density.asia <- gapminder %>%
    filter (continent == "Asia")

  ## Plot the lifeExp of Asia with a line for the mean life exp on top of it.  To make the plot green add the scale_fill_manual() arguement.-------------------
  
  ggplot (density.asia, aes(x = lifeExp, colour = "Asia")) +
    geom_density (aes(fill = "Asia", kernel = "gaussian")) +
    geom_vline (aes(xintercept = mean(lifeExp))) + 
    ggtitle ("Life expectancy in Asia") +
    scale_fill_manual (values = "green")
  
## Plot 8: Create a data.frame of the mean life expectancies for each continent.  

  life.exp <-
    gapminder %>%
    group_by (continent) %>%
    summarise (avg.lifeExp = mean(lifeExp))
  
  ## 8.b) plot the density plot of life expectancies for each continent and draw a vertical line to mark the mean life expectancy for each continent.
  
  ggplot (gapminder, aes(x = lifeExp)) +
    geom_density (aes(fill = continent, kernel = "gaussian")) +
    facet_wrap ( ~ continent) +
    geom_vline (aes(xintercept = mean(lifeExp)))
  
  
## Part III: Fix the mistakes
  ## load the appropriate libraries
  
  library(ggplot2)
  
  ## read the hw_gapminder data into R and name it hw_gapminder
  
  hw_gapminder <- read.csv("C:/Users/laura.ganley/Documents/R_Projects/homework/hw_gapminder.csv")
  
  ## find the mean life expectancy.
  
  mean_lifeExp <- mean(hw_gapminder$lifeExpe)
   
  ## the above code did not work.  "lifeExpe" is not a variable.  The proper code would be...
  
  mean_lifeExp.correct <- mean(hw_gapminder$lifeExp)
  mean_lifeExp.correct
  
  ## Get the first four rows, and rows 1300-1304
  
  small_set <- hw_gapminder[c(1, 2, 3, 4, 1300:1304), ('country', 'continent', 'year')]
 
  ## the above code does not work.  The parenthesis are in the wrong place.  The proper code would be...
  
  small_set <- hw_gapminder[c(1:4, 1300:1304), c('country', 'continent', 'year')]
  small_set
  
  ## find the mean gdpPercap.
 
  mean_gdp <- mean(hw_gapminder$gdpPercap)
  
  ## the above code does not work because there are NA's in the gdpPercap data.  use na.rm=TRUE to find the mean with out the NA's. 
 
  mean_gdp <- mean(hw_gapminder$gdpPercap, na.rm = TRUE)
  mean_gdp
  
  ## find the country with the maximum life expectancy.
  
  max_country <- hw_gapminder$country[which(hw_gapminder$lifeExp = max(hw_gapminder$lifeExp))]

  hw_gapminder %>%
    summarise(max.lifeExp = max(lifeExp))
    
  
  
  
  
  
  
  