ProcessMessageUpdate = function( bot_, update_ )
{
  effective_message = update_$effective_message()
  message_data      = list()

  message_data$update_id = update_$update_id
  message_data$user      = User$new( message_data_ = effective_message )
  message_data$message   = TelegramHelperClasses::Message$new( message_data_ = effective_message )
  message_data$bot_info  = BotInfo$new( message_data_ = effective_message )

  return( message_data )
}

HandlerCheck = function( handler_, bot_, data_ )
{
  if( exists( handler_ ) )
  {
    CustomHandler = match.fun( handler_ )
    CustomHandler( bot_, data_ )
  } else if( exists( "CustomErrorHandler" ) )
  {
    UndefinedHandler( bot_, data_, handler_ )
  } else
  {
    stop( sprintf( "%s is undefined", handler_ ) )
  }
}

MessageHandler = function( bot_, update_ )
{
  data_raw = ProcessMessageUpdate( bot_, update_ )

  if( data_raw$message$Photo() )
    HandlerCheck( "PhotoHandler", bot_, data_raw )
  else if( data_raw$message$Entities() )
    HandlerCheck( "EntitiesHandler", bot_, data_raw )
  else if( !is.null( data_raw$left_chat_participant ) )
    HandlerCheck( "LeftParticipantHandler", bot_, data_raw )
  else if( !is.null( data_raw$left_chat_member ) )
    HandlerCheck( "LeftMemberHandler", bot_, data_raw )
  else if( !is.null( data_raw$new_chat_participant ) )
    HandlerCheck( "NewParticipantHandler", bot_, data_raw )
  else if( !is.null( data_raw$new_chat_member ) )
    HandlerCheck( "NewMemberHandler", bot_, data_raw )
  else if( data_raw$message$Voice() )
    HandlerCheck( "VoiceHandler", bot_, data_raw )
  else if( data_raw$message$VideoNote() )
    HandlerCheck( "VideoNoteHandler", bot_, data_raw )
  else if( data_raw$message$Video() )
    HandlerCheck( "VideoHandler", bot_, data_raw )
  else if( data_raw$message$Sticker() )
    HandlerCheck( "StickerHandler", bot_, data_raw )
  else if( data_raw$message$Animation() )
    HandlerCheck( "AnimationHandler", bot_, data_raw )
  else if( data_raw$message$Document() )
    HandlerCheck( "DocumentHandler", bot_, data_raw )
  else if( data_raw$message$Text() )
    HandlerCheck( "TextHandler", bot_, data_raw )
}

ProcessMessageUpdate  = LoggerFunctionWrapper::AddLog( ProcessMessageUpdate, "ProcessMessageUpdate"  )
HandlerCheck          = LoggerFunctionWrapper::AddLog( HandlerCheck        , "HandlerCheck"          )
MessageHandler        = LoggerFunctionWrapper::AddLog( MessageHandler      , "MessageHandler"        )
