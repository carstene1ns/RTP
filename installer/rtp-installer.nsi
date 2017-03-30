
;--------------------------------------
;General

Name "EasyRPG RTP"
!define /date TODAY "%Y-%m-%d"
OutFile "easyrpg-rtp-${TODAY}.exe"
;Default installation folder
InstallDir "$PROGRAMFILES\EasyRPG\RTP"
CRCCheck On
;not needed, but future-proof
;unicode true

;default is development mode, pass /Drelease or -drelease for release mode
!ifdef release
  ;default is zlib
  SetCompressor /SOLID "lzma"
!else
  ShowInstDetails "show"
  ShowUninstDetails "show"
!endif

;--------------------------------------
;Modern UI

!include MUI2.nsh

!define MUI_ICON "media/icon.ico"
!define MUI_UNICON "media/icon.ico"

!define MUI_UNABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE license_combined.txt
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
;!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

;--------------------------------------
Section "Install"

CreateDirectory "$INSTDIR"
SetOutPath "$INSTDIR"

;FILELIST INSTALL START
File "..\AUTHORS.md"
File "..\README.md"
File "..\COPYING"

CreateDirectory "$INSTDIR\Backdrop"
SetOutPath "$INSTDIR\Backdrop"

CreateDirectory "$INSTDIR\Battle"
SetOutPath "$INSTDIR\Battle"

CreateDirectory "$INSTDIR\Battle2"
SetOutPath "$INSTDIR\Battle2"

CreateDirectory "$INSTDIR\BattleCharSet"
SetOutPath "$INSTDIR\BattleCharSet"

CreateDirectory "$INSTDIR\BattleWeapon"
SetOutPath "$INSTDIR\BattleWeapon"
File "..\BattleWeapon\weapons.png"

CreateDirectory "$INSTDIR\CharSet"
SetOutPath "$INSTDIR\CharSet"
File "..\CharSet\Chara1.png"

CreateDirectory "$INSTDIR\ChipSet"
SetOutPath "$INSTDIR\ChipSet"
File "..\ChipSet\Basis.png"

CreateDirectory "$INSTDIR\FaceSet"
SetOutPath "$INSTDIR\FaceSet"

CreateDirectory "$INSTDIR\Frame"
SetOutPath "$INSTDIR\Frame"

CreateDirectory "$INSTDIR\GameOver"
SetOutPath "$INSTDIR\GameOver"

CreateDirectory "$INSTDIR\Monster"
SetOutPath "$INSTDIR\Monster"

CreateDirectory "$INSTDIR\Movie"
SetOutPath "$INSTDIR\Movie"

CreateDirectory "$INSTDIR\Music"
SetOutPath "$INSTDIR\Music"
File "..\Music\Church.mid"
File "..\Music\BattleEnd2.mid"
File "..\Music\Inn1.mid"
File "..\Music\Fanfare3.mid"
File "..\Music\Ride1.mid"
File "..\Music\Fanfare2.mid"
File "..\Music\GameOver1.mid"
File "..\Music\Gag1.mid"
File "..\Music\Opening2.mid"
File "..\Music\Item.mid"
File "..\Music\BattleEnd1.mid"
File "..\Music\Doubt.mid"
File "..\Music\BattleEnd4.mid"
File "..\Music\Fanfare4.mid"
File "..\Music\Sad.mid"
File "..\Music\Field1.mid"
File "..\Music\Fanfare1.mid"
File "..\Music\Castle1.mid"
File "..\Music\Fanfare6.mid"
File "..\Music\Fanfare5.mid"
File "..\Music\Riddle.mid"
File "..\Music\Town1.mid"
File "..\Music\Battle1.mid"
File "..\Music\Mystery1.mid"
File "..\Music\Gag2.mid"
File "..\Music\BattleEnd3.mid"
File "..\Music\Inn2.mid"
File "..\Music\Ending2.mid"
File "..\Music\Dungeon1.mid"

