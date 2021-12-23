SecretMessageQuery = function( update_ )
{
  result_list  = QueryResultList$new()
  menu         = ChatMenu$new( "secret message" )
  temp_message = SecretMessage$new()
  message_code = temp_message$GetID()
  
  menu$chat_text = "test_menu$serialize()"

  params = gsub( "/mensaje_secreto ", "", update_$inline_query$query )
  params = gsub( "/mensaje_secreto" , "", params )

  description = "/mensaje_secreto @usuario Algún mensaje muy secreto."
  secret = ""

  params = strsplit( params, " " )[[1]]
  user_to = params

  if( length( params ) > 1 )
  {
    user_to = params[1]
    secret = paste( params[-1], collapse = " " )
  }

  message_data = paste( c( message_code, user_to ), collapse = "" )
  menu$AddData( "Ver mensaje", message_data, TRUE, 1 )
  menu$AddInlineQueryInternal( "Responder", paste0( "/mensaje_secreto @", update_$inline_query$from$username ), 2 )
  menu$AddLink( text_ = "Acerca de", link_ = "https://github.com/azazelspce/AltairBot", column_ = 1 )
  
  message = paste0( "Mensaje oculto para ", user_to )

  result_list$AddArticle( "Mensaje secreto:", message, description, menu )

  username = paste0( update_$inline_query$from$username, ": ", update_$inline_query$from$first_name )
  temp_message$SetData( from = username, to = user_to, message = secret)
  secret_chat_register[[message_code]] <<- temp_message

  return( result_list )
}

SecretMessageQuery = LoggerFunctionWrapper::AddLog( SecretMessageQuery, "SecretMessageQuery" )

flow_manager$AddCallback( "secret message", "0", "ReadMessageCallback" )