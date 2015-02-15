
@echo off 

 ECHO ----------------------------------------
 Echo Downloading Translations
 ECHO ----------------------------------------

 START /B /WAIT C:\Repository\SkinBuilder\xbmc-langdload.exe C:\Repository\SkinBuilder\%1.xml
 
  pause
