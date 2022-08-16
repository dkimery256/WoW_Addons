@echo off
set addon_dir=%1
echo %addon_dir%
set wow_addon_dir=C:/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/
set dest=%wow_addon_dir%%addon_dir%
echo %dest%
rm -rf "%dest%"