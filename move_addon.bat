@echo off
set addon_dir=%1
echo %addon_dir%
set dev_dir=C:/WoW_Addons/
set wow_addon_dir=C:\Program Files (x86)\World of Warcraft\_classic_era_\Interface\AddOns
set src=%dev_dir%%addon_dir%
echo %src%
set dest=%wow_addon_dir%%addon_dir%
echo %dest%
xcopy /s /i /y "%src%" "%dest%"