result_list_public  = list()
result_list_private = list()

result_list_private$results = list()

result_list_public$AddArticle = function( title_, message_, description_, chat_menu_ = NULL )
{
  index = length( self$results ) + 1
  if( missing( chat_menu_ ) )
  {
    self$results[[index]] = telegram.bot::InlineQueryResult( type                  = "article",
                                                             id                    = index,
                                                             title                 = title_,
                                                             input_message_content = list( message_text = message_ ),
                                                             description           = description_ )
  } else
  {
    ikm = telegram.bot::InlineKeyboardMarkup( inline_keyboard = chat_menu_$GetInlineKeyboardList() )
    self$results[[index]] = telegram.bot::InlineQueryResult( type                  = "article",
                                                             id                    = index,
                                                             title                 = title_,
                                                             input_message_content = list( message_text = message_ ),
                                                             reply_markup          = ikm,
                                                             description           = description_ )
  }
}

result_list_public$GetList = function()
{
  return( self$results )
}

result_list_public$initialize = function( ... )
{
  self$results = list()
}

class_   = "FlowManager"
super_   = TraceableObject
public_  = result_list_public
private_ = result_list_private

#' QueryResultList class
#' @description A class
#'
#' @examples
#' QueryResultList$new()
#' @export
QueryResultList = CreateTraceableClass( class_ = class_, inherit_ = super_, public_list = public_, private_list = private_ )
