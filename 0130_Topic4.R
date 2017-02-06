##
# Name: Yanshi Luo
# Email: yluo82@wisc.edu

# Questions:
# For the bridges data, what variables are you interested in? 
# Select, filter, and plot. Do something different from my code! 
# Make several plots. Save several pdfs and push to github.


# setwd("/home/cc886/Sync/WiscTextbook/479/20170130_bridges_dplyr")
library(ggplot2)
library(dplyr)
load(file = "data/tidyBridge.RData")

############ The columns that I may interested in ##################
# colName <- colnames(M)
# # Interested in:
# # 16	Latitude
# # 17	Longitude
# # 27	Year Built  # 21
# # 29	Average Daily Traffic # 24
# # 30	Year Of Average Daily Traffic
# # 36	Traffic Safety Features
# grep("027", colnames(M))
# # 21
# grep("029", colnames(M))
# # 24
# grep("030", colnames(M))
# # 25
# grep("036", colnames(M))
# colName[grep("036", colnames(M))]
# 
# 
# head(DT[,25])
# colnames(M)[grep("036", colnames(M))]

M %>% select(STATE_CODE_001, COUNTY_CODE_003, LAT_016, LONG_017, ADT_029) %>%
  mutate(code = STATE_CODE_001*1000+COUNTY_CODE_003) -> D1
D1%>% group_by(STATE_CODE_001) %>% dplyr::summarise(count = n(), totalADT = sum(ADT_029))-> d

# install.packages("tidyr")
# library(tidyr)
# d %>% gather(amount, value, -STATE_CODE_001)


library(ggplot2)
# The totalADT of the bridges in each state.
ggplot(d, aes(x=STATE_CODE_001)) + 
  geom_bar(aes(y = totalADT), stat="identity") + 
  labs(title="Plot of totalADT", 
       x="State Code", y = "Total Average Daily Traffic")


# The count of the bridges of each state.
ggplot(d, aes(x=STATE_CODE_001)) + 
  geom_bar(aes(y = count), stat="identity") + 
  labs(title="Plot of Bridges Count", 
       x="State Code", y = "Number of Bridges")


# I searched in the google map to clear the LAT and LONG format
# I tried some method to deal with them and I find out that (31061110 87341340) means (31.061110, -87341340)
# So I tidied the data as follows

library(stringr)
D1$code <- str_pad(D1$code, 5, pad = "0")
D1%>% group_by(code) %>% dplyr::summarise(count = n())


D1 %>% mutate(LAT = LAT_016/1000000, LONG = LONG_017/-1000000) %>%
  select(STATE_CODE_001, code, LAT, LONG)-> d2


blingIcon <- makeIcon(
  iconUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Emoji_u1f4b0.svg/1024px-Emoji_u1f4b0.svg.png",
  iconWidth = 30, iconHeight = 30)


#############################################################################
# PLEASE DO NOT RUN THE FOLLOWING CODE ON YOUR COMPUTER UNLESS YOU WOULD LIKE TO
# SPEND 20 MINUTED TO WAIT FOR ITS LOADING!!!!
# IT IS VERY EASY TO CRASH!!!! SINCE THERE ARE TOO MAY DATA!!!
# I ran it on my own Ubuntu Rstudio sever to do my own job when the map is drawing.
###########################################################################
# This is a leaflet interactive map.
# The idea comes from:
# https://www.kaggle.com/taddallas/d/kaggle/college-scorecard/interactive-map
#
# I tried a lot of time to modify the data but it keeps crashing until I 
#     finally figure out the lantitude and lontitude data format.
# In fact, it crashes so many time that I failed to hand in my final work beore 12 pm T_T
# A sad story.........
##########################################################################

# library(leaflet)
# 
# ## filter data
# d2<-filter(d2,
#            is.na(code)==FALSE &       ## Key measurements aren't missing
#              is.na(LAT)==FALSE &
#              is.na(LONG)==FALSE &
#              LAT>20 & LAT<50 &         ## Location is US 48
#              LONG>(-130) & LONG<(-60))
# 
# 
# m <- leaflet(d2) %>%
#   setView(-93.65, 42.0285, zoom = 4) %>%
#   addTiles() %>%
#   addMarkers(lat = ~LAT, lng = ~LONG,
#              options = popupOptions(closeButton = TRUE),
#              clusterOptions = markerClusterOptions())
# 
# 
# m
