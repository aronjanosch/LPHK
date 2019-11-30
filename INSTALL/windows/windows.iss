; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define FileHandle
#define FileLine
#define MyAppVersion
#sub ProcessFileLine
  #define FileLine = FileRead(FileHandle)
  #define public MyAppVersion = FileLine
  #pragma message "Version: " + MyAppVersion
#endsub
#for {FileHandle = FileOpen("..\..\VERSION"); \
  FileHandle && !FileEof(FileHandle); ""} \
  ProcessFileLine
#if FileHandle
  #expr FileClose(FileHandle)
#endif

#define MyAppName "LPHK"
#define MyAppPublisher "Ella Jameson (nimaid)"
#define MyAppURL "https://github.com/nimaid/LPHK"
#define MyAppExeName "LPHK.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A6E030E7-C7D0-4EA7-BBD9-4AD52745451B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog
OutputDir=..\..\__setup__
OutputBaseFilename=LPHK_setup_{#MyAppVersion}
SetupIconFile=..\..\resources\LPHK.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\dist\LPHK.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\user_layouts\*"; DestDir: "{app}\user_layouts"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\..\user_scripts\*"; DestDir: "{app}\user_scripts"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\..\user_sounds\*"; DestDir: "{app}\user_sounds"; Flags: ignoreversion recursesubdirs createallsubdirs; AfterInstall: MyAfterInstall
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; IconFilename: "{app}\{#MyAppExeName}"

[Code]
var CancelWithoutPrompt: boolean;

function InitializeSetup(): Boolean;
begin
  CancelWithoutPrompt := false;
  result := true;
end;

procedure MyAfterInstall();
begin
  SaveStringToFile(ExpandConstant('{app}\INSTALLED'), '', True);
end;

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: shellexec postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
