LoadModules = function()
{
  private_commands_table <<- matrix( nrow = 0, ncol = 4 )
  group_commands_table   <<- matrix( nrow = 0, ncol = 4 )

  modules = list.files( "modules", full.names = TRUE, recursive = TRUE )
  
  for( module_ in modules ) source( module_ )

  if( nrow( private_commands_table ) > 0 )
  {
    for( row_ in 1:nrow( private_commands_table ) )
    {
      private_commands_list[[private_commands_table[row_, 1]]]["function"] <<- private_commands_table[row_, 2]
      private_commands_list[[private_commands_table[row_, 1]]]["role"]     <<- private_commands_table[row_, 3]
      private_commands_list[[private_commands_table[row_, 1]]]["enabled"]  <<- private_commands_table[row_, 4]
    }
  }

  if( nrow( group_commands_table ) )
  {
    for( row_ in 1:nrow( group_commands_table ) )
    {
      group_commands_list[[group_commands_table[row_, 1]]]["function"] <<- group_commands_table[row_, 2]
      group_commands_list[[group_commands_table[row_, 1]]]["role"]     <<- group_commands_table[row_, 3]
      group_commands_list[[group_commands_table[row_, 1]]]["enabled"]  <<- group_commands_table[row_, 4]
    }
  }

  if( nrow( query_table ) > 0 )
  {
    for( row_ in 1:nrow( query_table) )
    {
      query_list[[query_table[row_, 1]]]["function"] <<- query_table[row_, 2]
      query_list[[query_table[row_, 1]]]["role"]     <<- query_table[row_, 3]
      query_list[[query_table[row_, 1]]]["enabled"]  <<- query_table[row_, 4]
    }
  }
}

GetCurrentTimeVector = function()
{
  result = as.character( date() )
  result = gsub( " +", " ", as.character( date() ) )
  result = strsplit( result, " " )
  result = unlist( result )[4]
  result = strsplit( result, ":" )
  result = unlist( result )
  result = as.numeric( result )
  
  return( result )
}

SplitName = function( name_string )
{
  split_name = strsplit( name_string, " " )
  split_name = unlist( split_name )[1]

  return( split_name )
}

GenerateUniqueID = function( size_str = 20 )
{
  unique_id = c( 0:9, letters, LETTERS )
  unique_id = sample( unique_id, size = size_str, replace = T )
  unique_id = paste( unique_id, collapse = "" )
  
  return( unique_id )
}

IsAdmin = function( user_id_ )
{
  return( as.character( user_id_ ) == admin_telegram_id )
}

LoadModules = LoggerFunctionWrapper::AddLog( LoadModules, "LoadModules" )
