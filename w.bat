# -ip: 显示所有IP信息。
# -s "搜索字符串": 在文件名或内容中搜索指定的字符串。
# -u URL: 在默认网页浏览器中打开指定的URL。
# -p URL: Ping指定的URL。
# -w: 列出所有运行的进程。
# -kill PID: 杀死指定PID的进程。
# -h: 显示帮助信息。
# -c URL [保存路径]: 从指定的URL下载文件到给定的保存路径。
# -cc 源路径 目标路径: 复制文件从源路径到目标路径。
# -cv 源路径 目标路径: 移动文件从源路径到目标路径。
# -v 目录路径: 查看指定目录的位置。
# -k 文件路径 [内容]: 创建一个新文件，指定文件路径并写入内容。

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:START
if "%~1"=="" (
        echo Usage: w.bat [-ip] [-s "search_string"] [-u URL] [-p URL] [-w] [-kill PID] [-h] [-c URL [SAVE_PATH]] [-cc SOURCE_PATH DEST_PATH] [-cv SOURCE_PATH DEST_PATH] [-v DIR_PATH] [-k FILE_PATH [CONTENT]]
        echo.
        echo -ip: Display all IP information.
        echo -s "search_string": Search for files containing the specified string in their names or contents.
        echo -u URL: Open the specified URL in the default web browser.
        echo -p URL: Ping the specified URL.
        echo -w: List all running processes.
        echo -kill PID: Kill the process with the specified PID.
        echo -h: Display this help message.
        echo -c URL [SAVE_PATH]: Download the file from the specified URL to the given SAVE_PATH.
        echo -cc SOURCE_PATH DEST_PATH: Copy the file from SOURCE_PATH to DEST_PATH.
        echo -cv SOURCE_PATH DEST_PATH: Move the file from SOURCE_PATH to DEST_PATH.
        echo -v DIR_PATH: View the location of the specified directory.
        echo -k FILE_PATH [CONTENT]: Create a new file with the specified FILE_PATH and write the given CONTENT.
        exit /b
) else if "%~1"=="-ip" (
        echo Displaying all IP information...
        ipconfig /all
        echo IP information displayed.
) else if "%~1"=="-s" (
        shift
        if "%~1"=="" (
             echo Usage: w.bat -s "search_string"
             exit /b
        ) else (
             echo Searching for "%~1" in all files...
             findstr /s /m /c:"%~1" *.*
             echo Finished searching.
        )
) else if "%~1"=="-u" (
        if "%~2"=="" (
             echo Usage: w.bat -u URL
             exit /b
        ) else (
             start "" "%~2"
        )
) else if "%~1"=="-p" (
        if "%~2"=="" (
             echo Usage: w.bat -p URL
             exit /b
        ) else (
             ping -n 4 "%~2" >nul
             echo Pinging %~2...
        )
) else if "%~1"=="-w" (
        tasklist
) else if "%~1"=="-kill" (
        if "%~2"=="" (
             echo Usage: w.bat -kill PID
             exit /b
        ) else (
             taskkill /F /PID %~2
        )
) else if "%~1"=="-h" (
        echo Usage: w.bat [-ip] [-s "search_string"] [-u URL] [-p URL] [-w] [-kill PID] [-h] [-c URL [SAVE_PATH]] [-cc SOURCE_PATH DEST_PATH] [-cv SOURCE_PATH DEST_PATH] [-v DIR_PATH] [-k FILE_PATH [CONTENT]]
        echo.
        echo -ip: Display all IP information.
        echo -s "search_string": Search for files containing the specified string in their names or contents.
        echo -u URL: Open the specified URL in the default web browser.
        echo -p URL: Ping the specified URL.
        echo -w: List all running processes.
        echo -kill PID: Kill the process with the specified PID.
        echo -h: Display this help message.
        echo -c URL [SAVE_PATH]: Download the file from the specified URL to the given SAVE_PATH.
        echo -cc SOURCE_PATH DEST_PATH: Copy the file from SOURCE_PATH to DEST_PATH.
        echo -cv SOURCE_PATH DEST_PATH: Move the file from SOURCE_PATH to DEST_PATH.
        echo -v DIR_PATH: View the location of the specified directory.
        echo -k FILE_PATH [CONTENT]: Create a new file with the specified FILE_PATH and write the given CONTENT.
        exit /b
) else if "%~1"=="-c" (
        if "%~2"=="" (
             echo Usage: w.bat -c URL [SAVE_PATH]
             exit /b
        ) else (
             curl -o "%~2" "%~1"
             echo Downloading %~1 to %~2...
        )
) else if "%~1"=="-cc" (
        if "%~2"=="" (
             echo Usage: w.bat -cc SOURCE_PATH DEST_PATH
             exit /b
        ) else (
             copy "%~1" "%~2"
             echo Copied %~1 to %~2
        )
) else if "%~1"=="-cv" (
        if "%~2"=="" (
             echo Usage: w.bat -cv SOURCE_PATH DEST_PATH
             exit /b
        ) else (
             move "%~1" "%~2"
             echo Moved %~1 to %~2
        )
) else if "%~1"=="-v" (
        if "%~2"=="" (
             echo Usage: w.bat -v DIR_PATH
             exit /b
        ) else (
             echo The location of %~2 is:
             cd "%~2" && echo %CD%
        )
) else if "%~1"=="-k" (
        if "%~2"=="" (
             echo Usage: w.bat -k FILE_PATH [CONTENT]
             exit /b
        ) else (
             echo Creating file %~2...
             echo %~3 > "%~2"
             echo File %~2 has been created with content: %~3
        )
) else (
        echo Unknown option: %~1
        exit /b
)

ENDLOCAL