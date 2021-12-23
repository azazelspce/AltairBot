ReadMessageCallback = function( bot_, data_raw_ )
{
  data = data_raw_$query$GetData()
  data = gsub( ".*:", "", data )
  username = tolower( gsub( ".*@", "", data ) )
  secret   = gsub( "@.*", "", data )
  to_send = "¡No puedes ver este mensaje!"

  if( username == tolower( data_raw_$user$GetUsername() ) )
    to_send = secret_chat_register[[secret]]$GetMessage()
  try( bot_$answerCallbackQuery( data_raw_$query$GetID(), text = to_send ) )
}

ReadMessageCallback = LoggerFunctionWrapper::AddLog( ReadMessageCallback, "ReadMessageCallback" )