CreateDirectory "$INSTDIR\Panorama"
SetOutPath "$INSTDIR\Panorama"
File "..\Panorama\dusk1.png"
File "..\Panorama\planet2.png"
File "..\Panorama\planet1.png"
File "..\Panorama\dawn2.png"
File "..\Panorama\night2.png"
File "..\Panorama\strange.png"
File "..\Panorama\night1.png"
File "..\Panorama\dusk2.png"
File "..\Panorama\sky2.png"
File "..\Panorama\planet3.png"
File "..\Panorama\space.png"
File "..\Panorama\dawn1.png"
File "..\Panorama\sky1.png"

CreateDirectory "$INSTDIR\Picture"
SetOutPath "$INSTDIR\Picture"

CreateDirectory "$INSTDIR\Sound"
SetOutPath "$INSTDIR\Sound"

CreateDirectory "$INSTDIR\System"
SetOutPath "$INSTDIR\System"

CreateDirectory "$INSTDIR\System2"
SetOutPath "$INSTDIR\System2"

CreateDirectory "$INSTDIR\Title"
SetOutPath "$INSTDIR\Title"
File "..\Title\Title2.png"
File "..\Title\Title3.png"
File "..\Title\Title4.png"
File "..\Title\Title1.png"

!define INSTALLSIZE 1756562
;FILELIST INSTALL END

;create start menu items
!define startmenu "$SMPROGRAMS\EasyRPG\RTP"
CreateDirectory "${startmenu}"
CreateShortCut "${startmenu}\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
CreateShortCut "${startmenu}\Readme.lnk" "$INSTDIR\README.md"
WriteINIStr "${startmenu}\Web Site.url" "InternetShortcut" "URL" "https://easyrpg.org"
;CreateShortCut "${startmenu}\Web Site.lnk "https://easyrpg.org" "URL"

;write path information for our Player
WriteRegStr HKLM "Software\EasyRPG\RTP" "path" "$INSTDIR"

;write uninstall information to the registry
!define uninstkey "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\EasyRPG RTP"
WriteRegStr HKLM "${uninstkey}" "DisplayName" "EasyRPG RTP (remove only)"
WriteRegStr HKLM "${uninstkey}" "UninstallString" "$INSTDIR\Uninstall.exe"
WriteRegStr HKLM "${uninstkey}" "QuietUninstallString" "$INSTDIR\Uninstall.exe /S"
WriteRegStr HKLM "${uninstkey}" "InstallLocation" "$INSTDIR"
WriteRegStr HKLM "${uninstkey}" "DisplayIcon" "$INSTDIR\logo.ico"
WriteRegDWORD HKLM "${uninstkey}" "NoModify" 1
WriteRegDWORD HKLM "${uninstkey}" "NoRepair" 1
WriteRegDWORD HKLM "${uninstkey}" "EstimatedSize" ${INSTALLSIZE}

WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------------
Section "Uninstall"

