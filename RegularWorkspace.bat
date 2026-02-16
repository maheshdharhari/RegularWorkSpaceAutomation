@echo off
REM ============================================================================
REM RegularWorkspace.bat
REM ----------------------------------------------------------------------------
REM Purpose:
REM   Launches a set of workspace applications in sequence with short pauses
REM   between each start command so the desktop and OS have time to initialize
REM   the launched apps.
REM 
REM Usage:
REM   - Double-click this .bat file or run it from a command prompt.
REM   - Can be used as the action in a scheduled task or startup shortcut.
REM 
REM Prerequisites / Assumptions:
REM   - Chrome is on the system PATH (or replace with full path to chrome.exe).
REM   - Flameshot is installed to "%ProgramFiles%\Flameshot\bin\flameshot.exe".
REM   - Visual Studio is installed at the path shown (adjust if using a different
REM     VS edition or install location).
REM   - Outlook is installed and registered so "start outlook" opens it.
REM   - This script uses a UWP app protocol to start Sticky Notes:
REM       shell:appsFolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App
REM     If Sticky Notes package id differs on your machine, update this value.
REM 
REM Implementation notes:
REM   - Uses `start` to launch each application. When the target path contains
REM     spaces, an empty title argument `""` is provided to `start` (see
REM     usages for Flameshot and Visual Studio).
REM   - Uses `ping -n 2 127.0.0.1 >nul` as a lightweight cross-Windows way to
REM     create a short (~1–2 second) delay between launches. Adjust `-n` to
REM     increase/decrease the wait time as needed.
REM   - The script prints simple status lines to the console for readability.
REM   - Uses PowerShell for reliable process checking with consistent logic.
REM   - Checks if applications are already running but still opens Chrome URLs.
REM 
REM Extending / Modifying:
REM   - To add another app, follow the pattern: `echo <n>. <Name>...` then
REM     PowerShell check and conditional launch.
REM   - To use a different browser or arguments, replace the chrome calls with
REM     the desired executable and flags.
REM   - Ensure any paths with spaces use `start "" "<full path>"`.
REM 
REM Troubleshooting:
REM   - If an app does not start, try running the command directly in a cmd
REM     prompt to see error output (remove `>nul` to inspect ping output if needed).
REM   - If a UWP app does not launch, verify the package family name via
REM     `Get-AppxPackage` in PowerShell or re-check the appsFolder alias.
REM ============================================================================

echo =================================
echo    Launching Workspace Apps
echo =================================
echo.

echo 1. Checking Sticky Notes...
powershell -Command "if (Get-Process -Name 'Microsoft.Notes' -ErrorAction SilentlyContinue) { Write-Output '  Sticky Notes is already running.' } else { Write-Output '  Starting Sticky Notes...'; exit 1 }"
if %errorlevel% equ 1 (
    start shell:appsFolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App
)
ping -n 2 127.0.0.1 >nul

echo 2. Checking Outlook...
powershell -Command "if (Get-Process -Name 'OUTLOOK' -ErrorAction SilentlyContinue) { Write-Output '  Outlook is already running.' } else { Write-Output '  Starting Outlook...'; exit 1 }"
if %errorlevel% equ 1 (
    start outlook
)
ping -n 2 127.0.0.1 >nul

echo 3. Chrome (YouTube - Incognito)...
echo   Opening YouTube in Incognito mode...
REM Chrome URLs always open, no check needed
start chrome --incognito "https://www.youtube.com/"
ping -n 2 127.0.0.1 >nul

echo 4. Chrome (TFS Dashboard)...
echo   Opening TFS Dashboard in new window...
REM Chrome URLs always open, no check needed
start chrome --new-window "https://tfs.tzunami.net/tfs/DefaultCollection/Deployer/_home"
ping -n 2 127.0.0.1 >nul

echo 5. Checking Flameshot...
powershell -Command "if (Get-Process -Name 'flameshot' -ErrorAction SilentlyContinue) { Write-Output '  Flameshot is already running.' } else { Write-Output '  Starting Flameshot...'; exit 1 }"
if %errorlevel% equ 1 (
    start "" "%ProgramFiles%\Flameshot\bin\flameshot.exe"
)
ping -n 2 127.0.0.1 >nul

echo 6. Checking Visual Studio...
powershell -Command "if (Get-Process -Name 'devenv' -ErrorAction SilentlyContinue) { Write-Output '  Visual Studio is already running.'; Write-Output '  (Will not launch another instance as admin)'; exit 0 } else { Write-Output '  Starting Visual Studio (as Administrator)...'; exit 1 }"
if %errorlevel% equ 1 (
    powershell -Command "Start-Process -FilePath '$env:ProgramFiles\Microsoft Visual Studio\18\Community\Common7\IDE\devenv.exe' -Verb RunAs"
)
ping -n 2 127.0.0.1 >nul

echo.
echo =================================
echo     All applications launched!
echo =================================
pause