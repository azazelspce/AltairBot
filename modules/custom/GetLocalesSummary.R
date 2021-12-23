GetLocalesSummary = function( bot_, data_ )
{
  pattern_1 = "Language \"%s\" keys(%s): <code>%s</code>"
  to_send   = ""
  print( locale_manager$language_list )

  for( language_ in locale_manager$language_list )
  {
    keys_in_language = locale_manager$languages_data[[language_]]$message_id
    keys_count       = as.character( length( keys_in_language ) )
    keys_in_language = paste( keys_in_language, collapse = "," )
    to_send = paste0( to_send, "\n", sprintf( pattern_1, language_, keys_count, keys_in_language ) )
  }

  bot_$sendMessage( data_$user$GetID(), to_send, parse_mode = "html" )
}

private_commands_table <<- rbind( private_commands_table, c( "/getlocalessummary", "GetLocalesSummary", "admin", TRUE ) )