cmake_minimum_required( VERSION 3.13 )

project( scitokens_pam CXX C )

add_library( pam_scitokens SHARED 

              account_map.c 
              account_map.h
              base64.c 
              base64.h
              client.c 
              client.h 
              config.c 
              config.h 
              debug.c 
              debug.h 
              globus_auth.c 
              globus_auth.h 
              http.c 
              http.h 
              identities.c 
              identities.h 
              introspect.c 
              introspect.h 
              json.c 
              json.h 
              logger.c 
              logger.h 
              pam.c 
              parser.c 
              parser.h 
              strings.c
              strings.h )
