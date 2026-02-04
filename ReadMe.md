# RegularWorkSpaceAutomation

## Overview
RegularWorkSpaceAutomation is a simple automation project designed to streamline the process of launching a set of workspace applications. It includes two key components:
1. **AutoRun.vbs**: A VBScript file that triggers the execution of the batch file in a hidden command prompt.
2. **RegularWorkspace.bat**: A batch script that sequentially launches various workspace applications with short delays to ensure smooth initialization.

## Features
- Launches Sticky Notes, Outlook, Chrome (in Incognito mode with YouTube), Flameshot, and Visual Studio.
- Includes configurable delays between application launches to prevent system overload.
- Provides clear console output for tracking the launch process.

## Usage
1. Clone the repository to your local machine.
2. Double-click `AutoRun.vbs` to start the automation process.
3. Alternatively, execute `RegularWorkspace.bat` directly from the command prompt.

## Prerequisites
- Ensure the following applications are installed and accessible:
  - Chrome (added to the system PATH or provide the full path).
  - Flameshot (installed at `%ProgramFiles%\Flameshot\bin\flameshot.exe`).
  - Visual Studio (adjust the path in the script if necessary).
  - Outlook (registered to open via `start outlook`).
  - Sticky Notes (ensure the UWP app protocol matches your system).

## Customization
- Modify `RegularWorkspace.bat` to add or remove applications as needed.
- Adjust the delay (`ping -n`) to suit your system's performance.

## Troubleshooting
- If an application fails to launch, run the command directly in a terminal to debug.
- For UWP apps, verify the package family name using PowerShell (`Get-AppxPackage`).

## License
This project is licensed under the MIT License.