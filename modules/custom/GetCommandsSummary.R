GetCommandsSummary = function( bot_, data_ )
{
  format_1 = "<b>%s</b>\n<b>Function: </b>%s\n<b>Role: </b>%s\n<b>Enabled: </b>%s\n"

  to_send = ""
  if( nrow( private_commands_table ) > 0 )
  {
    for( i_ in 1:nrow( private_commands_table ) )
    {
      command   = private_commands_table[i_, 1]
      rfunction = private_commands_table[i_, 2]
      role      = private_commands_table[i_, 3]
      enabled   = private_commands_table[i_, 4]

      row = sprintf( format_1, command, rfunction, role, enabled )

      to_send = paste0( to_send, row )
    }
  } else
  {
    to_send = "No private commands"
  }

  bot_$sendMessage( data_$user$GetID(), to_send, parse_mode = "html" )

  to_send = ""
  if( nrow( group_commands_table ) > 0 )
  {
    for( i_ in 1:nrow( group_commands_table ) )
    {
      command   = group_commands_table[i_, 1]
      rfunction = group_commands_table[i_, 2]
      role      = group_commands_table[i_, 3]
      enabled   = group_commands_table[i_, 4]

      row = sprintf( format_1, command, rfunction, role, enabled )

      to_send = paste0( to_send, row )
    }
  } else
  {
    to_send = "No group commands"
  }

  bot_$sendMessage( data_$user$GetID(), to_send, parse_mode = "html" )
}

private_commands_table <<- rbind( private_commands_table, c( "/getcommands", "GetCommandsSummary", "admin", TRUE ) )