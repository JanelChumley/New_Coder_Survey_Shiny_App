
require("RCurl")
require("dplyr")
require("tidyr")
require("ggplot2")
require("ggthemes")
library("shiny")

df<-read.csv("NewCoders.csv",stringsAsFactors = FALSE)

server <- shinyServer(function(input, output){
  output$plot<-renderPlot({
    filtered <-df %>%
      dplyr::select(AGE,JOBROLEINTEREST) %>%
      dplyr::filter(AGE==input$age, JOBROLEINTEREST != "null")%>%
      dplyr::group_by(AGE,JOBROLEINTEREST)%>%
      dplyr::summarize(count = n())%>%dplyr::arrange(desc(count))
    ggplot(filtered,aes(x= filtered$JOBROLEINTEREST, y = filtered$count, fill=filtered$JOBROLEINTEREST))  + geom_bar(stat="identity")+ theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position="none")+ylim(0,150) + labs(x = "JOB INTEREST", y = "COUNT")})
  
  output$summary<-renderPrint({
    filtered <-df %>%
      dplyr::select(AGE,JOBROLEINTEREST) %>%
      dplyr::filter(AGE!="null", JOBROLEINTEREST != "null")%>%
      dplyr::group_by(AGE, JOBROLEINTEREST) %>%
      dplyr::summarize(count = n())%>%dplyr::arrange(desc(count))
    summary(filtered)
  })
})

