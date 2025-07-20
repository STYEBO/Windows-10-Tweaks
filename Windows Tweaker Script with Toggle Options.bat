@echo off
setlocal enabledelayedexpansion
color 0f
title Windows Tweaker

:: Admin check
NET FILE >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo This script requires administrator privileges.
    echo Please right-click and select "Run as administrator".
    pause
    exit /b
)

:mainmenu
cls
echo.
echo  ==============================
echo    WINDOWS TWEAKER - MAIN MENU
echo  ==============================
echo.
echo  1. Create Restore Point
echo  2. Delete Temporary files
echo  3. Toggle Consumer features (1=Disable/2=Enable)
echo  4. Toggle Telemetry (1=Disable/2=Enable)
echo  5. Toggle Activity History (1=Disable/2=Enable)
echo  6. Toggle Explorer Automatic folder Discovery (1=Disable/2=Enable)
echo  7. Toggle GameDvr (1=Disable/2=Enable)
echo  8. Toggle Hibernation (1=Disable/2=Enable)
echo  9. Toggle HomeGroup (1=Disable/2=Enable)
echo 10. Toggle Location Tracking (1=Disable/2=Enable)
echo 11. Toggle Wifi-Sense (1=Disable/2=Enable)
echo 12. Toggle Powershell 7 Telemetry (1=Disable/2=Enable)
echo 13. Toggle Recall (1=Disable/2=Enable)
echo 14. Set Hibernation as Default (good for laptop)
echo 15. Toggle Edge Debloat (1=Debloat/2=Restore)
echo 16. Toggle Teredo (1=Disable/2=Enable)
echo 17. Toggle Background Apps (1=Disable/2=Enable)
echo 18. Toggle full Screen optimization (1=Disable/2=Enable)
echo 19. Toggle Microsoft Copilot (1=Disable/2=Enable)
echo 20. Toggle Intel (VPro Lms) (1=Disable/2=Enable)
echo 21. Toggle Notification Tray/Calendar (1=Disable/2=Enable)
echo 22. Toggle Windows Platform Binary table (WPBT) (1=Disable/2=Enable)
echo 23. Toggle display for performance (1=Performance/2=Appearance)
echo 24. Run Disk Cleanup
echo 25. Remove all Windows Store apps (keep Store and Photo Viewer)
echo 26. Toggle Services (1=Manual/2=Automatic)
echo 27. UI/UX Tweaks Submenu
echo.
echo 0. Exit
echo.
set /p choice=Enter your choice (0-27): 

if "%choice%"=="0" exit /b

if "%choice%"=="1" call :createRestorePoint
if "%choice%"=="2" call :deleteTempFiles
if "%choice%"=="3" call :toggleConsumerFeatures
if "%choice%"=="4" call :toggleTelemetry
if "%choice%"=="5" call :toggleActivityHistory
if "%choice%"=="6" call :toggleAutoFolderDiscovery
if "%choice%"=="7" call :toggleGameDVR
if "%choice%"=="8" call :toggleHibernation
if "%choice%"=="9" call :toggleHomeGroup
if "%choice%"=="10" call :toggleLocationTracking
if "%choice%"=="11" call :toggleWifiSense
if "%choice%"=="12" call :togglePS7Telemetry
if "%choice%"=="13" call :toggleRecall
if "%choice%"=="14" call :setHibernationDefault
if "%choice%"=="15" call :toggleEdgeDebloat
if "%choice%"=="16" call :toggleTeredo
if "%choice%"=="17" call :toggleBackgroundApps
if "%choice%"=="18" call :toggleFullScreenOptimization
if "%choice%"=="19" call :toggleCopilot
if "%choice%"=="20" call :toggleIntelVPro
if "%choice%"=="21" call :toggleNotificationTray
if "%choice%"=="22" call :toggleWPBT
if "%choice%"=="23" call :toggleDisplayPerformance
if "%choice%"=="24" call :runDiskCleanup
if "%choice%"=="25" call :removeStoreApps
if "%choice%"=="26" call :toggleServices
if "%choice%"=="27" call :uiuxMenu

goto mainmenu

:createRestorePoint
echo Creating system restore point...
powershell -command "Checkpoint-Computer -Description 'Windows Tweaker Restore Point' -RestorePointType MODIFY_SETTINGS"
echo Restore point created successfully!
pause
goto :eof

:deleteTempFiles
echo Cleaning temporary files...
cleanmgr /sagerun:1
echo Temporary files deleted successfully!
pause
goto :eof

