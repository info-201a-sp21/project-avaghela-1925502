library("shiny")
library("ggplot2")
library("plotly")
library("shinyWidgets")
library("styler")

# Central ui chunk
# ui <- fluidPage(
#   includeCSS("style.css"),
#   navbarPage(
#     "Music Data",
#     tabPanel(
#       "Overview",
#       titlePanel("How Has Music Changed Over the Past Century?"),
#       tab_overview
#     ),
#     tabPanel(
#       "Music Popularity by Year",
#       titlePanel("Music Popularity"),
#       tab_1,
#       setBackgroundColor("#F0F8FF")
#     ),
#     tabPanel(
#       "Danceability vs. Instrumentalness",
#       titlePanel("Danceability vs. Instrumentalness"),
#       tab_2
#     ),
#     tabPanel("Trend of Loudness Feature",
#              titlePanel("Music Loudness from 1921 to 2020"),
#              tab_3),
#     tabPanel("Summary", tab_4)
#   )
# )



# Overview Tab

tab_overview <- sidebarLayout(
  sidebarPanel(
    tags$div(
      id = "overview_paragrah",
      "As a group we decided to explore the development of music throughout the past century. The reason why we decided
      to do this was that we all had an interest in this field. Collectively we wanted to address key questions
      relating to how music has evolved over time such as, popularity, loudness, and
      danceability/instrumenalness. Using a ",
      a(href = 'https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks?select=data_by_year_o.csv',
        "Spotify dataset"),
      "aggregated by Yamac Eren Ay, we were able to curate visualizations to make interpreting the evolution of music
      easier"
    )
  ),
  mainPanel(
    img(src='concert.jpeg', height = '300px')
  )
)

# Tab 1

