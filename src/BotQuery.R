query_private = list()
query_private$id         = ""
query_private$text       = ""
query_private$data       = ""
query_private$board      = ""
query_private$selected   = ""
query_private$button     = numeric()
query_private$is_dynamic = FALSE

query_public = list()

query_public$initialize = function( ... )
{
  arguments = list( ... )

  if( !is.null( arguments$callback_data_ ) )
  {
    self$id         = arguments$callback_data_$id
    self$text       = arguments$callback_data_$message$text
    self$data       = arguments$callback_data_$data
    self$is_dynamic = grepl( ";", self$data, fixed = T )
    self$data       = gsub( ";", ":", self$data, fixed = T )
    self$board      = strsplit( self$data, split = ":", fixed = T )
    self$board      = self$board[[1]]
    self$selected   = ifelse( self$is_dynamic, "0", self$board[2] )
    self$board      = self$board[1]
    self$button     = unlist( strsplit( self$selected, "," ) )
    self$button     = as.numeric( self$button )
  }
}

query_public$print = function(...)
{
  button = paste0( "[", paste( self$button, collapse = ", " ), "]" )

  cat( "Query:\n" )
  cat( "  id: "        , self$id        , "\n", sep = "" )
  cat( "  text: "      , self$text      , "\n", sep = "" )
  cat( "  data: "      , self$data      , "\n", sep = "" )
  cat( "  board: "     , self$board     , "\n", sep = "" )
  cat( "  selected: "  , self$selected  , "\n", sep = "" )
  cat( "  button: "    , button         , "\n", sep = "" )
  cat( "  is_dynamic: ", self$is_dynamic, "\n", sep = "" )

  invisible( self )
}

query_public$GetID       = function() { return( self$id ) }
query_public$GetText     = function() { return( self$text ) }
query_public$GetData     = function() { return( self$data ) }
query_public$GetBoard    = function() { return( self$board ) }
query_public$GetSelected = function() { return( self$selected ) }
query_public$GetButton   = function() { return( self$button ) }
query_public$GetDynamic  = function() { return( self$is_dynamic ) }

class_   = "BotQuery"
super_   = FileObject
public_  = query_public
private_ = query_private

BotQuery = CreateTraceableClass( class_ = class_, inherit_ = super_, public_list = public_, private_list = private_ )