:toggleConsumerFeatures
echo Toggle Consumer Features:
echo 1. Disable
echo 2. Enable
set /p cfchoice=Enter your choice (1-2): 

if "%cfchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
    echo Consumer features disabled successfully!
) else if "%cfchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 0 /f
    echo Consumer features enabled successfully!
)
pause
goto :eof

:toggleTelemetry
echo Toggle Telemetry:
echo 1. Disable
echo 2. Enable
set /p tchoice=Enter your choice (1-2): 

if "%tchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
    echo Telemetry disabled successfully!
) else if "%tchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 1 /f
    echo Telemetry enabled successfully!
)
pause
goto :eof

:toggleActivityHistory
echo Toggle Activity History:
echo 1. Disable
echo 2. Enable
set /p ahchoice=Enter your choice (1-2): 

if "%ahchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f
    echo Activity history disabled successfully!
) else if "%ahchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 1 /f
    echo Activity history enabled successfully!
)
pause
goto :eof

:toggleAutoFolderDiscovery
echo Toggle Explorer Automatic Folder Discovery:
echo 1. Disable
echo 2. Enable
set /p afdchoice=Enter your choice (1-2): 

if "%afdchoice%"=="1" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f
    echo Automatic folder discovery disabled successfully!
) else if "%afdchoice%"=="2" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 1 /f
    echo Automatic folder discovery enabled successfully!
)
pause
goto :eof

:toggleGameDVR
echo Toggle GameDVR:
echo 1. Disable
echo 2. Enable
set /p gdchoice=Enter your choice (1-2): 

if "%gdchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
    echo GameDVR disabled successfully!
) else if "%gdchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 1 /f
    echo GameDVR enabled successfully!
)
pause
goto :eof

:toggleHibernation
echo Toggle Hibernation:
echo 1. Disable
echo 2. Enable
set /p hchoice=Enter your choice (1-2): 

if "%hchoice%"=="1" (
    powercfg /hibernate off
    echo Hibernation disabled successfully!
) else if "%hchoice%"=="2" (
    powercfg /hibernate on
    echo Hibernation enabled successfully!
)
pause
goto :eof

:toggleHomeGroup
echo Toggle HomeGroup:
echo 1. Disable
echo 2. Enable
set /p hgchoice=Enter your choice (1-2): 

if "%hgchoice%"=="1" (
    sc config HomeGroupListener start= disabled >nul
    sc config HomeGroupProvider start= disabled >nul
    net stop HomeGroupListener >nul
    net stop HomeGroupProvider >nul
    echo HomeGroup disabled successfully!
) else if "%hgchoice%"=="2" (
    sc config HomeGroupListener start= auto >nul
    sc config HomeGroupProvider start= auto >nul
    net start HomeGroupListener >nul
    net start HomeGroupProvider >nul
    echo HomeGroup enabled successfully!
)
pause
goto :eof

:toggleLocationTracking
echo Toggle Location Tracking:
echo 1. Disable
echo 2. Enable
set /p lchoice=Enter your choice (1-2): 

if "%lchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f
    echo Location tracking disabled successfully!
) else if "%lchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 1 /f
    echo Location tracking enabled successfully!
)
pause
goto :eof

:toggleWifiSense
echo Toggle Wi-Fi Sense:
echo 1. Disable
echo 2. Enable
set /p wschoice=Enter your choice (1-2): 

if "%wschoice%"=="1" (
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f
    echo Wi-Fi Sense disabled successfully!
) else if "%wschoice%"=="2" (
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 1 /f
    echo Wi-Fi Sense enabled successfully!
)
pause
goto :eof

:togglePS7Telemetry
echo Toggle PowerShell 7 Telemetry:
echo 1. Disable
echo 2. Enable
set /p pschoice=Enter your choice (1-2): 

if "%pschoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\PowerShellCore" /v "EnableTelemetry" /t REG_DWORD /d 0 /f
    echo PowerShell 7 telemetry disabled successfully!
) else if "%pschoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\PowerShellCore" /v "EnableTelemetry" /t REG_DWORD /d 1 /f
    echo PowerShell 7 telemetry enabled successfully!
)
pause
goto :eof

:toggleRecall
echo Toggle Recall:
echo 1. Disable
echo 2. Enable
set /p rchoice=Enter your choice (1-2): 

if "%rchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Recall" /v "Disable" /t REG_DWORD /d 1 /f
    echo Recall disabled successfully!
) else if "%rchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Recall" /v "Disable" /t REG_DWORD /d 0 /f
    echo Recall enabled successfully!
)
pause
goto :eof

