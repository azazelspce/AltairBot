PhotoHandler = function( bot_, data_ )
{
  print( data_ )
}

PhotoHandler <<- LoggerFunctionWrapper::AddLog( PhotoHandler, "PhotoHandler" )