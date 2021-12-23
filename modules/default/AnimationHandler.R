AnimationHandler = function( bot_, data_ )
{
  print( data_ )
}

AnimationHandler <<- LoggerFunctionWrapper::AddLog( AnimationHandler, "AnimationHandler" )
