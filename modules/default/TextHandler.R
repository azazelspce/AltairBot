ProcessFilter = function( text_, language_ )
{
  print( text_ )
}

TextHandler = function( bot_, data_ )
{
  #$message_id $user_id $chat_id $chat_title $is_bot $first_name $username $language $chat_type $date $text
  ProcessFilter( data_$message$GetText(), data_$user$GetLanguage() );
}

TextHandler   <<- LoggerFunctionWrapper::AddLog( TextHandler, "TextHandler" )
ProcessFilter <<- LoggerFunctionWrapper::AddLog( ProcessFilter, "ProcessFilter" )
