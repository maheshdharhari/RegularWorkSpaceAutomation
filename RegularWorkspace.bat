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
REM 
REM Extending / Modifying:
REM   - To add another app, follow the pattern: `echo <n>. <Name>...` then
REM     `start <target>` and then a short `ping` delay line.
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

@echo off
echo =================================
echo    Launching Workspace Apps
echo =================================
echo.

echo 1. Sticky Notes...
start shell:appsFolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App
ping -n 2 127.0.0.1 >nul

echo 2. Outlook...
start outlook
ping -n 2 127.0.0.1 >nul

echo 3. Chrome (YouTube - Incognito)...
start chrome --incognito "https://www.youtube.com/"
ping -n 2 127.0.0.1 >nul

echo 5. Flameshot...
start "" "%ProgramFiles%\Flameshot\bin\flameshot.exe"
ping -n 2 127.0.0.1 >nul

echo 6. Visual Studio...
start "" "%ProgramFiles%\Microsoft Visual Studio\18\Community\Common7\IDE\devenv.exe"
ping -n 2 127.0.0.1 >nul

echo.
echo =================================
echo     All applications launched!
echo =================================
exit