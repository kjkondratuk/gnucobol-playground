      ***************************************************************
      *> Author:    Brian Tiffin
      *> Date:      20091129, 20140915
      *> Purpose:   PostgreSQL connection test, updated for clarity
      *> Tectonics: cobc -x -lpq pgcob.cob
      *> ***************************************************************
       identification division.
       program-id. pgcob.

       data division.
       working-storage section.
       01 pgconn usage pointer.
       01 pgres  usage pointer.
       01 resptr usage pointer.
       01 resstr pic x(80) based.
       01 result usage binary-long.
       01 answer pic x(80).

      *> ***************************************************************
       procedure division.
       display "Before connect:     " pgconn end-display

      *> connect to PostgreSQL
       call "PQconnectdb" using
           by reference "dbname = postgres" & x"00"
           returning pgconn
           on exception
               display
                   "Error: PQconnectdb link problem, try -lpq"
                   upon syserr
               end-display
bail           stop run returning 1
       end-call
       display "After connect:      " pgconn end-display

       if pgconn equal null then
           display "Error: PQconnectdb failure" upon syserr end-display
bail       stop run returning 1
       end-if

      *> request a connection status
       call "PQstatus" using by value pgconn returning result end-call
       if result equal 0 then
           move "OK" to answer
       else
           move "BAD" to answer
       end-if
       display
           "Status:             " result
           " CONNECTION_" function trim(answer)
       end-display

      *> sample call to get the connection name credentials
       call "PQuser" using by value pgconn returning resptr end-call

       if resptr not equal null then
           set address of resstr to resptr
           string resstr delimited by x"00" into answer end-string
       else
           move "PQuser returned null" to answer
       end-if
       display "User:               " function trim(answer) end-display

      *> Evaluate a query
       display " -- call PQexec --" end-display
       call "PQexec" using
           by value pgconn
           by reference "select version();" & x"00"
           returning pgres
       end-call
       display "PQexec return code: " pgres end-display

      *> Pull out a result. row 0, field 0
       if pgres not equal null then
           call "PQgetvalue" using
               by value pgres
               by value 0
               by value 0
               returning resptr
           end-call
           if resptr not equal null then
               set address of resstr to resptr
               string resstr delimited by x"00" into answer end-string
           else
               move "PQgetvalue returned null" to answer
           end-if
       else
           move "PQexec returned null" to answer
       end-if
       display "PostgreSQL version: " answer end-display

      *> close the PostgreSQL connection
       call "PQfinish" using by value pgconn end-call
       display "After PQfinish:     " pgconn end-display

       goback.
       end program pgcob.