:setHibernationDefault
echo Setting hibernation as default...
powercfg /hibernate on
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo Hibernation set as default successfully!
pause
goto :eof

:toggleEdgeDebloat
echo Toggle Edge Debloat:
echo 1. Debloat
echo 2. Restore
set /p edchoice=Enter your choice (1-2): 

if "%edchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisableEdgeFirstRunTask" /t REG_DWORD /d 1 /f
    echo Microsoft Edge debloated successfully!
) else if "%edchoice%"=="2" (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisableEdgeDesktopShortcutCreation" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisableEdgeFirstRunTask" /f >nul 2>&1
    echo Microsoft Edge restored to default!
)
pause
goto :eof

:toggleTeredo
echo Toggle Teredo:
echo 1. Disable
echo 2. Enable
set /p tchoice=Enter your choice (1-2): 

if "%tchoice%"=="1" (
    netsh interface teredo set state disabled
    echo Teredo disabled successfully!
) else if "%tchoice%"=="2" (
    netsh interface teredo set state default
    echo Teredo enabled successfully!
)
pause
goto :eof

:toggleBackgroundApps
echo Toggle Background Apps:
echo 1. Disable
echo 2. Enable
set /p bachoice=Enter your choice (1-2): 

if "%bachoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f
    echo Background apps disabled successfully!
) else if "%bachoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 0 /f
    echo Background apps enabled successfully!
)
pause
goto :eof

:toggleFullScreenOptimization
echo Toggle Full Screen Optimization:
echo 1. Disable
echo 2. Enable
set /p fschoice=Enter your choice (1-2): 

if "%fschoice%"=="1" (
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
    echo Full Screen Optimization disabled!
) else if "%fschoice%"=="2" (
    reg delete "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /f >nul 2>&1
    echo Full Screen Optimization enabled!
)
pause
goto :eof

:toggleCopilot
echo Toggle Microsoft Copilot:
echo 1. Disable
echo 2. Enable
set /p cchoice=Enter your choice (1-2): 

if "%cchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
    echo Microsoft Copilot disabled successfully!
) else if "%cchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f
    echo Microsoft Copilot enabled successfully!
)
pause
goto :eof

:toggleIntelVPro
echo Toggle Intel VPro LMS:
echo 1. Disable
echo 2. Enable
set /p vchoice=Enter your choice (1-2): 

if "%vchoice%"=="1" (
    sc config LMS start= disabled >nul
    net stop LMS >nul
    echo Intel VPro LMS disabled successfully!
) else if "%vchoice%"=="2" (
    sc config LMS start= auto >nul
    net start LMS >nul
    echo Intel VPro LMS enabled successfully!
)
pause
goto :eof

:toggleNotificationTray
echo Toggle Notification Tray/Calendar:
echo 1. Disable
echo 2. Enable
set /p ntchoice=Enter your choice (1-2): 

if "%ntchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f
    echo Notification Tray/Calendar disabled successfully!
) else if "%ntchoice%"=="2" (
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /f >nul 2>&1
    reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /f >nul 2>&1
    echo Notification Tray/Calendar enabled successfully!
)
pause
goto :eof

:toggleWPBT
echo Toggle Windows Platform Binary Table:
echo 1. Disable
echo 2. Enable
set /p wpbtchoice=Enter your choice (1-2): 

if "%wpbtchoice%"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FirmwareResources" /v "EnableWPBT" /t REG_DWORD /d 0 /f
    echo Windows Platform Binary Table disabled successfully!
) else if "%wpbtchoice%"=="2" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FirmwareResources" /v "EnableWPBT" /t REG_DWORD /d 1 /f
    echo Windows Platform Binary Table enabled successfully!
)
pause
goto :eof

:toggleDisplayPerformance
echo Toggle Display Performance:
echo 1. Performance
echo 2. Appearance
set /p dpchoice=Enter your choice (1-2): 

if "%dpchoice%"=="1" (
    reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f
    reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
    reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "901E078080000000" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 3 /f
    echo Display set for performance successfully!
) else if "%dpchoice%"=="2" (
    reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f
    reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "400" /f
    reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "901E078000000000" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 1 /f
    echo Display set for appearance successfully!
)
pause
goto :eof

:runDiskCleanup
echo Running Disk Cleanup...
cleanmgr /sageset:65535 >nul
cleanmgr /sagerun:65535 >nul
echo Disk Cleanup completed successfully!
pause
goto :eof

