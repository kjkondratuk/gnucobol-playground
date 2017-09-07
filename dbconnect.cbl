      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc -x -lpq dbconnect.cbl
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DBCONNECT.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01  PGCONN USAGE POINTER.
       01  PGRES USAGE POINTER.
       01  RESPTR USAGE POINTER.
       01  RESSTR PIC X(80) BASED.
       01  RESULT USAGE BINARY-LONG.
       01  ANSWER PIC X(80).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "BEFORE CONNECT: " PGCONN END-DISPLAY.

           CALL "PQconnectdb" USING
               BY REFERENCE "dbname = postgres" & X"00"
               RETURNING PGCONN
           END-CALL.

           DISPLAY "AFTER CONNECT: " PGCONN END-DISPLAY.

           GOBACK.
       END PROGRAM DBCONNECT.
