unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinProvider, sSkinManager, ExtCtrls, Menus, ComCtrls, sTrackBar,
  StdCtrls, sCheckBox, sLabel, Buttons, sSpeedButton, acProgressBar, sSplitter,
  sListBox, sPanel, sGroupBox, DirectShow9, ActiveX, sBitBtn, ShellAPI;

type
TPlayerMode = (Stop, Play, Paused);
  TForm1 = class(TForm)
    GroupBox1: TsGroupBox;
    Panel1: TsPanel;
    ListBox1: TsListBox;
    ListBox2: TsListBox;
    Splitter1: TsSplitter;
    Panel2: TsPanel;
    ProgressBar1: TsProgressBar;
    Panel3: TsPanel;
    Panel4: TsPanel;
    Label2: TsLabel;
    Label5: TsLabel;
    Label3: TsLabel;
    CheckBox1: TsCheckBox;
    TrackBar1: TsTrackBar;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Timer1: TTimer;
    Timer2: TTimer;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    SpeedButton1: TsBitBtn;
    SpeedButton3: TsBitBtn;
    SpeedButton4: TsBitBtn;
    SpeedButton5: TsBitBtn;
    SpeedButton6: TsBitBtn;
    SpeedButton2: TsBitBtn;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ListBox2MouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1Resize(Sender: TObject);
    procedure ProgressBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure Initializ;
    procedure Player;
    procedure AddPlayList;
     procedure dropfile (var Msg: TWMDropFiles); message WM_DropFiles;
     Procedure WMKeyDown(Var Msg:TWMKeyDown); Message WM_KeyDown;
       Procedure Only;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   hr: HRESULT = 1;
  pCurrent, pDuration: Double;
  Mode: TPlayerMode;
  Rate: Double;
  FullScreen: boolean = false;
  i: integer = 0;
  FileName: string;
  xn, yn : integer;
  p: real;
  mouse: tmouse;
  pGraphBuilder        : IGraphBuilder         = nil;
  pMediaControl        : IMediaControl         = nil;
  pMediaEvent          : IMediaEvent           = nil;
  pVideoWindow         : IVideoWindow          = nil;
  pMediaPosition       : IMediaPosition        = nil;
  pBasicAudio          : IBasicAudio           = nil;

implementation

{$R *.dfm}

{ TForm1 }



procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if Form1.CheckBox1.Checked=True then
   begin
  Form1.ListBox2.Visible:=True;
  Form1.Splitter1.Visible:=True;
 end
 else  begin
 Form1.ListBox2.Visible:=False;
  Form1.Splitter1.Visible:=False;
 end;
end;

procedure TForm1.dropfile(var Msg: TWMDropFiles);
var
   k: integer;
  CountFile: integer;
  size: integer;
  cFilename: PChar;

begin
try

  CountFile := DragQueryFile(Msg.Drop, $FFFFFFFF, cFilename, 255);
  for k := 0 to (CountFile - 1) do
  begin
    size := DragQueryFile(Msg.Drop, k , nil, 0)+1;
    cFilename:= StrAlloc(size);
    DragQueryFile(Msg.Drop,k , cFilename, size);
     ListBox2.Items.Add(ExtractFileName(cfileName));
      ListBox1.Items.Add(cfileName);
    Filename:=ListBox1.Items.Strings[i];
     ListBox1.ItemIndex:=i;
     ListBox2.ItemIndex:=i;
    StrDispose(cFilename);
  end;
finally
  DragFinish(Msg.Drop);
end;
    if mode=play then begin pMediaPosition.put_Rate(Rate);exit;end ;
  Player;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 ParentsShowhHint: Boolean;
begin
DragAcceptFiles(Handle, true);
CoInitialize(nil);
if ParamStr(1)<>''then begin filename:=ParamStr(1);
   listbox1.Items.Add(filename);
     listbox2.Items.Add(ExtractFileName(filename));
     Player;
     end;
      Only;
      ShowHint:= True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  CoUninitialize;
