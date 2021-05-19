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



popularity_by_year <- function(df) {
  ggplot(data = df, aes(x, y)) +
  geom_point() +
  theme_minimal() +
  ggtitle("Change in Music Popularity over the Years") +
  xlab("Year") +
  ylab ("Popularity") +
  geom_smooth(method=lm, se=FALSE)
}

