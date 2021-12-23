ReloadCode = function( bot_, data_ )
{
  source( "src/Utils.R" )

  locale_manager <<- LocaleManager$new()

  LoadModules()

  for( language_ in list.files( "locales", full.names = TRUE ) )
    locale_manager$AddLanguage( tail( strsplit( language_, "/" )[[1]], n = 1 ), language_ )

  locale_manager$SetDefaultLanguage( "Español" )
}

private_commands_table <<- rbind( private_commands_table, c( "/reload", "ReloadCode", "admin", TRUE ) )