:removeStoreApps
echo Removing unwanted Windows Store apps...
powershell -command "Get-AppxPackage -AllUsers | Where-Object {$_.Name -notlike '*MicrosoftEdge*' -and $_.Name -notlike '*Photos*' -and $_.Name -notlike '*Movies & TV*' -and $_.Name -notlike '*Groove*' -and $_.Name -notlike '*Calculator*' -and $_.Name -notlike '*Alarms*' -and $_.Name -notlike '*Camera*' -and $_.Name -notlike '*Microsoft.Store*' -and $_.Name -notlike '*FileExplorer*' -and $_.Name -notlike '*Paint3D*' -and $_.Name -notlike '*StickyNotes*' -and $_.Name -notlike '*Terminal*' -and $_.Name -notlike '*Nvidia*' -and $_.Name -notlike '*Snip & Sketch*'} | Remove-AppxPackage"
echo Unwanted apps removed successfully! 
pause
goto :eof

:toggleServices
echo Toggle Services:
echo 1. Set to Manual (security focused)
echo 2. Set to Automatic (default)
set /p schoice=Enter your choice (1-2): 

if "%schoice%"=="1" (
    echo Setting services to Manual startup...
    echo This may take a moment...
    
    :: Services to change (only those with Automatic/Delayed startup in original config)
    sc config AJRouter start= demand >nul
    sc config ALG start= demand >nul
    sc config AppIDSvc start= demand >nul
    sc config AppMgmt start= demand >nul
    sc config AppReadiness start= demand >nul
    sc config AppVClient start= disabled >nul
    sc config AppXSvc start= demand >nul
    sc config Appinfo start= demand >nul
    sc config AssignedAccessManagerSvc start= disabled >nul
    sc config AudioEndpointBuilder start= auto >nul
    sc config AudioSrv start= auto >nul
    sc config Audiosrv start= auto >nul
    sc config AxInstSV start= demand >nul
    sc config BDESVC start= demand >nul
    sc config BFE start= auto >nul
    sc config BITS start= delayed-auto >nul
    sc config BTAGService start= demand >nul
    sc config BrokerInfrastructure start= auto >nul
    sc config Browser start= demand >nul
    sc config BthAvctpSvc start= auto >nul
    sc config BthHFSrv start= auto >nul
    sc config CDPSvc start= demand >nul
    sc config CDPUserSvc_* start= auto >nul
    sc config COMSysApp start= demand >nul
    sc config CertPropSvc start= demand >nul
    sc config ClipSVC start= demand >nul
    sc config CoreMessagingRegistrar start= auto >nul
    sc config CryptSvc start= auto >nul
    sc config CscService start= demand >nul
    sc config DPS start= auto >nul
    sc config DcomLaunch start= auto >nul
    sc config DcpSvc start= demand >nul
    sc config DevQueryBroker start= demand >nul
    sc config DeviceAssociationService start= demand >nul
    sc config DeviceInstall start= demand >nul
    sc config Dhcp start= auto >nul
    sc config DiagTrack start= disabled >nul
    sc config DialogBlockingService start= disabled >nul
    sc config DispBrokerDesktopSvc start= auto >nul
    sc config DisplayEnhancementService start= demand >nul
    sc config Dnscache start= auto >nul
    sc config DoSvc start= delayed-auto >nul
    sc config DusmSvc start= auto >nul
    sc config EFS start= demand >nul
    sc config EventLog start= auto >nul
    sc config EventSystem start= auto >nul
    sc config FDResPub start= demand >nul
    sc config FontCache start= auto >nul
    sc config GraphicsPerfSvc start= demand >nul
    sc config IKEEXT start= demand >nul
    sc config KeyIso start= auto >nul
    sc config LSM start= auto >nul
    sc config LanmanServer start= auto >nul
    sc config LanmanWorkstation start= auto >nul
    sc config LicenseManager start= demand >nul
    sc config LxpSvc start= demand >nul
    sc config MapsBroker start= delayed-auto >nul
    sc config McpManagementService start= demand >nul
    sc config MpsSvc start= auto >nul
    sc config MsKeyboardFilter start= demand >nul
    sc config NetTcpPortSharing start= disabled >nul
    sc config Netlogon start= auto >nul
    sc config NgcCtnrSvc start= demand >nul
    sc config NgcSvc start= demand >nul
    sc config NlaSvc start= demand >nul
    sc config OneSyncSvc_* start= auto >nul
    sc config PcaSvc start= demand >nul
    sc config PlugPlay start= demand >nul
    sc config PolicyAgent start= demand >nul
    sc config Power start= auto >nul
    sc config PrintNotify start= demand >nul
    sc config ProfSvc start= auto >nul
    sc config RemoteAccess start= disabled >nul
    sc config RemoteRegistry start= disabled >nul
    sc config RpcEptMapper start= auto >nul
    sc config RpcSs start= auto >nul
    sc config SamSs start= auto >nul
    sc config Schedule start= auto >nul
    sc config SENS start= auto >nul
    sc config SgrmBroker start= auto >nul
    sc config ShellHWDetection start= auto >nul
    sc config Spooler start= auto >nul
    sc config SstpSvc start= demand >nul
    sc config StateRepository start= demand >nul
    sc config StorSvc start= demand >nul
    sc config SysMain start= auto >nul
    sc config SystemEventsBroker start= auto >nul
    sc config TermService start= auto >nul
    sc config Themes start= auto >nul
    sc config TrkWks start= auto >nul
    sc config UevAgentService start= disabled >nul
    sc config UserManager start= auto >nul
    sc config UsoSvc start= demand >nul
    sc config VGAuthService start= auto >nul
    sc config VMTools start= auto >nul
    sc config VaultSvc start= auto >nul
    sc config WSearch start= delayed-auto >nul
    sc config Wcmsvc start= auto >nul
    sc config WinDefend start= auto >nul
    sc config Winmgmt start= auto >nul
    sc config WlanSvc start= auto >nul
    sc config WpnService start= demand >nul
    sc config WpnUserService_* start= auto >nul
    sc config cbdhsvc_* start= demand >nul
    sc config edgeupdate start= demand >nul
    sc config gpsvc start= auto >nul
    sc config iphlpsvc start= auto >nul
    sc config mpssvc start= auto >nul
    sc config nsi start= auto >nul
    sc config sppsvc start= delayed-auto >nul
    sc config ssh-agent start= disabled >nul
    sc config tiledatamodelsvc start= auto >nul
    sc config vm3dservice start= demand >nul
    sc config webthreatdefusersvc_* start= auto >nul
    sc config wscsvc start= delayed-auto >nul
    
    echo Services set to Manual startup successfully!
) else if "%schoice%"=="2" (
    echo Restoring services to default Automatic startup...
    echo This may take a moment...
    
    :: Restore default startup types
    sc config AJRouter start= demand >nul
    sc config ALG start= demand >nul
    sc config AppIDSvc start= demand >nul
    sc config AppMgmt start= demand >nul
    sc config AppReadiness start= auto >nul
    sc config AppVClient start= disabled >nul
    sc config AppXSvc start= demand >nul
    sc config Appinfo start= demand >nul
    sc config AssignedAccessManagerSvc start= demand >nul
    sc config AudioEndpointBuilder start= auto >nul
    sc config AudioSrv start= auto >nul
    sc config Audiosrv start= auto >nul
    sc config AxInstSV start= demand >nul
    sc config BDESVC start= demand >nul
    sc config BFE start= auto >nul
    sc config BITS start= delayed-auto >nul
    sc config BTAGService start= demand >nul
    sc config BrokerInfrastructure start= auto >nul
    sc config Browser start= auto >nul
    sc config BthAvctpSvc start= demand >nul
    sc config BthHFSrv start= demand >nul
    sc config CDPSvc start= auto >nul
    sc config CDPUserSvc_* start= auto >nul
    sc config COMSysApp start= demand >nul
    sc config CertPropSvc start= demand >nul
    sc config ClipSVC start= demand >nul
    sc config CoreMessagingRegistrar start= auto >nul
    sc config CryptSvc start= auto >nul
    sc config CscService start= demand >nul
    sc config DPS start= auto >nul
    sc config DcomLaunch start= auto >nul
    sc config DcpSvc start= demand >nul
    sc config DevQueryBroker start= demand >nul
    sc config DeviceAssociationService start= demand >nul
    sc config DeviceInstall start= demand >nul
    sc config Dhcp start= auto >nul
    sc config DiagTrack start= delayed-auto >nul
    sc config DialogBlockingService start= disabled >nul
    sc config DispBrokerDesktopSvc start= auto >nul
    sc config DisplayEnhancementService start= demand >nul
    sc config Dnscache start= auto >nul
    sc config DoSvc start= delayed-auto >nul
    sc config DusmSvc start= auto >nul
    sc config EFS start= demand >nul
    sc config EventLog start= auto >nul
    sc config EventSystem start= auto >nul
    sc config FDResPub start= demand >nul
    sc config FontCache start= auto >nul
    sc config GraphicsPerfSvc start= demand >nul
    sc config IKEEXT start= demand >nul
    sc config KeyIso start= auto >nul
    sc config LSM start= auto >nul
    sc config LanmanServer start= auto >nul
    sc config LanmanWorkstation start= auto >nul
    sc config LicenseManager start= demand >nul
    sc config LxpSvc start= demand >nul
    sc config MapsBroker start= auto >nul
    sc config McpManagementService start= demand >nul
    sc config MpsSvc start= auto >nul
    sc config MsKeyboardFilter start= demand >nul
    sc config NetTcpPortSharing start= disabled >nul
    sc config Netlogon start= demand >nul
    sc config NgcCtnrSvc start= demand >nul
    sc config NgcSvc start= demand >nul
    sc config NlaSvc start= auto >nul
    sc config OneSyncSvc_* start= auto >nul
    sc config PcaSvc start= auto >nul
    sc config PlugPlay start= auto >nul
    sc config PolicyAgent start= auto >nul
    sc config Power start= auto >nul
    sc config PrintNotify start= demand >nul
    sc config ProfSvc start= auto >nul
    sc config RemoteAccess start= demand >nul
    sc config RemoteRegistry start= disabled >nul
    sc config RpcEptMapper start= auto >nul
    sc config RpcSs start= auto >nul
    sc config SamSs start= auto >nul
    sc config Schedule start= auto >nul
    sc config SENS start= auto >nul
    sc config SgrmBroker start= auto >nul
    sc config ShellHWDetection start= auto >nul
    sc config Spooler start= auto >nul
    sc config SstpSvc start= demand >nul
    sc config StateRepository start= auto >nul
    sc config StorSvc start= demand >nul
    sc config SysMain start= auto >nul
    sc config SystemEventsBroker start= auto >nul
    sc config TermService start= demand >nul
    sc config Themes start= auto >nul
    sc config TrkWks start= auto >nul
    sc config UevAgentService start= disabled >nul
    sc config UserManager start= auto >nul
    sc config UsoSvc start= auto >nul
    sc config VGAuthService start= auto >nul
    sc config VMTools start= auto >nul
    sc config VaultSvc start= auto >nul
    sc config WSearch start= auto >nul
    sc config Wcmsvc start= auto >nul
    sc config WinDefend start= auto >nul
    sc config Winmgmt start= auto >nul
    sc config WlanSvc start= demand >nul
    sc config WpnService start= auto >nul
    sc config WpnUserService_* start= auto >nul
    sc config cbdhsvc_* start= demand >nul
    sc config edgeupdate start= demand >nul
    sc config gpsvc start= auto >nul
    sc config iphlpsvc start= auto >nul
    sc config mpssvc start= auto >nul
    sc config nsi start= auto >nul
    sc config sppsvc start= auto >nul
    sc config ssh-agent start= disabled >nul
    sc config tiledatamodelsvc start= auto >nul
    sc config vm3dservice start= demand >nul
    sc config webthreatdefusersvc_* start= auto >nul
    sc config wscsvc start= auto >nul
    
    echo Services restored to default Automatic startup!
)
pause
goto :eof

