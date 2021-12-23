library( TelegramHelperClasses )

source( "src/User.R" )
source( "src/BotCommand.R" )
source( "src/BotQuery.R" )
source( "src/BotInfo.R" )
source( "src/MessageHandler.R" )
source( "src/InlineHandler.R" )
source( "src/QueryCallback.R" )
source( "src/Utils.R" )
source( "src/QueryResultList.R" )
source( "src/ConfigLoader.R" )

args = commandArgs( trailingOnly = TRUE )

if( length( args ) == 0 )
{
  stop( "At least one argument must be supplied.", call. = FALSE )
}

if( args == "dev" )
{
  chatbot_key = LoadConfig( "config" )[1]
} else
{
  chatbot_key = Sys.getenv( "PROD_KEY" )
}

updater                <<- telegram.bot::Updater( token = chatbot_key )
admin_telegram_id      <<- LoadConfig( "config" )[2]
locale_manager         <<- TelegramHelperClasses::LocaleManager$new()
flow_manager           <<- TelegramHelperClasses::FlowManager$new()
private_commands_table <<- matrix( nrow = 0, ncol = 4 )
group_commands_table   <<- matrix( nrow = 0, ncol = 4 )
query_table            <<- matrix( nrow = 0, ncol = 4 )
group_query_table      <<- matrix( nrow = 0, ncol = 4 )
private_commands_list  <<- list()
group_commands_list    <<- list()
query_list             <<- list()
secret_chat_register   <<- list()

for( language_ in list.files( "locales", full.names = TRUE ) )
  locale_manager$AddLanguage( tail( strsplit( language_, "/" )[[1]], n = 1 ), language_ )

locale_manager$SetDefaultLanguage( "Español" )

updater <<- updater +
            telegram.bot::MessageHandler( callback = MessageHandler ) +
            telegram.bot::CallbackQueryHandler( callback = QueryCallback ) + 
            telegram.bot::InlineHandler( callback = InlineHandler )

LoadModules()

updater$start_polling()
