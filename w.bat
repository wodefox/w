@echo off
setlocal

:parse_args
if "%1"=="" (
    echo Usage: w.bat [-ip] [-a] [-w] [-b] [-c] [-d] [-e] [-f] [-g] [-h] [-i] [-j] [-k] [-l] [-m] [-n] [-cc] [-cv] [-x] [-v] [-o] [-all] [-kill]
    echo -ip: Display all IP configuration information.
    echo -a: Display system information.
    echo -w: Display all running processes.
    echo -b: Display all services on the local machine.
    echo -c: Display detailed information about scheduled tasks.
    echo -d: Display all workstation statistics.
    echo -e: Display user accounts on the local machine.
    echo -f: Display members of the Administrators local group.
    echo -g: Display all listening ports and associated process information.
    echo -h: Display this help message.
    echo -i: Display all shared resources on the local machine.
    echo -j: Display all shared resources with name, path, and status using wmic.
    echo -k: Display the routing table using route print.
    echo -l: Display all ARP cache entries using arp -a.
    echo -m: Display detailed information about the current user using whoami /all.
    echo -n: Display workstation configuration information using net config workstation.
    echo -cc: Copy a file from source path to destination path.
    echo -cv: Move a file from source path to destination path.
    echo -x: Create a new file at the specified path and write content to it.
    echo -v: View all files in the specified directory.
    echo -o: Display all available drives using fsutil fsinfo drives.
    echo -all: Execute all commands.
    echo -kill: Kill a running process by name.
    goto :eof
)

if "%1"=="-ip" (
    ipconfig /all
) else if "%1"=="-a" (
    systeminfo
) else if "%1"=="-w" (
    tasklist
) else if "%1"=="-b" (
    sc query
) else if "%1"=="-c" (
    schtasks /query /fo list /v
) else if "%1"=="-d" (
    net statistics workstation
) else if "%1"=="-e" (
    net user
) else if "%1"=="-f" (
    net localgroup administrators
) else if "%1"=="-g" (
    netstat -ano
) else if "%1"=="-h" (
    echo Usage: w.bat [-ip] [-a] [-w] [-b] [-c] [-d] [-e] [-f] [-g] [-h] [-i] [-j] [-k] [-l] [-m] [-n] [-cc] [-cv] [-x] [-v] [-o] [-all] [-kill]
) else if "%1"=="-i" (
    net share
) else if "%1"=="-j" (
    wmic share get name,path,status
) else if "%1"=="-k" (
    route print
) else if "%1"=="-l" (
    arp -a
) else if "%1"=="-m" (
    whoami /all
) else if "%1"=="-n" (
    net config workstation
) else if "%1"=="-cc" (
    if "%2"=="" (
         echo Error: No source or destination path specified for -cc.
         goto :eof
          ) else if "%3"=="" (
          echo Error: No destination path specified for -cc.
          goto :eof
          ) else (
          copy "%2" "%3"
          if %errorlevel% equ 0 (
              echo File copied successfully from %2 to %3.
              ) else (
              echo Failed to copy the file.
              )
          )
) else if "%1"=="-cv" (
     if "%2"=="" (
          echo Error: No source or destination path specified for -cv.
          goto :eof
          ) else if "%3"=="" (
          echo Error: No destination path specified for -cv.
          goto :eof
          ) else (
          move "%2" "%3"
          if %errorlevel% equ 0 (
              echo File moved successfully from %2 to %3.
              ) else (
              echo Failed to move the file.
              )
          )
) else if "%1"=="-x" (
     if "%2"=="" (
          echo Error: No file path specified for -x.
          goto :eof
          ) else (
          echo %3 > "%2"
          if %errorlevel% equ 0 (
              echo File created and content written successfully to %2.
              ) else (
              echo Failed to create the file or write content.
              )
          )
) else if "%1"=="-v" (
     if "%2"=="" (
          echo Error: No directory path specified for -v.
          goto :eof
          ) else (
          dir "%2"
          if %errorlevel% equ 0 (
              echo Directory contents listed successfully for %2.
              ) else (
              echo Failed to list directory contents.
              )
          )
) else if "%1"=="-o" (
     fsutil fsinfo drives
) else if "%1"=="-all" (
     ipconfig /all
     systeminfo
     tasklist
     sc query
     schtasks /query /fo list /v
     net statistics workstation
     net user
     net localgroup administrators
     netstat -ano
     wmic share get name,path,status
     route print
     arp -a
     whoami /all
     net config workstation
     fsutil fsinfo drives
) else if "%1"=="-kill" (
     if "%2"=="" (
          echo Error: No process name specified for -kill.
          goto :eof
          ) else (
          taskkill /F /IM %2
          if %errorlevel% equ 0 (
              echo Process %2 has been terminated.
              ) else (
              echo Failed to terminate process %2.
              )
          )
) else (
     echo Unknown argument: %1
)

shift
goto :parse_args