:uiuxMenu
cls
echo.
echo  ==============================
echo    UI/UX TWEAKS SUBMENU
echo  ==============================
echo.
echo  1. Toggle Dark Theme (1=Dark/2=Light)
echo  2. Toggle Bing Search in Start Menu (1=Disable/2=Enable)
echo  3. Toggle Numlock on Start (1=Enable/2=Disable)
echo  4. Toggle Verbose Messages During Logon (1=Enable/2=Disable)
echo  5. Toggle Recommendations in Start Menu (1=Disable/2=Enable)
echo  6. Toggle Settings Homepage (1=Remove/2=Restore)
echo  7. Toggle Snap Windows (1=Enable/2=Disable)
echo  8. Toggle Snap Assist Suggestions (1=Disable/2=Enable)
echo  9. Toggle Snap Assist Flyout (1=Disable/2=Enable)
echo 10. Toggle Mouse Acceleration (1=Disable/2=Enable)
echo 11. Toggle Sticky Keys (1=Disable/2=Enable)
echo 12. Toggle Hidden Files (1=Show/2=Hide)
echo 13. Toggle File Extensions (1=Show/2=Hide)
echo 14. Toggle Search Button in Taskbar (1=Disable/2=Enable)
echo 15. Toggle Task View Button in Taskbar (1=Disable/2=Enable)
echo 16. Toggle Taskbar Items (1=Center/2=Left)
echo 17. Toggle Widgets Button in Taskbar (1=Disable/2=Enable)
echo 18. Toggle Detailed BSoD (1=Enable/2=Disable)
echo.
echo 0. Back to Main Menu
echo.
set /p uichoice=Enter your choice (0-18): 

