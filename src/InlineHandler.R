GetCommand = function( update_ )
{
  result = gsub( ".*/"  , "", update_ )
  result = gsub( "\\s.*", "", update_ )
  return( result )
}

ProcessInlineQueryUpdate = function( update_ )
{
  message_data = list()

  message_data$update_id = update_$update_id
  message_data$user      = User$new( message_data_ = update_$inline_query )
  message_data$query     = update_$inline_query$query

  return( message_data )
}

InlineHandler = function( bot_, update_ )
{
  data_raw = ProcessInlineQueryUpdate( update_ )
  command = GetCommand( update_$inline_query$query )
  result_list = QueryResultList$new()

  query_data = query_list[[command]]

  if( command %in% names( query_list ) )
  {
    query_function = match.fun( query_data["function"] )
    if( query_data["enabled"] == "TRUE" )
    {
      if( query_data["role"] == "admin" )
      {
        if( IsAdmin( data_raw$user$GetID() ) )
        {
          result_list = query_function( update_ )
        }
      } else
      {
        result_list = query_function( update_ )
      }
    }
  } else
  {
    print( data_raw )
  }

  bot_$answerInlineQuery( update_$inline_query$id, result_list$GetList(), cache_time = 10, is_personal = TRUE )
}

InlineHandler  = LoggerFunctionWrapper::AddLog( InlineHandler, "InlineHandler"  )