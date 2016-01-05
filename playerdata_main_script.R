source('playerdata_libraries.R')
source('playerdata_functions.R')

#Value determined experimentally, changes over time
num_players <- 1:643

player_data_list <- lapply(lapply(num_players, createPlayerURL), 
                           getPlayerHistoryList)
