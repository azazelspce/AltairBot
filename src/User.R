user_private                 = list()
user_private$first_name      = ""
user_private$username        = ""
user_private$telegram_id     = ""
user_private$language        = ""
user_private$private_message = ""
user_private$status          = ""
user_private$count           = 0
user_private$is_bot          = FALSE

user_public = list()

user_public$GetPath = function()
{
  return( "documents/User" )
}

user_public$GetBody = function()
{
  body_ = list()
  
  body_$first_name      = self$first_name
  body_$username        = self$username
  body_$telegram_id     = self$telegram_id
  body_$private_message = self$private_message
  body_$status          = self$status
  body_$count           = self$count

  return( body_ )
}

user_public$Get = function()
{
  if( super$Exists() )
  {
    result = jsonlite::fromJSON( readLines( super$CreateURL( FALSE ) ) )

    self$first_name      <<- result$first_name
    self$username        <<- result$username
    self$telegram_id     <<- result$telegram_id
    self$private_message <<- result$private_message
    self$status          <<- result$status
    self$language        <<- result$language
    self$is_bot          <<- result$is_bot

    return( "User loaded" )
  }

  return( "User not found" )
}

user_public$GetID       = function() { return( self$telegram_id ) }
user_public$GetLanguage = function() { return( self$language ) }
user_public$GetStatus   = function() { return( self$status ) }

user_public$SetStatus = function( status_ ) { self$status = status_ }

user_public$initialize = function( ... )
{
  arguments = list( ... )

  self$private_message <<- ""
  self$count           <<- 0
  self$language        <<- "en"
  self$status          <<- "created"
  self$is_bot          <<- FALSE

  if( is.null( arguments$message_data_ ) && is.null( arguments$callback_data_ ) )
  {
    self$telegram_id <<- arguments$telegram_id_
    self$first_name  <<- arguments$first_name_
    self$username    <<- arguments$username_
  } else if( is.null( arguments$callback_data_ ) )
  {
    self$telegram_id     <<- arguments$message_data_$from$id
    self$first_name      <<- arguments$message_data_$from$first_name
    self$username        <<- arguments$message_data_$from$username
    self$language        <<- arguments$message_data_$from$language_code
    self$is_bot          <<- arguments$message_data_$from$is_bot
    self$private_message <<- arguments$message_data_$message_id
  } else
  {
    if( is.null( arguments$callback_data_$message ) )
    {
      self$telegram_id     <<- arguments$callback_data_$from$id
      self$first_name      <<- arguments$callback_data_$from$first_name
      self$username        <<- arguments$callback_data_$from$username
      self$is_bot          <<- arguments$callback_data_$from$is_bot
      self$language        <<- arguments$callback_data_$from$language_code
    } else
    {
      self$telegram_id     <<- arguments$callback_data_$message$chat$id
      self$first_name      <<- arguments$callback_data_$message$chat$first_name
      self$username        <<- arguments$callback_data_$message$chat$username
      self$is_bot          <<- arguments$callback_data_$message$from$is_bot
      self$private_message <<- arguments$callback_data_$message$message_id
    }
  }
}

user_public$print = function(...)
{
  cat( "User:\n" )
  cat( "  first_name: "     , self$first_name     , "\n", sep = "" )
  cat( "  username: "       , self$username       , "\n", sep = "" )
  cat( "  telegram_id: "    , self$telegram_id    , "\n", sep = "" )
  cat( "  language: "       , self$language       , "\n", sep = "" )
  cat( "  private_message: ", self$private_message, "\n", sep = "" )
  cat( "  status: "         , self$status         , "\n", sep = "" )
  cat( "  count: "          , self$count          , "\n", sep = "" )

  invisible( self )
}

user_public$GetDBPath = function()
{
  return( Sys.getenv( "TEST_DATABASE_PATH" ) )
}

user_public$GetUsername = function()
{
  return( self$username )
}

class_   = "User"
super_   = FileObject
public_  = user_public
private_ = user_private

User = CreateTraceableClass( class_ = class_, inherit_ = super_, public_list = public_, private_list = private_ )