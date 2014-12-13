twitter=read.csv("~/Documents/academic/fall 14/data science/mapfortwitter/data/eqTwitter")
#twitter
twitter_map <- function(topic, day) {
  #topic="Walmart"
  #day="11/17/2014"
  test1=select(twitter, name, city, longitude, latitude, X.1)
  test1$X.1=as.character(test1$X.1)
  test2=mutate(test1, d=as.numeric(format(as.Date(test1$X.1,format="%m/%d/%y"),"%d")))
  
  d=as.integer(format(as.Date(day,format="%m/%d/%y"),"%d"))
  set=c(d:(d+7))
  test2=subset(test2, d %in% set)
  test3=filter(test2, name==topic)
  test4=summarise(group_by(test3, city), tweets=n())
  
  test5=unique(select(test2, city, longitude, latitude, X.1))
  test6=merge(x=test4, y=test5, by.x="city", by.y="city", all.x=FALSE)
  #dotplot(tweets~city, data=test6,type=c("p", "h"), scales=list(rot=45), ylab="number of tweets")
  par(bg = "blue")
  require(maps)
  require(mapproj)
  require(RColorBrewer)
  map("state", proj="lambert", param=c(33,45), orientation=c(90,0,-100),mar=c(0,0,0,0) , fill=TRUE, col="grey")
  projData=mapproject(test6$longitude, test6$latitude, projection="lambert", param=c(33,45), orientation=c(90,0,-100))
  head(projData)
  projLong=projData$x
  projLat=projData$y
  text(projLong,projLat, test6$city, cex=0.7, pos=2)

  require(RColorBrewer)
  quantile(test6$tweets,seq(0,1,by=.25))
  col=colorRampPalette(c(brewer.pal(9,"OrRd")))
  col2=col(8)[as.numeric(cut(test6$tweets, breaks=quantile(test6$tweets, seq(0,1,length=8))))]
  
  
  points(projLong,projLat,col=col2, pch=19, cex=0.8)
#   test7=filter(twitter, name==topic)
#   test7=filter(test7, X.1==day)
#   a=summarise(group_by(test7, name), N=n())

# for (i in 1:392){
#   test6$tweets[i]=1
#   if(test6$tweets[i]%in%q[1]){
#     c=0.5
#   }else if(q[1]<test6$tweets[i]%in%q[2]){
#       c=1
#      }else if(q[2]<test6$tweets[i]%in%q[3]){
#         c=1.5
#         }else if(q[3]<test6$tweets[i]%in%q[4]){
#           c=2
#            }else if(q[4]<test6$tweets[i]%in%q[5]){
#               c=2.5
#               }
# }
#points(projLong,projLat,col=col2, cex=1.5, pch=19, ps=0.5)

require(SDMTools)

pnts=cbind(x=c(-0.26, -0.25, -0.25, -0.26), y=c(-0.9, -0.8, -0.9, -0.8))
a=sort(unique(col2))

legend.gradient(pnts, cols=a, c("100%", "0%"), title="quantile", ps=0.5)
}
 