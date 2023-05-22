@echo off
setlocal enabledelayedexpansion

REM Find the home directory
for %%F in ("%USERPROFILE%") do set "HOME_DIR=%%~fF"

REM Check if Git is installed and accessible
echo Checking if Git is installed and accessible...
git --version >nul 2>&1
if errorlevel 1 (
    echo Git is not installed or not accessible.
    exit /b
) else (
    echo Git found.
)

REM Run git pull to ensure the latest version
echo ----------------------------------------------
echo Running 'git pull' to ensure the latest version...
REM Change to the script's directory
cd "%~dp0"
git pull
echo ----------------------------------------------

REM Function to copy files
:CopyFiles
set "SOURCE_DIR=%~dp0global"
set "DEST_DIR=%HOME_DIR%"

REM Iterate through files in the global folder
for %%F in ("%SOURCE_DIR%\*") do (
    REM Extract the file name
    set "FILENAME=%%~nxF"

    REM Check if the file exists in the home directory
    if exist "!DEST_DIR!\!FILENAME!" (
        echo File already exists in the home directory: !FILENAME!
        set /p "CHOICE=Do you want to overwrite it? (Y/N): "
        
        REM Convert the choice to lowercase for case-insensitive comparison
        setlocal enabledelayedexpansion
        for /f %%C in ("!CHOICE!") do (
            endlocal
            if /i "%%C"=="Y" (
                REM Copy the file from the global folder to the home directory
                copy "%%F" "!DEST_DIR!" /y >nul
                if not errorlevel 1 (
                    echo Successfully copied !FILENAME! to the home directory %HOME_DIR%.
                ) else (
                    echo Failed to copy !FILENAME! to the home directory %HOME_DIR%.
                )
            ) else (
                echo Skipping copy of !FILENAME!.
            )
        )
    ) else (
        REM Copy the file from the global folder to the home directory
        copy "%%F" "!DEST_DIR!" /y >nul
        if not errorlevel 1 (
            echo Successfully copied !FILENAME! to the home directory %HOME_DIR%.
        ) else (
            echo Failed to copy !FILENAME! to the home directory %HOME_DIR%.
        )
    )
    echo ----------------------------------------------
)
pause
endlocal