if "%uichoice%"=="0" goto mainmenu

if "%uichoice%"=="1" call :toggleDarkTheme
if "%uichoice%"=="2" call :toggleBingSearch
if "%uichoice%"=="3" call :toggleNumlock
if "%uichoice%"=="4" call :toggleVerboseLogon
if "%uichoice%"=="5" call :toggleStartRecommendations
if "%uichoice%"=="6" call :toggleSettingsHomepage
if "%uichoice%"=="7" call :toggleSnapWindows
if "%uichoice%"=="8" call :toggleSnapAssistSuggestions
if "%uichoice%"=="9" call :toggleSnapAssistFlyout
if "%uichoice%"=="10" call :toggleMouseAcceleration
if "%uichoice%"=="11" call :toggleStickyKeys
if "%uichoice%"=="12" call :toggleHiddenFiles
if "%uichoice%"=="13" call :toggleFileExtensions
if "%uichoice%"=="14" call :toggleSearchButton
if "%uichoice%"=="15" call :toggleTaskViewButton
if "%uichoice%"=="16" call :toggleTaskbarItems
if "%uichoice%"=="17" call :toggleWidgetsButton
if "%uichoice%"=="18" call :toggleDetailedBSOD

goto uiuxMenu

:toggleDarkTheme
echo Toggle Dark Theme:
echo 1. Dark
echo 2. Light
set /p dtchoice=Enter your choice (1-2): 

