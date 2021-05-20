## call function in index .rmd
rm(list = ls())
library(lintr)
library(styler)
library(dplyr)
library(scales)
library(forestmangr)
library(stringr)
data_by_year <- read.csv("data/Spotify/data_by_year_o.csv")

table_summary <- function(df){
df <- data_by_year %>%
  mutate(
    decade = floor(year / 10) * 10,
    duration_minutes = round(duration_ms / 60000, 2),
    acousticness_pct = acousticness * 100,
    danceability_pct = danceability * 100,
    energy_pct = energy * 100,
    instrumentalness_pct = instrumentalness * 100,
    liveness_pct = liveness * 100
  ) %>%
  group_by(decade) %>%
  summarise_all(mean) %>%
  mutate(
    key = round(key),
    tempo = round(tempo)
  ) %>%
  select(
    decade, acousticness_pct, danceability_pct, energy_pct,
    instrumentalness_pct, liveness_pct, loudness, tempo, key,
    duration_minutes
  )

df <- round_df(df, 1)

df <- df %>%
  rename(
    Decade = decade,
    Acousticness = acousticness_pct,
    Danceability = danceability_pct,
    Energy = energy_pct,
    Instrumentalness = instrumentalness_pct,
    Liveness = liveness_pct,
    "Loudness (dB)" = loudness,
    "Tempo (BPM)" = tempo,
    Key = key,
    "Duration (minutes)" = duration_minutes
  ) %>% 
  mutate(
    Acousticness = paste0(Acousticness, "%"),
    Danceability = paste0(Danceability, "%"),
    Energy = paste0(Energy, "%"),
    Instrumentalness = paste0(Instrumentalness, "%"),
    Liveness = paste0(Liveness, "%")
  ) 
return(df)
}
