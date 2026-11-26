@echo off
setlocal
set "ROOT=%~dp0"

echo Searching under "%ROOT%" for .terraform directories...
set "FOUND="
for /d /r "%ROOT%" %%D in (.terraform) do (
    set "FOUND=1"
    echo %%D
)

if not defined FOUND (
    echo No .terraform directories found.
    exit /b 0
)

choice /C YN /N /M "Delete all listed directories? [Y/N] "
if errorlevel 2 (
    echo Cancelled.
    exit /b 0
)

set "FAILED="
for /d /r "%ROOT%" %%D in (.terraform) do (
    if exist "%%D\." (
        echo Deleting "%%D"
        rd /s /q "%%D"
        if exist "%%D\." set "FAILED=1"
    )
)

if defined FAILED exit /b 1
echo Cleanup complete.
