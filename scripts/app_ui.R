library("shiny")
library("ggplot2")
library("plotly")
library("shinyWidgets")
library("styler")



# Central ui chunk

ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Music Data",
    # tabPanel(
    #   "Overview",
    #   titlePanel("How Has Music Changed Over the Past Century?"),
    #   tab_overview
    # ),
    tabPanel(
      "Music Popularity by Year",
      titlePanel("Music Popularity"),
      tab_1,
      setBackgroundColor("#F0F8FF")
    ),
    tabPanel("Tab 2", tab_2),
    tabPanel("Trend of Loudness Feature",
             titlePanel("Music Loudness from 1921 to 2020"),
             tab_3)#,
    # tabPanel("Summary", tab_4)
  )
)
# Overview Tab
tab_overview <- sidebarLayout(
  sidebarPanel(
    HTML("<p>
        As a group we decided to explore the development of music throughout the past century. The reason why we decided
          to do this was that we all had an interest in this field. Collectively we wanted to address key questions
          relating to how music has evolved over time such as, popularity, loudness, and
          danceability/instrumenalness. Using a <a href = 'https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks?select=data_by_year_o.csv'>
          Spotify dataset</a> aggregated by Yamac Eren Ay, we were able to curate visualizations to make interpreting the evolution of music
          easier
      </p>")
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
      inputId = "rad_btn_c2", # this means radio button chart 2
      label = "Select a variable(s)",
      choices = list(
        "Instrumentalness" = "Instrumentalness",
        "Danceability" = "Danceability", "Both" = "Both"
      )
    ) # ,
    # dateRangeInput(
    #   inputId = "date_rng_c2", # date range input chart 2
    #   label = "Choose a date range",
    #   format = "yyyy",
    #   start = "1921-01-01",
    #   end = "2020-01-01",
    #   min = "1921-01-01",
    #   max = "2020-01-01"
    # ) # date range doesn't seem to work very well
  ),
  mainPanel(
    #plotOutput(
    plotlyOutput(
      outputId = "inst_dance_chart"
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
            , which will allow them to observe the change in loudness level during the specified year range.")
  )
)

# Tab 4 summary
tab_4 <- fluidPage(tabsetPanel(
  tabPanel("tab 1", tab_4_popularity),
  tabPanel("tab 2", tab_4_difference),
  tabPanel("tab 3", "contents"))) 

tab_4_popularity <- sidebarLayout(
  sidebarPanel(
    p("Popularity of music throughout the decades")
  ),
  mainPanel(
    tableOutput(outputId = "popularity_summary")
  )
)

tab_4_difference <- sidebarLayout(
  sidebarPanel(
    h1(""),
    sliderInput(
      inputId = "years",
      label = "Choose years:",
      min = 1921,
      max = 2020,
      value = c(1921, 2020),
      step = 1
    )
  ),
  mainPanel(
    p("The calculated difference in danceability and instrumentalness 
       from 1921-2020"),
    plotlyOutput(
      outputId = "instrumental_dance_comp")
  )
)
