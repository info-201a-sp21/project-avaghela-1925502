library("dplyr")
library("leaflet")
library("ggplot2")
library("plotly")
library("lintr")
library("tidyverse")

data_by_year_long <- read.csv("data/Spotify/data_by_year_o.csv")

data_by_year <- data_by_year_long %>% 
  select(year, popularity) 

x <- data_by_year$year
y <- data_by_year$popularity

popularity_by_year <- ggplot(data_by_year, aes(x, y)) +
  geom_point() +
  theme_minimal() +
  xlab("Year") +
  ylab ("Popularity") +
  geom_smooth(method=lm, se=FALSE)