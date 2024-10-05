unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ExtDlgs, Menus, jpeg, ComCtrls, ShellAPI, StdCtrls,
  ImgList, sSkinProvider, sSkinManager, Grids, sScrollBox, Buttons,
  sSpeedButton, sLabel, sMemo, sSplitter, sBitBtn, sPanel, sButton,clipbrd,GraphicEx,
  GraphicColor,GraphicCompression,GraphicStrings,GraphUtil;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    pnl1: TPanel;
    OpenPictureDialog1: TOpenPictureDialog;
    mmo1: TMemo;
    dlgOpen1: TOpenDialog;
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    pnl2: TPanel;
    pnl3: TPanel;
    scrlbx1: TsScrollBox;
    btn0: TsSpeedButton;
    btn1: TsSpeedButton;
    btn2: TsSpeedButton;
    btn3: TsSpeedButton;
    mmo2: TsMemo;
    lst1: TListBox;
    btn4: TsSpeedButton;
    btn5: TsSpeedButton;
    btn6: TsSpeedButton;
    btn7: TsSpeedButton;
    btn8: TsSpeedButton;
    btn9: TsSpeedButton;
    btn10: TsSpeedButton;
    scrlbx2: TScrollBox;
    image1: TImage;
    sbtbtn1: TsBitBtn;
    tmr1: TTimer;
    N11: TMenuItem;
    N51: TMenuItem;
    N13: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    spnl1: TsPanel;
    btnDOB: TsButton;
    pm1: TPopupMenu;
    e1: TMenuItem;
    N4: TMenuItem;
    pm2: TPopupMenu;
    pm3: TPopupMenu;
    pm4: TPopupMenu;
    pm5: TPopupMenu;
    pm6: TPopupMenu;
    pm7: TPopupMenu;
    pm8: TPopupMenu;
    pm9: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N24: TMenuItem;
    pm10: TPopupMenu;
    N25: TMenuItem;
    N26: TMenuItem;
    sbtbtn2: TsBitBtn;
    N41: TMenuItem;
    N27: TMenuItem;
    g1: TMenuItem;
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dropfile (var Msg: TWMDropFiles); message WM_DropFiles;
    procedure addfiles (filename: string);
    procedure btnDOBClick(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure sbtbtn1MouseEnter(Sender: TObject);
    procedure sbtbtn2Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure tmr1Timer(Sender: TObject);
    procedure image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure N51Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure e1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure g1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  editedfile:string;
    Icon1   : TIcon;
Bitmap1 : TBitmap;
b:TsSpeedButton;
i,j,jss,shi,vis,is_Width,if_Height:Integer;
kolb:TStrings;
flag:Byte;
pos:TPoint;
implementation

{$R *.dfm}

procedure TForm1.N3Click(Sender: TObject);
begin
close;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
if OpenPictureDialog1.Execute then
begin
 mmo1.Clear;
 editedfile:=ExtractFilepath(OpenPictureDialog1.filename)+ExtractFilename(OpenPictureDialog1.filename);
 mmo1.Text:=editedfile;
 Image1.picture.loadfromfile(editedfile);
 form1.Caption:='AC-Просмотрщик изображение: '+ editedfile;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
Icon: TIcon;
FileInfo: SHFILEINFO;
begin
   DragAcceptFiles(Handle, true);

 begin
  if ParamStr(1)<> '' then
  Image1.picture.loadfromfile(ParamStr(1));
  editedfile:=ParamStr(1);
  mmo1.Text:=editedfile;
  form1.caption:='AC-Просмотрщик изображение: '+mmo1.Text;
 end;
end;


procedure TForm1.dropfile(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH]  of Char;
begin
  try
    if DragQueryFile(MSG.drop, 0, CfileName, MAX_PATH)>0 then
    begin
    addfiles(CFileName);
    Msg.result:=0;
    end;
    finally;
    DragFinish(MSG.Drop);
end;
  end;

procedure TForm1.addfiles(filename: string);
begin
  mmo1.Clear;
 mmo1.Text:=filename;
 Image1.Picture.LoadFromFile(mmo1.text);

 form1.caption:='AC-Просмотрщик изображение: '+mmo1.Text;
end;

procedure TForm1.btnDOBClick(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin


  jss:=0;
    j:=0;   begin
              if lst1.Items.Count>10 then
               begin
                 ShowMessage('Добавление более не доступно. Удалите или измените предыдущие элементы');
                 lst1.Items.Delete(11);
               end
               else
     begin
      for i:= 0 to Self.ComponentCount-1 do
      begin
       if Self.Components[i] is TsSpeedButton then
       begin
         for j:=jss to lst1.Items.Count-1 do
          begin
               Icon1:= TIcon.Create;
               Bitmap1:= TBitmap.Create;
               Icon1.Handle:=ExtractIcon(hInstance,PChar(lst1.Items.Strings[j]),0);
               Bitmap1.Width := Icon1.Width;
               Bitmap1.Height := Icon1.Height;
               Bitmap1.Canvas.Draw(0, 0, Icon1);
               B:= TsSpeedButton(Self.Components[i]);
               b.Visible:=True;
               b.Glyph:=Bitmap1;
               Icon1.Free;
               Bitmap1.Free;
               jss:=jss+1;
               Break;
               end;

           end;
         end;
           lst1.Items.Add(ExtractFilepath(dlgOpen1.FileName)+ExtractFilename(dlgOpen1.FileName));
   lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
        end;
     end;
     end;
  end;


procedure TForm1.btn0Click(Sender: TObject);
begin
 shellexecute(handle,'open',PChar(lst1.Items.Strings[0]),PChar(mmo1.Text),nil,sw_show);
end;



procedure TForm1.FormActivate(Sender: TObject);
  begin
   lst1.Items.LoadFromFile(ExtractFilePath((ParamStr(0)))+'data.bas');
    jss:=0;
    j:=0;
      for i:= 0 to Self.ComponentCount-1 do
      begin
       if Self.Components[i] is TsSpeedButton then
       begin
         for j:=jss to lst1.Items.Count-1 do
          begin
               Icon1:= TIcon.Create;
               Bitmap1:= TBitmap.Create;
               Icon1.Handle:=ExtractIcon(hInstance,PChar(lst1.Items.Strings[j]),0);
               Bitmap1.Width := Icon1.Width;
               Bitmap1.Height := Icon1.Height;
               Bitmap1.Canvas.Draw(0, 0, Icon1);
               B:= TsSpeedButton(Self.Components[i]);
               b.Visible:=True;
               b.Glyph:=Bitmap1;
               Icon1.Free;
               Bitmap1.Free;
               jss:=jss+1;
               Break;
               end;
           end;
         end;
         sbtbtn2.Align:=alTop;
       sbtbtn1.Align:=alRight;
        is_Width:=image1.Width;
       if_Height:=image1.Height;
    end;


procedure TForm1.btn1Click(Sender: TObject);
begin
 shellexecute(handle,'open',PChar(lst1.Items.Strings[1]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  shellexecute(handle,'open',PChar(lst1.Items.Strings[2]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
 shellexecute(handle,'open',PChar(lst1.Items.Strings[3]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[4]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[5]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[6]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[7]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn8Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[8]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn9Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[9]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.btn10Click(Sender: TObject);
begin
shellexecute(handle,'open',PChar(lst1.Items.Strings[10]),PChar(mmo1.Text),nil,sw_show);
end;

procedure TForm1.sbtbtn1MouseEnter(Sender: TObject);
begin
if pnl2.Visible=False then
begin
  pnl2.Visible:=True;
end
else
begin
  pnl2.Visible:=false;
end;
  end;

procedure TForm1.sbtbtn2Click(Sender: TObject);
begin
  if sbtbtn1.Enabled=true then
sbtbtn1.Enabled:=False
else
sbtbtn1.Enabled:=True;
end;

procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
  var t:TPoint;
begin
       if mmo1.Text<>'' then
       begin
       tmr1.Enabled:=False;
      vis:=image1.Width;
      shi:=image1.Height;
      image1.Stretch:=False;
         image1.Center:=True;
       image1.Width:=vis+10;
       image1.Height:=shi+10;
        image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
         image1.Stretch:=true;
         image1.Center:=false;

        end;

end;


procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
       if mmo1.Text<>'' then
       begin

       tmr1.Enabled:=False;

      vis:=image1.Width;
      shi:=image1.Height;
         image1.Stretch:=False;
         image1.Center:=True;
       image1.Width:=vis-10;
       image1.Height:=shi-10;
        image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
        image1.Stretch:=true;
         image1.Center:=false;
     end;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
 image1.Width:=pnl1.Width;
    image1.Height:=pnl1.Height;
end;

procedure TForm1.image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
flag:=1;
Pos.X:=X;
Pos.Y:=Y;
end;

procedure TForm1.image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if flag=1 then
Begin
image1.Left:=image1.Left+X-Pos.X;
  image1.Top:=image1.Top+Y-Pos.Y;
end;
 end;
procedure TForm1.image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
flag:=0;
end;


procedure TForm1.N51Click(Sender: TObject);
begin
  tmr1.Enabled:=False;
 image1.Width:= is_Width div 2;
 image1.Height:= if_Height div 2;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
end;

procedure TForm1.N22Click(Sender: TObject);
begin
  tmr1.Enabled:=False;
 image1.Width:= is_Width * 2;
 image1.Height:= if_Height * 2;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
end;

procedure TForm1.N13Click(Sender: TObject);
begin
  tmr1.Enabled:=False;
 image1.Width:= is_Width;
 image1.Height:= if_Height;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
end;

procedure TForm1.N23Click(Sender: TObject);
begin
tmr1.Enabled:=False;
 image1.Width:= is_Width*3;
 image1.Height:=if_Height*3;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
end;

procedure TForm1.N41Click(Sender: TObject);
begin
tmr1.Enabled:=False;
 image1.Width:= is_Width*4;
 image1.Height:=if_Height*4;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
end;

procedure TForm1.N27Click(Sender: TObject);
begin
 tmr1.Enabled:=False;
 image1.Width:= is_Width*5;
 image1.Height:=if_Height*5;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
end;

procedure TForm1.e1Click(Sender: TObject);
begin
lst1.Items.Delete(1);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn1.Visible:=false;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
lst1.Items.Delete(1);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N5Click(Sender: TObject);
begin
lst1.Items.Delete(2);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn2.Visible:=false;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
lst1.Items.Delete(2);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
lst1.Items.Delete(3);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn3.Visible:=false;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
lst1.Items.Delete(3);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
 lst1.Items.Delete(4);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn4.Visible:=false;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
lst1.Items.Delete(4);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N12Click(Sender: TObject);
begin
  lst1.Items.Delete(5);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn5.Visible:=false;
end;

procedure TForm1.N14Click(Sender: TObject);
begin
 lst1.Items.Delete(5);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N15Click(Sender: TObject);
begin
 lst1.Items.Delete(6);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn6.Visible:=false;
end;

procedure TForm1.N16Click(Sender: TObject);
begin
  lst1.Items.Delete(6);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N17Click(Sender: TObject);
begin
  lst1.Items.Delete(7);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn7.Visible:=false;
end;

procedure TForm1.N18Click(Sender: TObject);
begin
   lst1.Items.Delete(7);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N19Click(Sender: TObject);
begin
    lst1.Items.Delete(8);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn8.Visible:=false;
end;

procedure TForm1.N20Click(Sender: TObject);
begin
    lst1.Items.Delete(8);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N21Click(Sender: TObject);
begin
     lst1.Items.Delete(9);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn9.Visible:=false;
end;

procedure TForm1.N24Click(Sender: TObject);
begin
     lst1.Items.Delete(9);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;

procedure TForm1.N25Click(Sender: TObject);
begin
       lst1.Items.Delete(10);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btn10.Visible:=false;
end;

procedure TForm1.N26Click(Sender: TObject);
begin
      lst1.Items.Delete(10);
lst1.Items.SaveToFile(ExtractFilePath((ParamStr(0)))+'data.bas');
btnDOBClick(Self);
end;



procedure TForm1.g1Click(Sender: TObject);
begin
  tmr1.Enabled:=true;
 image1.Width:= is_Width;
 image1.Height:= if_Height;
 image1.Left:=scrlbx2.Left;
 image1.Top:=scrlbx2.Top;
 image1.Center:=True;
end;

end.


