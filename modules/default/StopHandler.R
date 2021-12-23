StopBot = function( bot_, data_ )
{
  bot_$sendMessage( data_$user$GetID(), "さようなら。", parse_mode = "html" )
  bot_$getUpdates( offset = data_$update_id + 1 )
  updater$stop_polling()
}

private_commands_table <<- rbind( private_commands_table, c( "/stop" , "StopBot", "admin", TRUE ) )
private_commands_table <<- rbind( private_commands_table, c( "/kill" , "StopBot", "admin", TRUE ) )
private_commands_table <<- rbind( private_commands_table, c( "/sleep", "StopBot", "admin", TRUE ) )
