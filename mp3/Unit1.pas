unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bass, sSkinProvider, sSkinManager, StdCtrls, Buttons, sBitBtn,
  ExtCtrls, sPanel, ComCtrls, acProgressBar, sScrollBar, sTrackBar,
  sListBox, sSpeedButton, ShellAPI, sMemo,spectrum_vis, CommonTypes, Menus, bassflac,
   bass_alac, bass_aac, bass_ac3, bass_adx, bass_aix, bass_ape, bass_mpc, bass_spx,
   bass_tta, bassopus, bass_ofr, basswv, basswma, bassenc;

type
  TForm1 = class(TForm)
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    dlgOpen1: TOpenDialog;
    spnl1: TsPanel;
    tmr1: TTimer;
    spnl2: TsPanel;
    spnl3: TsPanel;
    spnl4: TsPanel;
    sbtbtn1: TsBitBtn;
    sbtbtn2: TsBitBtn;
    sbtbtn3: TsBitBtn;
    sbtbtn4: TsBitBtn;
    sbtbtn5: TsBitBtn;
    lst1: TsListBox;
    lst2: TsListBox;
    sbtbtn6: TsBitBtn;
    sbtbtn7: TsBitBtn;
    sbtbtn8: TsBitBtn;
    sbtbtn9: TsBitBtn;
    dlgOpen2: TOpenDialog;
    dlgSave1: TSaveDialog;
    sbtbtn10: TsBitBtn;
    sbtbtn11: TsBitBtn;
    pb1: TPaintBox;
    pm1: TPopupMenu;
    g1: TMenuItem;
    f1: TMenuItem;
    f2: TMenuItem;
    A1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    strckbr1: TsTrackBar;
    sprgrsbr1: TsProgressBar;
    sprgrsbr2: TsProgressBar;
    sprgrsbr3: TsProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure sbtbtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbtbtn2Click(Sender: TObject);
    procedure sbtbtn3Click(Sender: TObject);
    procedure sbtbtn4Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure sbtbtn5Click(Sender: TObject);
    procedure sbtbtn6Click(Sender: TObject);
    procedure sbtbtn7Click(Sender: TObject);
    procedure lst1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lst1DblClick(Sender: TObject);
    procedure sbtbtn9Click(Sender: TObject);
    procedure sbtbtn8Click(Sender: TObject);
    procedure sbtbtn10Click(Sender: TObject);
    procedure sbtbtn11Click(Sender: TObject);
    procedure pb1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure g1Click(Sender: TObject);
    procedure f1Click(Sender: TObject);
    procedure f2Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure strckbr1Change(Sender: TObject);
    procedure sprgrsbr1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sprgrsbr1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);

  private
    procedure addfiles (filename: string);
    procedure playitem (item : integer);
    procedure dropfile (var Msg: TWMDropFiles); message WM_DropFiles;
    Procedure Only;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   stream: HSTREAM;
   Track: real;
   Channel: DWORD;
   filename: string;
   Spectrum:TSpectrum;
   FFFData:TFFTData;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
ParentsShowhHint: Boolean;
begin
  DragAcceptFiles(Handle, true);
 if BASS_Init(-1, 44100, 0, Handle, nil)=False then
 ShowMessage('не могу инициализировать поток');
  if ParamStr(1)<>''then begin filename:=ParamStr(1);
   lst2.Items.Add(filename);
     lst1.Items.Add(ExtractFileName(filename));
     end;
     Spectrum:=TSpectrum.Create(PB1.Width,PB1.Height);
   Spectrum.Mode:=1;
   Spectrum.Pen:=clPurple;
   Spectrum.BackColor:=clMenuText;
   strckbr1.Min:=0;
   strckbr1.Max:=100;
   strckbr1.Position:=50;
   Form1.Height:= 125;
   ShowHint:= True;
   Only;
end;

procedure TForm1.sbtbtn1Click(Sender: TObject);
var
 j,i: Integer;
begin
dlgOpen1.Options:=[ofHideReadOnly,ofAllowMultiSelect,ofEnableSizing];
dlgOpen1.Title  := 'Открытие файлов';
if lst1.Count<>0 then i:=Lst1.ItemIndex else i:=0;
if not dlgOpen1.Execute then exit;
  Begin
   For j:=0 to dlgOpen1.Files.Count -1 do
    Begin
      lst1.Items.Add(ExtractFileName(dlgOpen1.Files.Strings[j]));
      lst2.Items.Add(dlgOpen1.Files.Strings[j]);
    End;
  End;
     Filename:=lst2.Items.Strings[i];
     lst2.ItemIndex:=i;
     lst1.ItemIndex:=i;
  playitem(lst1.ItemIndex);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
