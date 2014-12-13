# server.R
require(mosaic)
require(maps)
require(mapproj)
require(RColorBrewer)
twitter=read.csv("data/eqTwitter")
shinyServer(
  
  function(input, output) {
    
    Trend <- reactive({

      input$Trend 
    })
    
    Date <- reactive({
      #print(toString(input$Date))
      print(substring(input$Date,1,10))
    })

      output$twitter_map <- renderPlot({
        Trend=as.character(Trend())
        Date=as.character(Date())
        print(Trend)
        print(Date)

        test1=select(twitter, name, city, longitude, latitude, X.1)
        test1$X.1=as.character(test1$X.1)
        test2=mutate(test1, d=as.numeric(format(as.Date(test1$X.1,format="%m/%d/%y"),"%d")))
        d=as.integer(format(as.Date(Date,format="%m/%d/%y"),"%d"))
        set=c(d:(d+7))
        test2=subset(test2, d %in% set)
        test3=filter(test2, name==Trend)
        if (nrow(test3)==0){
          print("no")
          title(main="not enough data to display")
        }
        else{
        test4=summarise(group_by(test3, city), tweets=n())
        test5=unique(select(test2, city, longitude, latitude, X.1))
        test6=merge(x=test4, y=test5, by.x="city", by.y="city", all.x=FALSE)
        par(bg = "light blue")
        map("state", proj="lambert", param=c(33,45), orientation=c(90,0,-100),mar=c(0,0,0,0) , fill=TRUE, col="grey")
        projData=mapproject(test6$longitude, test6$latitude, projection="lambert", param=c(33,45), orientation=c(90,0,-100))
        head(projData)
        projLong=projData$x
        projLat=projData$y
        text(projLong,projLat, test6$city, cex=0.7, pos=2) 
        require(RColorBrewer)
        quantile(test6$tweets,seq(0,1,by=.25))
        col=colorRampPalette(c(brewer.pal(9,"OrRd")))
        #col2=col(8)[as.numeric(cut(test6$tweets, breaks=quantile(test6$tweets, seq(0,1,length=8))))]
        q=quantile(test6$tweets, seq(0,1,length=8))
        if(sum(duplicated(q))>0){
        print("no")
        title(main="not enough data to display")
        }
        else{
          col2=col(8)[as.numeric(cut(test6$tweets, breaks=quantile(test6$tweets, seq(0,1,length=8))))]
        points(projLong,projLat,col=col2, pch=19, cex=0.03*test6$tweets)
        require(SDMTools)
        pnts=cbind(x=c(0.24, 0.26, 0.26, 0.24), y=c(-0.9, -0.75, -0.9, -0.75))
        a=sort(unique(col2))
        legend.gradient(pnts, cols=a, c(max(test6$tweets), min(test6$tweets)), title="Frequency", ps=0.5)
        }
        }
      })}
      )
