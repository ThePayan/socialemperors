; Inno Setup script for the Social Empires desktop app (Windows).
; Build the app first (pyinstaller app/social-empires.spec), then:
;   iscc /DMyAppVersion=0.04a app\installer.iss
; Output: dist\SocialEmpires-Setup.exe

#define MyAppName "Social Empires"
#ifndef MyAppVersion
  #define MyAppVersion "0.04a"
#endif
#define MyAppExeName "SocialEmpires.exe"

[Setup]
AppId={{6F0B8B57-3C8E-4C61-9A3E-5E2C7F1D0A11}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=Social Emperors (fan preservation project)
AppPublisherURL=https://github.com/AcidCaos/socialemperors
DefaultDirName={autopf}\SocialEmpires
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
; Per-user install by default: no administrator rights needed.
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\dist
OutputBaseFilename=SocialEmpires-Setup
SetupIconFile=..\build\icon.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
; Game assets are already-compressed SWF files: fast compression is almost as small.
Compression=lzma2/fast
SolidCompression=no
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "..\dist\SocialEmpires\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall skipifsilent

; Saved empires live in %APPDATA%\SocialEmpires and are kept on uninstall.
