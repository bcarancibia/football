library(cfbfastR)

tictoc::tic()
pbp <- data.frame()
seasons <- 2014:cfbfastR:::most_recent_cfb_season()
progressr::with_progress({
  
  pbp <- cfbfastR::load_cfb_pbp(seasons)
})
tictoc::toc()

glimpse(pbp[1:40])


#### look at rivalries and WP to find the most exciting rivaliries