end;

procedure TForm1.Initializ;
begin
  if Assigned(pMediaPosition) then pMediaPosition := nil;
  if Assigned(pBasicAudio) then pBasicAudio  := nil;
  if Assigned(pVideoWindow) then pVideoWindow := nil;
  if Assigned(pMediaEvent) then pMediaEvent := nil;
  if Assigned(pMediaControl) then pMediaControl := nil;
  if Assigned(pGraphBuilder) then pGraphBuilder := nil;
  hr := CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC_SERVER, IID_IGraphBuilder, pGraphBuilder);
  if hr<>0 then begin
    ShowMessage('Не удается создать граф');
    exit;
  end;
  hr := pGraphBuilder.QueryInterface(IID_IMediaControl, pMediaControl);
  if hr<>0 then begin
    ShowMessage('Не удается получить интерфейс IMediaControl');
    exit;
  end;
   hr := pGraphBuilder.QueryInterface(IID_IMediaEvent, pMediaEvent);
   if hr<>0 then begin
    ShowMessage('Не удается получить интерфейс событий');
    exit;
  end;
  hr := pGraphBuilder.QueryInterface(IID_IVideoWindow, pVideoWindow);
  if hr<>0 then begin
    ShowMessage('Не удается получить IVideoWindow');
    exit;
  end;
   hr := pGraphBuilder.QueryInterface(IBasicAudio, pBasicAudio);
  if hr<>0 then begin
    ShowMessage('Не удается получить аудио интерфейс');
    exit;
  end;
  hr := pGraphBuilder.QueryInterface(IID_IMediaPosition, pMediaPosition);
   if hr<>0 then begin
    ShowMessage('Не удается получить интерфейс управления позицией');
    exit;
  end;
  hr := pGraphBuilder.RenderFile(StringToOleStr(PChar(filename)), '');
  if hr<>0 then begin
    ShowMessage('Не удается прорендерить файл');
    exit;
  end;
   pVideoWindow.Put_Owner(Panel1.Handle);
   pVideoWindow.Put_WindowStyle(WS_CHILD OR WS_CLIPSIBLINGS);
   pVideoWindow.put_MessageDrain(Panel1.Handle);
   pVideoWindow.SetWindowPosition(0,0,Panel1.ClientRect.Right,Panel1.ClientRect.Bottom);
end;


procedure TForm1.N1Click(Sender: TObject);
begin
ListBox1.Clear;
ListBox2.Clear;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
ListBox1.DeleteSelected;
ListBox2.DeleteSelected;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  AddPlayList;
end;

procedure TForm1.Only;
Var
HMutex: Integer;
H: THandle;
Begin
HMutex:=CreateMutex(Nil, True, 'Видеопроигрыватель');
If GetLastError <> 0 Then
Begin
Form1.Caption:='AC Видео проигрыватель ';
H:=FindWindow(Nil,'AC-Видео проигрыватель ');
If H=0 Then
Exit;
PostMessage(H, WM_CLOSE, 0, 0);
End;
Form1.Caption:='AC-Видео проигрыватель ';
End;

procedure TForm1.ListBox2Click(Sender: TObject);
begin
i:=ListBox2.Itemindex;
ListBox1.Itemindex:=i;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
 i:=ListBox2.Itemindex;
 ListBox1.Itemindex:=i;
 Filename:=ListBox1.Items.Strings[i];
 mode:=stop;
 player;
end;

