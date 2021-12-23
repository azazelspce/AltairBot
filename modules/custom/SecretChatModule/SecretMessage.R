message_private         = list()
message_private$id      = ""
message_private$from    = ""
message_private$to      = ""
message_private$message = ""

message_public = list()

message_public$GetMessage = function() { return( self$message ) }
message_public$GetFrom    = function() { return( self$from ) }
message_public$GetTo      = function() { return( self$to ) }
message_public$GetID      = function() { return( self$id ) }

message_public$SetData = function( ... )
{ 
  arguments = list( ... )

  self$from    <<- arguments$from
  self$to      <<- arguments$to
  self$message <<- arguments$message
}

message_public$initialize = function()
{
  self$id <<- paste( sample( c( letters, LETTERS, 0:9 ), 10, replace = T ), collapse = "" )
}

message_public$print = function(...)
{
  cat( "Secret message:\n" )
  cat( "  id: "     , self$id     , "\n", sep = "" )
  cat( "  from: "   , self$from   , "\n", sep = "" )
  cat( "  to: "     , self$to     , "\n", sep = "" )
  cat( "  message: ", self$message, "\n", sep = "" )

  invisible( self )
}



class_   = "SecretMessage"
super_   = FileObject
public_  = message_public
private_ = message_private

SecretMessage = CreateTraceableClass( class_ = class_, inherit_ = super_, public_list = public_, private_list = private_ )