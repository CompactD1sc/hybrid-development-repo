
@echo off 

 ECHO ----------------------------------------
 Echo Downloading Translations
 ECHO ----------------------------------------

 START /B /WAIT D:\Repository\SkinBuilder\xbmc-langdload.exe D:\Repository\SkinBuilder\%1.xml
 
  pause
