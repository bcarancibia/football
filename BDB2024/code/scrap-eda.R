library(tidyverse)
library(gt)
library(gtExtras)
setwd(dir = "BDB2024/")

players <- read.csv(file = "data/players.csv")
games <- read.csv(file = "data/games.csv")
plays <- read.csv(file = "data/plays.csv")
tackles <- read.csv(file ="data/tackles.csv")

#questions to consider
#do players tackle differently in different WP scenarios

gt_plt_summary(tackles)

table(tackles$tackle, tackles$assist)
table(tackles$tackle, tackles$forcedFumble)
table(tackles$tackle, tackles$pff_missedTackle)


#merge tackles and plays
tackles_play <- left_join(tackles, plays, by = c('gameId', 'playId'))
head(tackles_play)

#convert characters to factors

tackles_play <- as.data.frame(unclass(tackles_play), 
                              stringsAsFactors = TRUE)

#turn IDs to Factors
#gameId, playId, nflId, ballcarrierId, foulNFLId1, foulNFLId3
#then create a unique ID
#df$ID <- as.factor(paste0(df$gameId, '-', df$playId, '-', df$nflId))

tackles_play$gameId <- as.factor(tackles_play$gameId)
tackles_play$playId <- as.factor(tackles_play$playId)
tackles_play$nflId <- as.factor(tackles_play$nflId)
tackles_play$ballCarrierId <- as.factor(tackles_play$ballCarrierId)
tackles_play$foulNFLId1 <- as.factor(tackles_play$foulNFLId1)
tackles_play$foulNFLId2 <- as.factor(tackles_play$foulNFLId2)

tackles_play$ID <- as.factor(paste0(tackles_play$gameId, '-', tackles_play$playId, '-',
                                    tackles_play$nflId))

View(tackles_play)
