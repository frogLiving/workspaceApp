# Install Citrix Workspace Powershell Script

## Use
This will work as a stand alone script or inside of SCCM.  If you have multiple copies of Citrix workspace installed I use this script to clean out the junk to allow for the new app.

## Side affects
For some odd reason on some machines this script will fail when trying to copy from the C:\Windows\Temp folder when run as system.  Due to this it is important you follow Citrix documents when setting up your detection of the applications.

## How to use
Add the installer to the same directy as the Powershell script and run the script.  Its that simple.  Ideally, I set this up to work well with SCCM.
