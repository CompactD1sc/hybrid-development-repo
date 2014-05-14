
@echo off 

 ECHO ----------------------------------------
 Echo Downloading Translations
 ECHO ----------------------------------------

 START /B /WAIT D:\Repository\trunk\SkinBuilder\xbmc-langdload.exe D:\Repository\trunk\SkinBuilder\%1.xml
 
  pause
