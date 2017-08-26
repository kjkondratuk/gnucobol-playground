       01  W01-RECORD.
           05  W01-RID                        PIC 9(06).
           05  W01-FIRST-NM                   PIC X(16).
           05  W01-LAST-NM                    PIC X(18).
           05  W01-SSN                        PIC 9(09).
           05  W01-REG-TS.
               10  W01-REG-YYYY               PIC 9(04).
               10  FILLER                     PIC X(01).
               10  W01-REG-MM                 PIC 9(02).
               10  FILLER                     PIC X(01).
               10  W01-REG-DD                 PIC 9(02).
               10  FILLER                     PIC X(01).
               10  W01-REG-HH                 PIC 9(02).
               10  FILLER                     PIC X(01).
               10  W01-REG-MIN                PIC 9(02).
               10  FILLER                     PIC X(01).
               10  W01-REG-SS                 PIC 9(02).
               10  FILLER                     PIC X(01).
               10  W01-REG-MS                 PIC 9(06).
