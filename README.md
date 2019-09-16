# macOSAppOpen

This application has a proof of concept to register a folder appropriately with macOS' Launch Services.
It has been tested with Qt 5.12.1

The application just displays a string `Info: Nothing set` if it was opened normally (This is the only behavior that will happen on Windows), and will display the full path to the associated file, if it was open by double clicking a registered folder.

The registered folder has the extension `macoscrashtest`, since this was originally created to test a crash.