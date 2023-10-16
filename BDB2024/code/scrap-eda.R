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

