$packageName = 'EqEmu-x86-Bots' # arbitrary name for the package, used in messages
$installerType = 'MSI' #only one of these: exe, msi, msu
$url = 'http://ricardocampos.github.io/downloads/EqEmuInstaller.msi' # download url
$mapsurl = 'http://ricardocampos.github.io/downloads/Maps.zip' # maps download url
$questsurl = 'http://ricardocampos.github.io/downloads/Quests.zip' # maps download url
$silentArgs = '/qb' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes

try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  Install-ChocolateyZipPackage "http://ricardocampos.github.io/downloads/PeqDatabase.zip" "C:\EQEmu\Sql"
  Install-ChocolateyZipPackage "http://ricardocampos.github.io/downloads/Maps.zip" "C:\EQEmu\Maps"
  Install-ChocolateyZipPackage "http://ricardocampos.github.io/downloads/Quests.zip" "C:\EQEmu\Quests"
  # Runs processes asserting UAC, will assert administrative rights - used by Install-ChocolateyInstallPackage
  Start-ChocolateyProcessAsAdmin '' 'EqInstallHelper.exe' -validExitCodes $validExitCodes
  # add specific folders to the path - any executables found in the chocolatey package folder will already be on the path. This is used in addition to that or for cases when a native installer doesn't add things to the path.
  #Install-ChocolateyPath 'LOCATION_TO_ADD_TO_PATH' 'User_OR_Machine' # Machine will assert administrative rights
  # add specific files as shortcuts to the desktop
  $target = Join-Path $MyInvocation.MyCommand.Definition "Startup.bat"
  Install-ChocolateyDesktopLink $target
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
