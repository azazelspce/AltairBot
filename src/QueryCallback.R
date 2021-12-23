ProcessQueryUpdate = function( bot_, update_ )
{
  effective_message = update_$callback_query
  message_data      = list()

  message_data$update_id = update_$update_id
  message_data$user      = User$new( callback_data_ = effective_message )
  message_data$query     = BotQuery$new( callback_data_ = effective_message )
  
  return( message_data )
}

QueryCallback = function( bot_, update_ )
{
  data_raw = ProcessQueryUpdate( bot_, update_ )
  callback = flow_manager$GetCallback( data_raw$query )

  callback( bot_, data_raw )
}

ProcessQueryUpdate = LoggerFunctionWrapper::AddLog( ProcessQueryUpdate, "ProcessQueryUpdate" )
QueryCallback      = LoggerFunctionWrapper::AddLog( QueryCallback     , "QueryCallback"      )