if "%dtchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d 0 /f
    echo Dark theme configured successfully!
) else if "%dtchoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d 0 /f
    echo Light theme configured successfully!
)
pause
goto :eof

:toggleBingSearch
echo Toggle Bing Search in Start Menu:
echo 1. Disable
echo 2. Enable
set /p bschoice=Enter your choice (1-2): 

if "%bschoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f
    echo Bing Search in Start Menu disabled successfully!
) else if "%bschoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 1 /f
    echo Bing Search in Start Menu enabled successfully!
)
pause
goto :eof

:toggleNumlock
echo Toggle Numlock on Start:
echo 1. Enable
echo 2. Disable
set /p nchoice=Enter your choice (1-2): 

if "%nchoice%"=="1" (
    reg add "HKCU\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
    echo Numlock on Start enabled successfully!
) else if "%nchoice%"=="2" (
    reg add "HKCU\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "0" /f
    echo Numlock on Start disabled successfully!
)
pause
goto :eof

:toggleVerboseLogon
echo Toggle Verbose Messages During Logon:
echo 1. Enable
echo 2. Disable
set /p vlchoice=Enter your choice (1-2): 

if "%vlchoice%"=="1" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "verbosestatus" /t REG_DWORD /d 1 /f
    echo Verbose Messages During Logon enabled successfully!
) else if "%vlchoice%"=="2" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "verbosestatus" /t REG_DWORD /d 0 /f
    echo Verbose Messages During Logon disabled successfully!
)
pause
goto :eof

:toggleStartRecommendations
echo Toggle Recommendations in Start Menu:
echo 1. Disable
echo 2. Enable
set /p srchoice=Enter your choice (1-2): 

if "%srchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
    echo Recommendations in Start Menu disabled successfully!
) else if "%srchoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 1 /f
    echo Recommendations in Start Menu enabled successfully!
)
pause
goto :eof

:toggleSettingsHomepage
echo Toggle Settings Homepage:
echo 1. Remove
echo 2. Restore
set /p shchoice=Enter your choice (1-2): 

if "%shchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide" /f
    echo Settings Homepage removed successfully!
) else if "%shchoice%"=="2" (
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /f >nul 2>&1
    echo Settings Homepage restored successfully!
)
pause
goto :eof

:toggleSnapWindows
echo Toggle Snap Windows:
echo 1. Enable
echo 2. Disable
set /p swchoice=Enter your choice (1-2): 

if "%swchoice%"=="1" (
    reg add "HKCU\Control Panel\Desktop" /v "WindowArrangementActive" /t REG_DWORD /d 1 /f
    echo Snap Windows enabled successfully!
) else if "%swchoice%"=="2" (
    reg add "HKCU\Control Panel\Desktop" /v "WindowArrangementActive" /t REG_DWORD /d 0 /f
    echo Snap Windows disabled successfully!
)
pause
goto :eof

