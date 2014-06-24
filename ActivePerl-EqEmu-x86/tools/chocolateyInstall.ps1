$packageName = 'ActivePerl-EqEmu-x86' # arbitrary name for the package, used in messages
$installerType = 'MSI' #only one of these: exe, msi, msu
$url = 'http://eqemu.github.io/downloads/ActivePerl-5.16.3.1604-MSWin32-x86-298023.msi' # download url
$silentArgs = '/qb PERL_PATH=Yes PERL_EXT=Yes' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes

