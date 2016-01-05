
#This function creates the URL that points to each player's data
createPlayerURL <- function(id){
  base <- "http://fantasy.premierleague.com/web/api/elements/"
  
  return(str_c(base,id,"/",sep=""))
  
}

#Given a specific url, this function returns a list of the player's data
#over the course of the season. The reason this function returns a list is
#because name, team, and position are given separate parts of the list. The
#dataframe is still present but is now separate from these three components
#(to avoid repeats). 
getPlayerHistoryList <- function(url){
  player_data <- fromJSON(readLines(url))
  
  player_df <- as.data.frame(player_data$fixture_history$all)
  
  names(player_df) = c("D", "R", "Outcome", "MP", "GS", "A", "CS", "GC", "OG", "PS", "PM", "YC", "RC", "Saves", "Bonus", "ESP", "BPS", "NT", "V", "P")
  
  player_df <- colwise(as.character)(player_df)
  player_df[,4:20] <- colwise(as.numeric)(player_df[,4:20])
  
  
  player_df <- mutate(player_df,
                      V = V / 10  #Mutate allows you to update a column!            
                      
  )
  
  Team <- player_data$team_name
  Name <- player_data$web_name
  Position <- player_data$type_name
  return(list(name = Name, team = Team, position = Position, data=player_df))
}

#Given a specific URL, this function returns a df that includes all 
#necessary information for a particular player. NOTE: Name, team, and 
#position are each given their column so they repeat for every round. 
getPlayerHistoryDF <- function(url){
  player_data <- fromJSON(readLines(url))
  
  player_df <- as.data.frame(player_data$fixture_history$all)
  
  names(player_df) = c("D", "R", "Outcome", "MP", "GS", "A", "CS", "GC", "OG", "PS", "PM", "YC", "RC", "Saves", "Bonus", "ESP", "BPS", "NT", "V", "P")
  
  player_df <- colwise(as.character)(player_df)
  player_df[,4:20] <- colwise(as.numeric)(player_df[,4:20])
  
  
  player_df <- mutate(player_df,
                      V = V / 10,  #Mutate allows you to update a column!            
                      Team = player_data$team_name,
                      Name = player_data$web_name,
                      Position = player_data$type_name
  )
  
  return(player_df)
}


