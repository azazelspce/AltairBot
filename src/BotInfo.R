bot_public = list()

bot_public$via_bot               = ""
bot_public$left_chat_participant = ""
bot_public$left_chat_member      = ""
bot_public$new_chat_participant  = ""
bot_public$new_chat_member       = ""

bot_public$initialize = function( ... )
{
  arguments = list( ... )

  if( !is.null( arguments$message_data_ ) )
  {
    self$via_bot               <<- arguments$message_data_$via_bot$is_bot
    self$left_chat_participant <<- arguments$message_data_$left_chat_participant
    self$left_chat_member      <<- arguments$message_data_$left_chat_member
    self$new_chat_participant  <<- arguments$message_data_$new_chat_participant
    self$new_chat_member       <<- arguments$message_data_$new_chat_member
  }
}

bot_public$print = function(...)
{
  cat( "User:\n" )
  cat( "  left_chat_participant: ", self$left_chat_participant, "\n", sep = "" )
  cat( "  left_chat_member: "     , self$left_chat_member     , "\n", sep = "" )
  cat( "  new_chat_participant: " , self$new_chat_participant , "\n", sep = "" )
  cat( "  new_chat_member: "      , self$new_chat_member      , "\n", sep = "" )
  #print( self$via_bot )

  invisible( self )
}

class_   = "BotInfo"
super_   = FileObject
public_  = bot_public

BotInfo = CreateTraceableClass( class_ = class_, inherit_ = super_, public_list = public_ )