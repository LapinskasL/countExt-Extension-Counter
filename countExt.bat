:: Author: Lukas Lapinskas
:: Summary: Displays the number of files in a directory
::			with a user-defined extension.

:: Turns off command echoing in console
@echo off 

:: Sets variables local to batch file and enables
:: delayed expansion
setlocal enabledelayedexpansion

:: Displays batch file usage if no argument is given
if "%1" == "" (
	echo Usage: %0 directory_path
	echo Displays the number of files in a directory
	echo with a user-defined extension.

	:: Exits batch script with error level 1
	exit /b 1
)

:: Displays message if directory does not exist
if not exist "%1" (
	echo The directory provided does not exist.

	:: Exits batch script with error level 2
	exit /b 2
)

:: Prompts user for an extension and stores input in extension variable
set /p extension=Please enter the extension to process: 

:: If first character of %extension% is not a dot, add
:: a dot to the beginning
if not "!extension:~0,1!" == "." set "extension=.!extension!"

:: Initializes variable count with numeric expression 0
set /a count=0

:: Displays processing message
echo Processing ...

:: Loops through the output of each line of the commands.
:: The commands locate all files ending with !extension! 
:: in a given directory path.
for /f "delims=" %%f in ('dir /s/b /a-d "%1" ^| findstr /e /l "!extension!"') do (
	
	:: Increments the count variable
	set /a count+=1

	:: Initializes line variable to hold each output line
	set line=%%f

	:: Displays each output line, which is the full path to file
	echo !line!
)

:: Display a space
echo.

:: If no files are found, displays a message. If one or more are found,
:: displays a slightly different message
if !count! == 0 (
	echo There are no files with the '!extension!' extension.
) else (
	echo There are !count! files with the '!extension!' extension.
)

:: Ends local batch file variables
endlocal

:: Exits with an error code of 0
exit /b 0