
@echo off 

 Echo .svn>exclude.txt
 Echo .git>>exclude.txt
 Echo D:\Repository\SourceFiles\%1\media>>exclude.txt
 Echo D:\Repository\SourceFiles\%1\themes>>exclude.txt

 md BUILD\%1\media\

 ECHO ----------------------------------------
 Echo Building main skin XBT
 ECHO ----------------------------------------

 START /B /WAIT D:\Repository\SkinBuilder\TexturePacker -dupecheck -input D:\Repository\SourceFiles\%1\media -output BUILD\%1\media\Textures.xbt

 ECHO ----------------------------------------
 Echo Finished building main skin XBT
 if exist D:\Repository\SourceFiles\%1\themes (
     Echo Building theme skin XBT Files
     ECHO ----------------------------------------
    for /f "tokens=*" %%f in ('dir /b/ad D:\Repository\SourceFiles\%1\themes') do START /B /WAIT D:\Repository\SkinBuilder\TexturePacker -dupecheck -input D:\Repository\SourceFiles\%1\themes\%%f -output BUILD\%1\media\%%f.xbt
     Echo Finished Building theme skin XBT Files
 )

 ECHO ----------------------------------------
 Echo Copying other files
 ECHO ----------------------------------------

 for /f "tokens=*" %%c in ('dir /b/ad D:\Repository\SourceFiles\%1') do xcopy "D:\Repository\SourceFiles\%1\%%c" "BUILD\%1\%%c" /Q /S /I /Y /EXCLUDE:exclude.txt
 for /f "tokens=*" %%c in ('dir /b/a-d D:\Repository\SourceFiles\%1') do copy D:\Repository\SourceFiles\%1\%%c "BUILD\%1\%%c"

 del exclude.txt

FOR /F "skip=2 Tokens=2 Delims== " %%V IN ('FIND "  version=" "BUILD\%1\addon.xml"') DO SET Version=%%~V

 ECHO ----------------------------------------
 ECHO Current skin version is %Version%
 ECHO ----------------------------------------

 cd BUILD
 D:\Repository\SkinBuilder\zip.exe -r -q %1-%Version%.zip %1

  ECHO ----------------------------------------
  ECHO Moving files to repository
  ECHO ----------------------------------------

  REM if exist "D:\Repository\xbmc.repo.mudisle\%1\" rmdir "D:\Repository\xbmc.repo.mudisle\%1\" /S /Q
  REM md "D:\Repository\xbmc.repo.mudisle\%1\"
  copy "%1-%Version%.zip" "D:\Repository\%1\"
  copy "%1\fanart.jpg" "D:\Repository\%1\fanart.jpg"
  copy "%1\icon.png" "D:\Repository\%1\icon.png"
  copy "%1\addon.xml" "D:\Repository\%1\addon.xml"
  copy "%1\changelog.txt" "D:\Repository\%1\changelog-%Version%.txt"

  ECHO ----------------------------------------
  ECHO Removing BUILD folder
  ECHO ----------------------------------------

  cd ..
  rmdir BUILD /S /Q


  ECHO ----------------------------------------
  ECHO Generating addons.xml and addons.xml.md5
  ECHO ----------------------------------------

  REM cd D:\Repository\xbmc.repo.mudisle\
  REM python addons_xml_generator.py

  pause
