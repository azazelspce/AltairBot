#secret_chat_register <<- list()

query_table <<- rbind( query_table, c( "/mensaje_secreto", "SecretMessageQuery", "user", TRUE ) )