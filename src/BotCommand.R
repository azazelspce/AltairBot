command_private = list()
command_private$text       = ""
command_private$parameters = character()
command_private$parameters_length  = 0

command_public = list()

command_public$initialize = function( ... )
{
  arguments = list( ... )

  if( !is.null( arguments$message_data_ ) )
  {
    self$text       <<- arguments$message_data_$message$GetText()
    self$parameters <<- unlist( strsplit( self$text, " " ) )
    self$text       <<- self$parameters[1]

    if( length( self$parameters ) > 1 )
      self$parameters <<- self$parameters[2:length( self$parameters )]
    else
      self$parameters <<- NULL
    self$parameters_length <<- length( self$parameters )
  }
}

command_public$print = function(...)
{
  parameters = paste( self$parameters, collapse = "," )
  cat( "Command:\n" )
  cat( "  text: "      , self$text , "\n", sep = "" )
  cat( "  parameters: ", parameters, "\n", sep = "" )

  invisible( self )
}

command_public$GetText       = function() { return( self$text ) }
command_public$GetParameters = function() { return( self$parameters ) }
command_public$Length        = function() { return( self$parameters_length ) }

class_   = "BotCommand"
super_   = FileObject
public_  = command_public
private_ = command_private

BotCommand = CreateTraceableClass( class_ = class_, inherit_ = super_, public_list = public_, private_list = private_ )