# run in powershell.exe -ExecutionPolicy Unrestricted

cd "C:\Program Files (x86)\Revenge Of The Titans HIB" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files (x86)\Machinarium" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files (x86)\WinSCP" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files\digiKam" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files\LibreOffice" ; if ($?) { compact /C /S /EXE:XPRESS8K }
cd "C:\Program Files\GIMP 2" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files\Java" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files\VideoLAN" ; if ($?) { compact /C /S /EXE:XPRESS8K }
cd "C:\eclipse" ; if ($?) { compact /C /S /EXE:LZX }
cd "C:\Program Files\WindowsApps" ; if ($?) { compact /C /S /EXE }
cd "C:\Program Files (x86)\Steam" ; if ($?) { compact /C /S /EXE }
cd "C:\Program Files (x86)\Rage Software" ; if ($?) { compact /C /S /EXE:LZX }

cd "C:\Program Files" ; if ($?) { compact /C /S /EXE }
cd "C:\Program Files (x86)" ; if ($?) { compact /C /S /EXE }

