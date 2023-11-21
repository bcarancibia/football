#do bad teams rely on their running back more in the end of the season?
# fantasy football type of question for gaining edge / efficiency


library(tidyverse)
library(nflfastR)

rb_snap_counts <- nflreadr::load_snap_counts(seasons = 2022)

rb_snap_counts <- rb_snap_counts %>%
  select(game_id, week, player, position, team, offense_pct) %>%
  filter(position %in% "RB") %>%
  group_by(game_id, team) %>%
  arrange(-offense_pct) %>%
  dplyr::slice(1:5) %>%
  ungroup()

rb_snap_counts

#look at teams in 2022 with records below .500

unique(rb_snap_counts$team)

#https://www.nfl.com/standings/league/2022/reg
rb_snap_counts <- rb_snap_counts |> 
  filter(team %in% c("CHI", "HOU", "ARI", 
                     "IND", "DEN", "LA", 
                     "LV", "ATL", "CAR",
                     "CLE", "NO", "NYJ",
                     "TEN", "GB", "NE",
                     "TB", "WAS")) |> 
  filter(offense_pct != 0.00) |> 
  filter(week != 19)


test_plot <- rb_snap_counts %>% 
  filter(team %in% "CLE")

ggplot(test_plot, aes(x = week, y = offense_pct, fill = player)) + 
  geom_bar(stat="identity")

ggplot(rb_snap_counts, aes(x = player, y = offense_pct, fill = team)) + 
  geom_bar(stat="identity") +
  facet_wrap(~ week)


#chart difference from week to week

test_counts_diff <- rb_snap_counts |> 
  group_by(player) |> 
  filter(team %in% "GB") |> 
  mutate(diff = offense_pct - lag(offense_pct))

ggplot(test_counts_diff, aes(x = week, y = diff, fill = player)) +
  geom_bar(stat = "identity")


rb_snap_counts_diff <- rb_snap_counts |> 
  group_by(player) |> 
  mutate(diff = offense_pct - lag(offense_pct))

ggplot(rb_snap_counts_diff, aes(x = player, y = diff, fill = team)) + 
  geom_bar(stat="identity") +
  facet_wrap(~ week)

  
  