BASS_Free;
end;
procedure TForm1.sbtbtn2Click(Sender: TObject);
begin
  if BASS_ChannelIsActive(stream) = bass_active_paused then
BASS_ChannelPlay(stream,False)
else
  playitem(lst1.ItemIndex);
end;

procedure TForm1.sbtbtn3Click(Sender: TObject);
begin
  BASS_ChannelPause(stream);
end;

procedure TForm1.sbtbtn4Click(Sender: TObject);

begin
  BASS_ChannelStop(stream);
   BASS_ChannelSetPosition(stream,0,0);
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
inindex, itemindex,item, i: integer;
level: DWORD;
begin
  if  BASS_ChannelGetPosition(stream, 0)= BASS_ChannelGetLength(stream, 0) then
   begin
inindex:=lst1.ItemIndex;
inindex:=Lst1.ItemIndex;
  itemindex:=inindex+1;
  Lst1.Itemindex:=itemindex;
  PlayItem(Lst1.Itemindex);
  i:=Lst1.Items.Count;
  if i = itemindex then
   Lst1.Itemindex:=0;
   PlayItem(Lst1.Itemindex);
  end;
begin
   try
    BASS_ChannelGetData(stream,@FFFData,BASS_DATA_FFT1024);
    Spectrum.Draw(PB1.Canvas.Handle,FFFData,1,1);
   except
    on e:Exception do
   end;
 end;
 BASS_ChannelSetAttribute(stream,BASS_ATTRIB_VOL, strckbr1.Position/100);
 level := BASS_ChannelGetLevel(stream);
 sprgrsbr1.Position:= BASS_ChannelGetPosition(stream,0);
 sprgrsbr2.Position:= LOWORD(level);
 sprgrsbr3.Position:= HIWORD(level);
 end;


procedure TForm1.sbtbtn5Click(Sender: TObject);
begin
 if Self.Height=125 then Self.Height:=420 else Self.Height:=125;
end;

procedure TForm1.addfiles(filename: string);
begin
 lst2.Items.Add(filename);
 lst1.Items.Add(ExtractFileName(filename));
end;

procedure TForm1.sbtbtn6Click(Sender: TObject);
begin
if dlgOpen1.Execute=False then Exit;
addfiles(dlgOpen1.FileName);
end;

procedure TForm1.playitem(item: integer);
begin
   if item<0 then Exit;
 if stream<>0 then
  BASS_StreamFree(stream);
stream:= BASS_StreamCreateFile(False, pchar(lst2.Items.Strings[item]),0, 0, 0);
if stream=0 then

else
begin
 sprgrsbr1.Min:=0;
 sprgrsbr1.Max:=BASS_ChannelGetLength(stream,0)-1;
 sprgrsbr1.Position:=0;
 BASS_ChannelPlay(stream, false);
end;
end;

procedure TForm1.sbtbtn7Click(Sender: TObject);
var
inindex: Integer;
begin
 inindex:= lst1.itemindex;
 lst1.Items.Delete(inindex);
 lst2.Items.delete (inindex);
 if inindex>lst1.Count-1 then
 inindex:=lst1.Items.Count-1;
 lst1.ItemIndex:=inindex;
end;

procedure TForm1.lst1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_delete then
sbtbtn7.Click;
end;

procedure TForm1.lst1DblClick(Sender: TObject);
begin
playitem(lst1.ItemIndex);
end;

procedure TForm1.sbtbtn9Click(Sender: TObject);
begin
  if dlgSave1.Execute=True then
lst2.Items.SaveToFile(dlgSave1.FileName);
end;

procedure TForm1.sbtbtn8Click(Sender: TObject);
var i: Integer;
begin
  if dlgOpen2.Execute= False then Exit;
lst2.Items.LoadFromFile(dlgOpen2.FileName);
lst1.Items.LoadFromFile(dlgOpen2.FileName);
for i:=0 to lst1.Items.Count-1 do
lst1.items.strings[i]:= ExtractFileName (lst1.items.strings[i]);
end;

 procedure TForm1.sprgrsbr1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssleft in shift then
  begin
    Track:=sprgrsbr1.Max/sprgrsbr1.Width;
    sprgrsbr1.Position:=round(x*Track);
    BASS_ChannelSetPosition(stream, sprgrsbr1.Position, 0);
     end;
  end;