;FILELIST UNINSTALL START
Delete "$INSTDIR\AUTHORS.md"
Delete "$INSTDIR\README.md"
Delete "$INSTDIR\COPYING"
Delete "$INSTDIR\BattleWeapon\weapons.png"
Delete "$INSTDIR\CharSet\Chara1.png"
Delete "$INSTDIR\ChipSet\Basis.png"
Delete "$INSTDIR\Music\Church.mid"
Delete "$INSTDIR\Music\BattleEnd2.mid"
Delete "$INSTDIR\Music\Inn1.mid"
Delete "$INSTDIR\Music\Fanfare3.mid"
Delete "$INSTDIR\Music\Ride1.mid"
Delete "$INSTDIR\Music\Fanfare2.mid"
Delete "$INSTDIR\Music\GameOver1.mid"
Delete "$INSTDIR\Music\Gag1.mid"
Delete "$INSTDIR\Music\Opening2.mid"
Delete "$INSTDIR\Music\Item.mid"
Delete "$INSTDIR\Music\BattleEnd1.mid"
Delete "$INSTDIR\Music\Doubt.mid"
Delete "$INSTDIR\Music\BattleEnd4.mid"
Delete "$INSTDIR\Music\Fanfare4.mid"
Delete "$INSTDIR\Music\Sad.mid"
Delete "$INSTDIR\Music\Field1.mid"
Delete "$INSTDIR\Music\Fanfare1.mid"
Delete "$INSTDIR\Music\Castle1.mid"
Delete "$INSTDIR\Music\Fanfare6.mid"
Delete "$INSTDIR\Music\Fanfare5.mid"
Delete "$INSTDIR\Music\Riddle.mid"
Delete "$INSTDIR\Music\Town1.mid"
Delete "$INSTDIR\Music\Battle1.mid"
Delete "$INSTDIR\Music\Mystery1.mid"
Delete "$INSTDIR\Music\Gag2.mid"
Delete "$INSTDIR\Music\BattleEnd3.mid"
Delete "$INSTDIR\Music\Inn2.mid"
Delete "$INSTDIR\Music\Ending2.mid"
Delete "$INSTDIR\Music\Dungeon1.mid"
Delete "$INSTDIR\Panorama\dusk1.png"
Delete "$INSTDIR\Panorama\planet2.png"
Delete "$INSTDIR\Panorama\planet1.png"
Delete "$INSTDIR\Panorama\dawn2.png"
Delete "$INSTDIR\Panorama\night2.png"
Delete "$INSTDIR\Panorama\strange.png"
Delete "$INSTDIR\Panorama\night1.png"
Delete "$INSTDIR\Panorama\dusk2.png"
Delete "$INSTDIR\Panorama\sky2.png"
Delete "$INSTDIR\Panorama\planet3.png"
Delete "$INSTDIR\Panorama\space.png"
Delete "$INSTDIR\Panorama\dawn1.png"
Delete "$INSTDIR\Panorama\sky1.png"
Delete "$INSTDIR\Title\Title2.png"
Delete "$INSTDIR\Title\Title3.png"
Delete "$INSTDIR\Title\Title4.png"
Delete "$INSTDIR\Title\Title1.png"

RMDir "$INSTDIR\Backdrop"
RMDir "$INSTDIR\Battle"
RMDir "$INSTDIR\Battle2"
RMDir "$INSTDIR\BattleCharSet"
RMDir "$INSTDIR\BattleWeapon"
RMDir "$INSTDIR\CharSet"
RMDir "$INSTDIR\ChipSet"
RMDir "$INSTDIR\FaceSet"
RMDir "$INSTDIR\Frame"
RMDir "$INSTDIR\GameOver"
RMDir "$INSTDIR\Monster"
RMDir "$INSTDIR\Movie"
RMDir "$INSTDIR\Music"
RMDir "$INSTDIR\Panorama"
RMDir "$INSTDIR\Picture"
RMDir "$INSTDIR\Sound"
RMDir "$INSTDIR\System"
RMDir "$INSTDIR\System2"
RMDir "$INSTDIR\Title"
;FILELIST UNINSTALL END

Delete "$INSTDIR\Uninstall.exe"

;Remove the installation directory
RMDir "$INSTDIR"
;try to remove the org folder, too - only happens when empty: not possible currently

;Delete Start Menu Shortcuts
Delete "${startmenu}\Uninstall.lnk"
Delete "${startmenu}\Readme.lnk"
Delete "${startmenu}\Web Site.url"
;Delete "${startmenu}\Web Site.lnk"
RmDir "${startmenu}"
;try to remove the org folder, too - only happens when empty
RmDir "$SMPROGRAMS\EasyRPG"

;remove registry entries
DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\EasyRPG\RTP"
DeleteRegKey HKEY_LOCAL_MACHINE "${uninstkey}"

SectionEnd

;--------------------------------------
;eof