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



###########################################################################
# I tried to do a data visualization with leaflet but my Rstudio server crashed 
#   because of the format of the Longitude and Latitude.
# It makes me not only fail to hand out in time but also did not make a cool visulization. T_T
# A sad story.........
# A sample leaflet webpage that I tried to follow up: 
# https://www.kaggle.com/taddallas/d/kaggle/college-scorecard/interactive-map
##########################################################################

## Which state has largest number of bridges?

# 1	State Code
# 3	County (Parish) Code
# 9	Location
# 
# grep("001|003|016|017", colnames(M))
# colnames(M)[grep("001|003|016|017", colnames(M))]
# placeCodeColName <- colnames(M)[grep("001|003|004", colnames(M))]

# M %>% select(STATE_CODE_001, COUNTY_CODE_003, LAT_016, LONG_017) %>% mutate(code = STATE_CODE_001*1000+COUNTY_CODE_003) -> D1
# 
# # Fix the Place Code of the Single Digit State.

# library(stringr)
# D1$code <- str_pad(D1$code, 5, pad = "0")

# D1%>% group_by(code) %>% dplyr::summarise(count = n())

# 
# blingIcon <- makeIcon(
#   iconUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Emoji_u1f4b0.svg/1024px-Emoji_u1f4b0.svg.png",
#   iconWidth = 30, iconHeight = 30,
# )
# 
# 
# 
# map <- leaflet(schools) %>% 
#   setView(-93.65, 42.0285, zoom = 4) %>%
#   addTiles() %>%
#   addMarkers(~LAT_016, ~LONG_017, popup=~info,
#              options = popupOptions(closeButton = TRUE),
#              clusterOptions = markerClusterOptions(), 
#              icon = blingIcon)
