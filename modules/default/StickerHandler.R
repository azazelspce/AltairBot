StickerHandler= function( bot_, data_ )
{
  print( data_ )
}

StickerHandler <<- LoggerFunctionWrapper::AddLog( StickerHandler, "StickerHandler" )