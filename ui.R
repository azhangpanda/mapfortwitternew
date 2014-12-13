#ui
shinyUI(fluidPage(
  titlePanel("Voices of Twitter"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a trending topic and a week to make a map"),
      selectInput("Trend", 
                  label = "Choose a trending topic:",
                  choices = c("#MTVStars",
                              "Walmart", "Xbox", "Black Friday",
                              "Happy Thanksgiving","#FergusonDecision",
                              "Mockingjay","Wilson","Wendy Williams", "#HTGAWM",
                              "America","Darren Wilson","Star Wars", "Aaliyah",
                              "#SurvivorSeries", "#AMAs2014", "Odell Beckham",
                              "#AaliyahMovie", "#RHOA", "Pitbull",
                              "Starter Pack", "#Ferguson","Melvin Gordon",
                              "#LIVESOS", "Snapchat", "#Scandal",
                              "Waffle House", "#talktomematt", "Santa",
                              "Thankful", "Ray Rice", "Kim K", "#1DOrlando",
                              "Raiders", "#BreakTheInternet", "Titans", 
                              "Taylor Swift", "#MattsNewVideo", "Mike Brown",
                              "#NashsNewVideo", "Turkey", "#FailedCharities",
                              "Fergie", "Bama", "Randy Moss", "#KohlsSweeps", 
                              "#rokerthon", "Whitney", "#CometLanding"
                              ),
                  ),
      
      selectInput("Date", 
                  label = "Choose a week:",
                  choices = c("11/11/2014-11/18/2014","11/12/2014-11/19/2014","11/13/2014-11/20/2014",
                              "11/14/2014-11/21/2014","11/15/2014-11/22/2014",
                              "11/16/2014-11/23/2014","11/17/2014-11/24/2014","11/18/2014-11/25/2014",
                              "11/19/2014-11/26/2014","11/20/2014-11/27/2014",
                              "11/21/2014-11/28/2014", "11/22/2014-11/29/2014", "11/23/2014-11/30/2014"
                              ) 
                  )
      
      ),
    
    mainPanel(plotOutput("twitter_map"))
  )
))