procedure TForm1.sprgrsbr1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssleft in shift then
  begin
    Track:=sprgrsbr1.Max/sprgrsbr1.Width;
    sprgrsbr1.Position:=round(x*Track);
    BASS_ChannelSetPosition(stream, sprgrsbr1.Position, 0);
     end;
      end;

procedure TForm1.dropfile(var Msg: TWMDropFiles);
var
  i: integer;
  CountFile: integer;
  size: integer;
  Filename: PChar;
begin
try

  CountFile := DragQueryFile(Msg.Drop, $FFFFFFFF, Filename, 255);
  for i := 0 to (CountFile - 1) do
  begin
    size := DragQueryFile(Msg.Drop, i , nil, 0)+1;
    Filename:= StrAlloc(size);
    DragQueryFile(Msg.Drop,i , Filename, size);
    addfiles(StrPas(Filename));
    StrDispose(Filename);
  end;
finally
  DragFinish(Msg.Drop);
end;
end;

procedure TForm1.sbtbtn10Click(Sender: TObject);
var
  i: Integer;
  inindex, itemindex,item: integer;
begin
inindex:=Lst1.ItemIndex;
  itemindex:=inindex+1;
  Lst1.Itemindex:=itemindex;
  PlayItem(Lst1.Itemindex);
  i:=Lst1.Items.Count;
   if i = itemindex then
   Lst1.Itemindex:=0;
   PlayItem(Lst1.Itemindex);
end;

procedure TForm1.sbtbtn11Click(Sender: TObject);
var
  i: Integer;
  inindex, itemindex,item: integer;
begin
inindex:=Lst1.ItemIndex;
  itemindex:=inindex-1;
  Lst1.Itemindex:=itemindex;
  PlayItem(Lst1.Itemindex);
  i:=Lst1.Items.Count;
   if inindex = 0  then
  Lst1.Itemindex:=Lst1.Items.Count-1;
   PlayItem(Lst1.Itemindex);
end;

procedure TForm1.strckbr1Change(Sender: TObject);
begin
 BASS_ChannelSetAttribute(stream, BASS_ATTRIB_VOL,strckbr1.Position/100);
end;

procedure TForm1.pb1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
  var
    Button: TMouseButton ;
begin
   if Button = mbRight then
 PM1.Popup(0, 0);
end;

procedure TForm1.g1Click(Sender: TObject);
begin
  Spectrum.Pen:=clRed;
end;

procedure TForm1.f1Click(Sender: TObject);
begin
   Spectrum.Pen:=clBlue;
end;

procedure TForm1.f2Click(Sender: TObject);
begin
Spectrum.Pen:=clGreen;
end;

procedure TForm1.A1Click(Sender: TObject);
begin
Spectrum.Pen:=clPurple;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
Spectrum.Pen:=clGray;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
Spectrum.Pen:=clYellow;
end;

procedure TForm1.Only;
Var
HMutex: Integer;
H: THandle;
Begin
HMutex:=CreateMutex(Nil, True, 'Аудиопроигрыватель');
If GetLastError <> 0 Then
Begin
Form1.Caption:='AC Аудио проигрыватель';
H:=FindWindow(Nil,'AC-Аудио проигрыватель');
If H=0 Then
Exit;
PostMessage(H, WM_CLOSE, 0, 0);
End;
Form1.Caption:='AC-Аудио проигрыватель';
End;

procedure TForm1.FormActivate(Sender: TObject);
begin
   BASS_PluginLoad('bassflac.dll', 0);
   BASS_PluginLoad('bass_alac.dll', 0);
   BASS_PluginLoad('bass_aac.dll', 0);
   BASS_PluginLoad('bass_ac3.dll', 0);
   BASS_PluginLoad('bass_adx.dll', 0);
   BASS_PluginLoad('bass_aix.dll', 0);
   BASS_PluginLoad('bass_ape.dll', 0);
   BASS_PluginLoad('bass_mpc.dll', 0);
   BASS_PluginLoad('bass_spx.dll', 0);
   BASS_PluginLoad('bass_tta.dll', 0);
   BASS_PluginLoad('bassopus.dll', 0);
   BASS_PluginLoad('bass_ofr.dll', 0);
   BASS_PluginLoad('OptimFROG.dll', 0);
   BASS_PluginLoad('basswv.dll', 0);
   BASS_PluginLoad('basswma.dll', 0);
   BASS_PluginLoad('bassenc.dll', 0);
end;

end.
