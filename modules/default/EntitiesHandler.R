ProcessPrivateChatCommand = function( bot_, data_ )
{
  command = BotCommand$new( message_data_ = data_ )

  data_$command_text       = command$GetText()
  data_$command_parameters = command$GetParameters()
  data_$parameters_length  = command$Length()

  handler_data = private_commands_list[[command$GetText()]]

  if( command$GetText() %in% names( private_commands_list ) )
  {
    handler_function = match.fun( handler_data["function"] )
    if( handler_data["enabled"] == "TRUE" )
    {
      if( handler_data["role"] == "admin" )
      {
        if( IsAdmin( data_$user$GetID() ) )
        {
          handler_function( bot_, data_ )
        }
      } else
      {
        handler_function( bot_, data_ )
      }
    }
  } else
  {
    print( data_ )
  }
}

ProcessSupergroupChatCommand = function( bot_, data_ )
{
  command = BotCommand$new( message_data_ = data_ )

  data_$command_text       = command$GetText()
  data_$command_parameters = command$GetParameters()
  data_$parameters_length  = command$Length()

  handler_data = group_commands_list[[command$GetText()]]

  if( command$GetText() %in% names( group_commands_list ) )
  {
    handler_function = match.fun( handler_data["function"] )
    if( handler_data["enabled"] == "TRUE" )
    {
      if( handler_data["role"] == "admin" )
      {
        if( IsAdmin( data_$user$GetID() ) )
        {
          handler_function( bot_, data_ )
        }
      } else
      {
        handler_function( bot_, data_ )
      }
    }
  } else
  {
    print( data_ )
  }
}

EntitiesHandler = function( bot_, data_ )
{
  if( data_$message$BotCommand() || grepl( "(?=.DemiAltairBot)(?=.*/.*)", data_$message$GetText(), perl = TRUE ) )
  {
    text = gsub( "@DemiAltairBot ", "", data_$message$GetText() )
    data_$message$SetText( text )

    if( data_$message$FromPrivate() )
    {
      ProcessPrivateChatCommand( bot_, data_ )
    } else
    {
      ProcessSupergroupChatCommand( bot_, data_ )
    }
  } else
  {
    
    print( data_ )
  }
}

ProcessPrivateChatCommand    <<- LoggerFunctionWrapper::AddLog( ProcessPrivateChatCommand   , "ProcessPrivateChatCommand"    )
ProcessSupergroupChatCommand <<- LoggerFunctionWrapper::AddLog( ProcessSupergroupChatCommand, "ProcessSupergroupChatCommand" )
EntitiesHandler              <<- LoggerFunctionWrapper::AddLog( EntitiesHandler             , "EntitiesHandler"              )