:toggleSnapAssistSuggestions
echo Toggle Snap Assist Suggestions:
echo 1. Disable
echo 2. Enable
set /p saschoice=Enter your choice (1-2): 

if "%saschoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssistSuggestions" /t REG_DWORD /d 0 /f
    echo Snap Assist Suggestions disabled successfully!
) else if "%saschoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssistSuggestions" /t REG_DWORD /d 1 /f
    echo Snap Assist Suggestions enabled successfully!
)
pause
goto :eof

:toggleSnapAssistFlyout
echo Toggle Snap Assist Flyout:
echo 1. Disable
echo 2. Enable
set /p safchoice=Enter your choice (1-2): 

if "%safchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssistFlyout" /t REG_DWORD /d 0 /f
    echo Snap Assist Flyout disabled successfully!
) else if "%safchoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssistFlyout" /t REG_DWORD /d 1 /f
    echo Snap Assist Flyout enabled successfully!
)
pause
goto :eof

:toggleMouseAcceleration
echo Toggle Mouse Acceleration:
echo 1. Disable
echo 2. Enable
set /p machoice=Enter your choice (1-2): 

if "%machoice%"=="1" (
    reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
    reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
    reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
    echo Mouse Acceleration disabled successfully!
) else if "%machoice%"=="2" (
    reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f
    reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f
    reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f
    echo Mouse Acceleration enabled successfully!
)
pause
goto :eof

:toggleStickyKeys
echo Toggle Sticky Keys:
echo 1. Disable
echo 2. Enable
set /p skchoice=Enter your choice (1-2): 

if "%skchoice%"=="1" (
    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
    echo Sticky Keys disabled successfully!
) else if "%skchoice%"=="2" (
    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "510" /f
    echo Sticky Keys enabled successfully!
)
pause
goto :eof

:toggleHiddenFiles
echo Toggle Hidden Files:
echo 1. Show
echo 2. Hide
set /p hfchoice=Enter your choice (1-2): 

if "%hfchoice%"=="1" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f
    echo Hidden Files shown successfully!
) else if "%hfchoice%"=="2" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f
    echo Hidden Files hidden successfully!
)
pause
goto :eof

:toggleFileExtensions
echo Toggle File Extensions:
echo 1. Show
echo 2. Hide
set /p fechoice=Enter your choice (1-2): 

if "%fechoice%"=="1" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
    echo File Extensions shown successfully!
) else if "%fechoice%"=="2" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 1 /f
    echo File Extensions hidden successfully!
)
pause
goto :eof

:toggleSearchButton
echo Toggle Search Button in Taskbar:
echo 1. Disable
echo 2. Enable
set /p sbchoice=Enter your choice (1-2): 

if "%sbchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
    echo Search Button in Taskbar disabled successfully!
) else if "%sbchoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f
    echo Search Button in Taskbar enabled successfully!
)
pause
goto :eof

:toggleTaskViewButton
echo Toggle Task View Button in Taskbar:
echo 1. Disable
echo 2. Enable
set /p tvchoice=Enter your choice (1-2): 

if "%tvchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
    echo Task View Button in Taskbar disabled successfully!
) else if "%tvchoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 1 /f
    echo Task View Button in Taskbar enabled successfully!
)
pause
goto :eof

:toggleTaskbarItems
echo Toggle Taskbar Items:
echo 1. Center
echo 2. Left
set /p tichoice=Enter your choice (1-2): 

if "%tichoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSi" /t REG_DWORD /d 0 /f
    echo Taskbar Items centered successfully!
) else if "%tichoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSi" /t REG_DWORD /d 1 /f
    echo Taskbar Items aligned left successfully!
)
pause
goto :eof

:toggleWidgetsButton
echo Toggle Widgets Button in Taskbar:
echo 1. Disable
echo 2. Enable
set /p wbchoice=Enter your choice (1-2): 

if "%wbchoice%"=="1" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f
    echo Widgets Button in Taskbar disabled successfully!
) else if "%wbchoice%"=="2" (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 1 /f
    echo Widgets Button in Taskbar enabled successfully!
)
pause
goto :eof

:toggleDetailedBSOD
echo Toggle Detailed BSoD:
echo 1. Enable
echo 2. Disable
set /p bsodchoice=Enter your choice (1-2): 

if "%bsodchoice%"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d 1 /f
    echo Detailed BSoD enabled successfully!
) else if "%bsodchoice%"=="2" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d 0 /f
    echo Detailed BSoD disabled successfully!
)
pause
goto :eof