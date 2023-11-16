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

#look at teams in 2022 with losing records
