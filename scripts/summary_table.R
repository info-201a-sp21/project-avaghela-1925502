## call function in index .rmd
rm(list = ls())
library(lintr)
library(styler)
library(dplyr)
library(scales)
library(forestmangr)
library(stringr)
data_by_year <- read.csv("data/Spotify/data_by_year_o.csv")

table_summary <- function(df) {
  df <- data_by_year %>%
    mutate(
      decade = floor(year / 10) * 10, # convert year to decade
      duration_minutes = round(duration_ms / 60000, 2),   # ms to minutes
      acousticness_pct = acousticness * 100,
      danceability_pct = danceability * 100,
      energy_pct = energy * 100,
      instrumentalness_pct = instrumentalness * 100,
      liveness_pct = liveness * 100
    ) %>%
    group_by(decade) %>%
    summarise_all(mean) %>%
    # taking the average of all values for each decade
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
  decade_keys <- df %>% 
    pull(key)
  music_keys <- c("C", "C#/Db","D", "D#/Eb","E", "F", "F#/Gb", "G", "G#/Ab", "A", 
                  "A#/Bb","B")
  song_key <- decade_keys + 1
  common_key <- music_keys[song_key]
  df <- df %>%
    mutate(key = common_key)

  df <- df %>%
    # Labeling columns
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
    # Adding percent symbols to columns
    mutate(
      Acousticness = paste0(Acousticness, "%"),
      Danceability = paste0(Danceability, "%"),
      Energy = paste0(Energy, "%"),
      Instrumentalness = paste0(Instrumentalness, "%"),
      Liveness = paste0(Liveness, "%")
    )
  return(df)
}
test_df <- table_summary(data_by_year)