procedure TForm1.ListBox2MouseActivate(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
var
point : TPoint;
begin
  if (Button = mbRight) then
  begin
    point.X := X;
    point.Y := Y;
    i := ListBox2.ItemAtPos(point, true);
    ListBox1.ItemIndex:=i;
    ListBox2.ItemIndex:=i;
      if i >= 0 then
    begin
     PopupMenu1.Popup(ListBox2.ClientOrigin.X + X, ListBox2.ClientOrigin.Y + Y);
    end;
end;
end;



procedure TForm1.Panel1DblClick(Sender: TObject);
begin
if hr <> 0 then exit;
pVideoWindow.HideCursor(False);
if FullScreen=False then begin
Form1.ListBox2.Visible:=False;
Form1.Splitter1.Visible:=false;
Form1.GroupBox1.Visible:=false;
Form1.BorderStyle:=bsNone;
Form1.FormStyle :=fsstayOnTop;
Form1.windowState:= wsMaximized;
pVideoWindow.SetWindowPosition(0,0,screen.Width,screen.Height);
FullScreen:=True;
end
else begin
if form1.CheckBox1.Checked=true then  Form1.ListBox2.Visible:=True;
Form1.GroupBox1.Visible:=True;
Form1.Splitter1.Visible:=True;
Form1.BorderStyle:=bsSizeable;
Form1.windowState:= wsNormal;
Form1.FormStyle:=fsNormal;
pVideoWindow.SetWindowPosition(0,0,Panel1.ClientRect.Right,Panel1.ClientRect.Bottom);
FullScreen:=False;
end;
end;

procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if FullScreen<>True then Exit;
if (mouse.CursorPos.X<panel1.Width) and (ListBox2.Visible=True) then
begin
Form1.ListBox2.Visible:=False;
Form1.Splitter1.Visible:=False;
end;
if (mouse.CursorPos.X>=panel1.Width-ListBox2.Width) and (ListBox2.Visible=False) then
begin
if form1.CheckBox1.Checked=true then
  begin
    Form1.ListBox2.Visible:=True;
    Form1.Splitter1.Visible:=True;
  end;
end;

if (mouse.CursorPos.Y<panel1.Height) and (groupbox1.Visible=True) then
begin
groupbox1.Visible:=false;
end;

if (mouse.CursorPos.Y>=panel1.Height-groupbox1.Height) and (groupbox1.Visible=False) then
begin
groupbox1.Visible:=True;
end;
end;

procedure TForm1.Panel1Resize(Sender: TObject);
begin
 if mode=play then
 begin
 pVideoWindow.SetWindowPosition(0,0,Panel1.ClientRect.Right,Panel1.ClientRect.Bottom);
end;
end;

procedure TForm1.Player;
begin
if mode<>paused then begin
if not FileExists(FileName) then begin ShowMessage('Файл не существует');exit;end;
Initializ;
end;
pMediaControl.Run;
pMediaPosition.get_Rate(Rate);
mode:=play;
end;


procedure TForm1.ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if hr = 0 then  begin
  if ssleft in shift then
  begin
    p:=ProgressBar1.Max/ProgressBar1.Width;
    ProgressBar1.Position:=round(x*p);
    pMediaControl.Stop;
    pMediaPosition.put_CurrentPosition(ProgressBar1.Position);
    pMediaControl.Run;
    mode:=play;
  end;
end;
end;

procedure TForm1.ProgressBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if hr = 0 then  begin
  if ssleft in shift then
  begin
    p:=ProgressBar1.Max/ProgressBar1.Width;
    ProgressBar1.Position:=round(x*p);
    pMediaControl.Stop;
    pMediaPosition.put_CurrentPosition(ProgressBar1.Position);
    pMediaControl.Run;
    mode:=play;
  end;
end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if mode=play then begin pMediaPosition.put_Rate(Rate);exit;end ;
  Player;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 if mode=play then
 begin
   pMediaControl.Pause;
   mode:=paused;
 end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
 if mode=play then
 begin
   pMediaControl.Stop;
   mode:=Stop;
   pMediaPosition.put_CurrentPosition(0);
 end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var  pdRate: Double;
begin
if mode=play then
 begin
 pMediaPosition.get_Rate(pdRate);
 pMediaPosition.put_Rate(pdRate/2);
 end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var  pdRate: Double;
begin
if mode=play then
 begin
 pMediaPosition.get_Rate(pdRate);
 pMediaPosition.put_Rate(pdRate*2);
 end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  AddPlayList;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
TrackLen, TrackPos: Double;
ValPos: Double;
ValLen: Double;
plVolume:Longint;
db  : integer;
begin
Panel4.Caption:=TimeToStr(SysUtils.Time);
if hr <> 0 then Exit;
pMediaPosition.get_Duration(pDuration);
ProgressBar1.Max:=round(pDuration);
pMediaPosition.get_CurrentPosition(pCurrent);
ProgressBar1.Position:=round(pCurrent);
if pCurrent=pDuration then
begin
if i<ListBox2.Items.Count-1 then
   begin
    inc(i);
 Filename:=ListBox1.Items.Strings[i];
 ListBox1.ItemIndex:=i;
 ListBox2.ItemIndex:=i;
    mode:=stop;
    player;
   end
   else exit;
end;
plVolume:= (65535 * TrackBar1.Position) div 100;
db:= trunc(33.22 * 100 * ln((plVolume+1e-6)/65535)/ln(10));
pBasicAudio.put_Volume(db);
TrackLen:=pDuration;
TrackPos:=pCurrent;
ValPos:=TrackPos / (24 * 3600);
ValLen:=TrackLen / (24 * 3600);
Label2.Caption:=FormatDateTime('hh:mm:ss',ValPos);
Label3.Caption:=FormatDateTime('hh:mm:ss',ValLen);
end;



procedure TForm1.Timer2Timer(Sender: TObject);
begin
if FullScreen<>True then Exit;
if ((xn-5)<=mouse.CursorPos.X) and ((yn-5)<=mouse.CursorPos.Y) and ((xn+5)>=mouse.CursorPos.X) and ((yn+5)>=mouse.CursorPos.Y)then
pVideoWindow.HideCursor(true)  else pVideoWindow.HideCursor(False);
xn:=mouse.CursorPos.X;
yn:=mouse.CursorPos.Y;
end;

Procedure  TForm1.WMKeyDown(Var Msg:TWMKeyDown);
begin
  if Msg.CharCode=VK_ESCAPE then
  begin
      pVideoWindow.HideCursor(False);
      Form1.ListBox2.Visible:=True;
      Form1.Splitter1.Visible:=True;
      Form1.CheckBox1.Checked:=True;
      Form1.GroupBox1.Visible:=True;
      Form1.BorderStyle:=bsSizeable;
      Form1.windowState:= wsNormal;
      Form1.FormStyle:=fsNormal;
      pVideoWindow.SetWindowPosition(0,0,Panel1.ClientRect.Right,Panel1.ClientRect.Bottom);
      FullScreen:=False;
end;
  inherited;
end;

procedure TForm1.AddPlayList;
var
 j: Integer;
begin
OpenDialog1.Options:=[ofHideReadOnly,ofAllowMultiSelect,ofEnableSizing];
OpenDialog1.Title  := 'Открытие файлов';
OpenDialog1.Filter := 'Файлы мультимедиа |*.mp3;*.wma;*.wav;*.vob;*.avi;*.mpg;*.mp4;*.mov;*.mpeg;*.flv;*.wmv;*.qt;|Все файлы|*.*';
if listbox2.Count<>0 then i:=ListBox2.ItemIndex else i:=0;
if not OpenDialog1.Execute then exit;
  Begin
   For j:=0 to OpenDialog1.Files.Count -1 do
    Begin
      ListBox2.Items.Add(ExtractFileName(OpenDialog1.Files.Strings[j]));
      ListBox1.Items.Add(OpenDialog1.Files.Strings[j]);
    End;
  End;
     Filename:=ListBox1.Items.Strings[i];
     ListBox1.ItemIndex:=i;
     ListBox2.ItemIndex:=i;
if mode=play then begin pMediaPosition.put_Rate(Rate);exit;end ;
  player;
end;

end.
