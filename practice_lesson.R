#practice for lesson
#episode 8 for creating publication quality graphics with ggplot2


#open ggplot2 library
library("ggplot2")

#initiate new variable called gapminder, to read gapminder file in data
gapminder <- read.csv("data/gapminder_data.csv", header = TRUE)

#visually inspect gapminder

#data subetting
gapminder[1,1]

#preview top few lines 
head(gapminder)

#preview bottom few lines 
tail(gapminder)

#let's look at the middle
gapminder[900:905, ]

#call ggplot function to create new plot, GLOBAL option, applies to ALL 
#aes - aesthetic properties, x and y locations; look for column heading 
#geom - this layer tells how we want to visually represent data (geom_point - scatter plot)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()

#easy challenge 1
#modify the line belwo to show how life expectancy has changed over time
ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_col()

#medium challenge 2
#aesthetic prop of color 
#modify code to color the points by the continent column, what trends do you see? are they expected?
ggplot(data = gapminder, aes(x = year, y = lifeExp, color = continent)) + geom_point()

#use a line plot to look at individual countries
ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) + geom_line()

#add column of countries as characters instead of factors 
countries_char <- as.character(gapminder$country)
gapminder2 <- cbind(gapminder, countries_char)
View(gapminder2)
ggplot(data = gapminder2, aes(x = year, y = lifeExp, by = countries_char, color = continent)) + geom_line()
#plots came out the same for countries read as factors vs char

#visualize both lines and points , change point color
#add another layer
ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) + geom_line() + geom_point(color='black')

#add themes and change line colors
ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) + geom_line(color='blue') + geom_point() + theme_bw()

#switch order of point and line layers 
ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) +  geom_line(color='blue') + geom_point(color='black') 
ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) + geom_point(color='black') + geom_line(color='blue') 

#transformation and stats
#overlay stat models over data , color by continent
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) + geom_point()

#use scale and alpha functions (change x and transparency)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) + geom_point(alpha = 0.5) + scale_x_log10()

#geom_smooth, adding another layer here --- trend lines
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  geom_smooth(method ="lm" ,  size = 1.5 )

#Challenge
#modify color and size of points on the point layer in the previous example w/o using aes function
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(color = "purple", alpha = 0.5, size = 1, shape = 17 ) +
  scale_x_log10() +
  geom_smooth(method ="lm")

#saving the plot
#need to create a results folder 

starts.with <- substr(gapminder$country, start = 1, stop = 1)
az.countries <- gapminder[starts.with %in% c("A", "Z"), ]
ggplot(data = az.countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country)

ggplot(data = az.countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())

lifeExp_plot <- ggplot(data = az.countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
ggsave(filename = "results/lifeExp.png", plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")