tab_1 <- sidebarLayout(
  sidebarPanel(
    sliderInput("slider", "Select Range:",
      min = 1921,
      max = 2020, value = c(1921, 2020), step = 2
    ),
    radioButtons(
      inputId = "rad_btn_c1",
      label = "Select Theme:",
      choices = list(
        "Blue" = "Blue",
        "Red" = "Red", "Green" = "Green"
      )
    )  
  ),
  mainPanel(
    plotlyOutput(
      outputId = "scatter"
    ),
    tags$div(id = "plot_1_message", 
    "  Plot 1 is a scatter plot graph that shows the trend of the popularity of music over the years. This graphs reveals how 
       music has changed along with our society with both increasing and decreasing levels of popularity. The plot includes a slider
       in which you can change what year range you are viewing for and this allows for more specific years of music to be focused on
       to find trends. The points on the plot are also interactive, showing both the year and popularity level when hovered over.",
    br(),
    br(),   
    "   This plot successfully answers and demonstrates the question of how has the popularity of music changed over time by showing 
       the relationship between music popularity and years.
       ")
  )
)

# Tab 2

tab_2 <- sidebarLayout(
  sidebarPanel(
    radioButtons( 
      inputId = "rad_btn_c2",
      label = "Select a variable(s)",
      choices = list(
        "Instrumentalness" = "Instrumentalness",
        "Danceability" = "Danceability", "Both" = "Both"
      )
    ) # this creates the button inputs
  ),
  mainPanel(
    plotlyOutput(outputId = "inst_dance_chart"), # displays the chart
    br(),
    tags$div(
      id = "plot_2_message",
      "This bar chart is designed to compare the changes in overall danceability
      of music with the changes in overall instrumentalness of music over time, 
      in order to determine whether or not there exist a relationship between the two.
      Observations from this chart reveals that from 1921 to 2020, there seems
      to be a downward trend in instrumentalness of music, while danceability
      remained relatively constant. This indicates that there might be no
      relationship between instrumentalness and danceability."
    )
  )
)

# data for loudness range

tab_3 <- sidebarLayout(
  sidebarPanel(
    h1(""),
    sliderInput(
      inputId = "yearRange",
      label = "Choose the input year",
      min = 1921,
      max = 2020,
      value = c(1921, 2020),
      step = 1
    )
  ),
  mainPanel(
    h1("Loudness Graph"),
    plotlyOutput(
      outputId = "loudness_chart"
    ),
    tags$div(id = "plot3_message",
            "The chart below visualizes how the loudness feature (dB) of music has changed
            over time. Each plot captures a specific loudness level of that year, the lines
            that connect each plot represent an increase or a decrease of that level in between
            the years, and the smooth line visualizes the overall trend of the loudness level
            over time from years 1921 to 2020.",
            br(),
            br(),
            "Users can interact with the graph by changing the input year on the slide bar widget
            , which will allow them to observe the change in loudness level during the specified year range.
            This graph helps answer how the audio feature, loudness level specifically, has developed
            over time in accordance with change in music trend and peoples' preferences")
  )
)

# Tab 4 summary

tab_4_popularity <- sidebarLayout(
  #h2("Music popularity insights from 1921 - 2021:"),
  sidebarPanel(
    tags$div(
      "This table displays the positive popularity trend throughout the 11 decades
      of data collected. This trend is beneficial in answering one of the initial 
      questions our research was intended to answer. The broader implications 
      of this insight are the affects on the music industry in the future. 
      Interestingly there is a large jump in popularity from 1940-1950 which
      increases steadily as music technology becomes more accessable to the 
      public."
    )
  ),
  mainPanel(
    tableOutput(outputId = "popularity_summary")
  )
)


tab_4_diff <-fluidPage(
  # h2("Instrumental and Danceability Insights:"),
  plotOutput(
    outputId = "instrumental_dance_comp"
  ),
  tags$div(
    id = "difference_message", 
    "  This plot demonstrates the relationship between danceability and
    instrumentalness from 1921-2021. The points on the plot are equal to
    the difference between the measure of dancibility and the measure of
    instrumentalness recorded for that year in music. The white line 
    connecting each of the black dots shows the variation from year to 
    year in the relationship  between danceability and instrumentalness.
    The black line of best fit demonstrates that as time went on the
    difference between the two variables grew, meaning that danceability
    increased while instumentalness decreased.",
    br(),
    br(),   
    "It is interesting how much the difference varried until about 
    1960 when, as the graph shows, the difference varried only slightly
    and stayed very closely to the best fit line. The broader implication
    that table demonstrates is that throughtout the past 11 decades, 
    music has become much more danceable and less instumental. This 
    discovery could give those in the music industry insight as to how 
    they should create music that has a better potential to sell."
  )  
)
  
tab_4_loudness <- sidebarLayout(
  #h2("Music loudness insights from 1921 - 2021:"),
  sidebarPanel(
    tags$div(
      "This table displays the loudness trends throughout the 11 decades
      of data collected. The loudness data is collected in a range of values
      from -60 to 0 with the loudest being 0 and the quietest being -60. 
      Throughout the first few decades, up until 1960, music loudness tended
      to fluxuate from 16.00 to 14.00. However, following 1960, music got
      slowly louder until the 2000 when it got drastically louder from 10.00
      to 7.50. The broader implications of this information
      could be useful for those in the music industry along with those 
      researching the effects of increasingly loud music on people's hearing."
    )
  ),
  mainPanel(
    tableOutput(outputId = "loudness_summary")
  )
)

tab_4 <- tabsetPanel(
  tabPanel(
    "Popularity Insights", 
    titlePanel("Music popularity insights from 1921 - 2021:"),
    tab_4_popularity
  ),
  tabPanel(
    "Dancibility/Instrumentalness Insights", 
     titlePanel("Instrumental and Danceability Insights:"),
     tab_4_diff
  ),
  tabPanel(
    "Loudness Insights",
     titlePanel("Music loudness insights from 1921 - 2021:"),
     tab_4_loudness
  )
)
ui <- fluidPage(
  #includeCSS("style.css"),
  navbarPage(
    "Music Data",
    tabPanel(
      "Overview",
      titlePanel("How Has Music Changed Over the Past Century?"),
      tab_overview
    ),
    tabPanel(
      "Music Popularity by Year",
      titlePanel("Music Popularity"),
      tab_1,
      setBackgroundColor("#F0F8FF")
    ),
    tabPanel(
      "Danceability vs. Instrumentalness",
      titlePanel("Danceability vs. Instrumentalness"),
      tab_2
    ),
    tabPanel("Trend of Loudness Feature",
             titlePanel("Music Loudness from 1921 to 2020"),
             tab_3),
    tabPanel("Summary", tab_4)
  )
)
