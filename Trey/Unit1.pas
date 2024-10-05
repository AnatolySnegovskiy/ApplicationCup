unit Unit1;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bass, StdCtrls, ComCtrls, xpman, ShellApi, uSimpleTray, Menus,
  sSkinProvider, sSkinManager, sScrollBar,Tlhelp32;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    g1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
     procedure ActionIcon(n:Integer;Icon:TIcon);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure WindowMessage(Var Msg:TMessage); message WM_SYSCOMMAND;
      procedure OnMinimizeProc(Sender: TObject);
      Procedure MouseClick(var Msg:TMessage); message WM_USER+1;
    procedure g1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    function KillTask(ExeFileName: string): integer;
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.onMinimize:=OnMinimizeProc;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Left:=999999;
Application.Minimize;
end;

procedure TForm1.WindowMessage(var Msg: TMessage);
begin
 IF Msg.WParam=SC_MINIMIZE then Begin
ActionIcon (1,Application.Icon);
ShowWindow(Handle,SW_HIDE);
ShowWindow(Application.Handle,SW_HIDE);
End else inherited;
end;

procedure TForm1.ActionIcon(n: Integer; Icon: TIcon);
 Var Nim:TNotifyIconData;
begin
With Nim do
Begin
cbSize:=SizeOf(Nim);
Wnd:=Form1.Handle;
uID:=1;
uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
hicon:=Icon.Handle;
uCallbackMessage:=wm_user+1;
szTip:='Application Cup';
End;
Case n OF
1: Shell_NotifyIcon(Nim_Add,@Nim);
2: Shell_NotifyIcon(Nim_Delete,@Nim);
3: Shell_NotifyIcon(Nim_Modify,@Nim);
End;
 end;

procedure TForm1.OnMinimizeProc(Sender: TObject);
begin
 PostMessage(Handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
end;

procedure TForm1.MouseClick(var Msg: TMessage);
Var p:tpoint;
begin
 GetCursorPos(p);
 Case Msg.LParam OF
  WM_RBUTTONUP:
Begin
SetForegroundWindow(Handle);
PopupMenu1.Popup(p.X,p.Y);
PostMessage(Handle,WM_NULL,0,0);
end;
end;
   end;

procedure TForm1.g1Click(Sender: TObject);
begin
   Winexec('Аудиопроигрыватель.exe', SW_SHOW);
end;
procedure TForm1.N1Click(Sender: TObject);
begin
  Winexec('Видеопроигрыватель.exe', SW_SHOW);
end;
procedure TForm1.N2Click(Sender: TObject);
begin
 Winexec('Просмотрщик.exe', SW_SHOW);
end;

procedure TForm1.N3Click(Sender: TObject);
var
  wnd:HWnd;
begin
  killtask('Видеопроигрыватель.exe');
  killtask('Аудиопроигрыватель.exe');
  killtask('Просмотрщик.exe');
 Close;
end;

function TForm1.KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot
  (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
  FProcessEntry32);
  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
    UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
    UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(
      PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;
end.
