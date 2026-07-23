unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Strutils, StdCtrls,
  Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public
    constructor Create(TheOwner: TComponent); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Tem_P_RecordData:P_TRecordData;
begin
  log2({$I %LINENUM%},' Dynamic Allocation Initialize -------------------------');

  if P0_ <> nil then
  begin
    Tem_P_RecordData:=P0_;
    Dispose(Tem_P_RecordData);
    P0_:=nil;
  end;

  New(Tem_P_RecordData);
  Tem_P_RecordData^.DataName:='A1';
  Tem_P_RecordData^.DataID:=11;

  P0_:=Tem_P_RecordData;

  if P1_ <> nil then
  begin
    Tem_P_RecordData:=P1_;
    Dispose(Tem_P_RecordData);
    P1_:=nil;
  end;

  New(Tem_P_RecordData);
  Tem_P_RecordData^.DataName:='A2';
  Tem_P_RecordData^.DataID:=22;

  P1_:=Tem_P_RecordData;

  if GetTypeKind(P0_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type P0_: P_TRecordData');
  if GetTypeKind(P0_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type P0_: TRecordData');
  if GetTypeKind(P1_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type P1_: P_TRecordData');
  if GetTypeKind(P1_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type P1_: TRecordData');

  log2({$I %LINENUM%},' P0_.DataName: '+P_TRecordData(P0_)^.DataName);
  log2({$I %LINENUM%},' P0_.DataID: '+P_TRecordData(P0_)^.DataID.ToString);

  log2({$I %LINENUM%},' P1_.DataName: '+P_TRecordData(P1_)^.DataName);
  log2({$I %LINENUM%},' P1_.DataID: '+P_TRecordData(P1_)^.DataID.ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Tem_P_RecordData:P_TRecordData;
begin
  log2({$I %LINENUM%},' Heap Allocation Initialize -------------------------');

  if P2_ <> nil then
  begin
    Tem_P_RecordData:=P2_;
    Finalize(Tem_P_RecordData^);
    FreeMem(Tem_P_RecordData);
    P2_:=nil;
  end;

  GetMem(Tem_P_RecordData, SizeOf(TRecordData));
  Initialize(Tem_P_RecordData^);

  Tem_P_RecordData^.DataName:='A3';
  Tem_P_RecordData^.DataID:=33;
  P2_:=Tem_P_RecordData;

  if GetTypeKind(P2_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type: P_TRecordData');
  if GetTypeKind(P2_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type: TRecordData');

  log2({$I %LINENUM%},' P2_.DataName: '+P_TRecordData(P2_)^.DataName);
  log2({$I %LINENUM%},' P2_.DataID: '+P_TRecordData(P2_)^.DataID.ToString);

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  MyArray: array[0..99] of Integer;
  Tem_P_RecordData:P_TRecordData;
  Tem_P_ClassData:P_TClassData;
  Tem_ClassData:TClassData;
begin
  log2({$I %LINENUM%},' Zero Memory -------------------------');
  log2({$I %LINENUM%},' MyArray[99]: '+MyArray[99].ToString);
  log2({$I %LINENUM%},' Hex ByteMyArray[99]: '+IntToHex(pbyte(@MyArray[99])^,2));
  log2({$I %LINENUM%},' Hex IntegerMyArray[99]: '+IntToHex(PInteger(@MyArray[99])^,2));
  MyArray[99]:=26;
  log2({$I %LINENUM%},' MyArray[99]: '+MyArray[99].ToString);
  log2({$I %LINENUM%},' Hex ByteMyArray[99]: '+IntToHex(pbyte(@MyArray[99])^,2));
  log2({$I %LINENUM%},' Hex IntegerMyArray[99]: '+IntToHex(PInteger(@MyArray[99])^,2));

  FillChar(MyArray, SizeOf(MyArray), 0);

  log2({$I %LINENUM%},' MyArray[99]: '+MyArray[99].ToString);
  log2({$I %LINENUM%},' Hex ByteMyArray[99]: '+IntToHex(pbyte(@MyArray[99])^,2));
  log2({$I %LINENUM%},' Hex IntegerMyArray[99]: '+IntToHex(PInteger(@MyArray[99])^,2));

  if P0_ <> nil then P_TRecordData(P0_)^:=RecordData;
  if P1_ <> nil then P_TRecordData(P1_)^:=RecordData;
  if P2_ <> nil then P_TRecordData(P2_)^:=RecordData;
  if P3_ <> nil then
  begin
    Tem_P_RecordData:=P3_;
    Tem_P_RecordData[0]:=RecordData;
    Tem_P_RecordData[1]:=RecordData;
  end;
  if P4_ <> nil then
  begin
    //New(Tem_P_ClassData);                //Not work
    //Tem_ClassData:=TClassData.Create;    //Not work
    //Tem_P_ClassData^:=Tem_ClassData;     //Not work
    //P_TClassData(P4_)^:=Tem_P_ClassData^;//Not work
    //Tem_ClassData.Free;                  //Not work
    //Dispose(Tem_P_ClassData);            //Not work

    Tem_P_ClassData:=P4_;
    Tem_P_ClassData^.Free;
    Dispose(Tem_P_ClassData);
    P4_:=nil;

    New(Tem_P_ClassData);
    Tem_ClassData:=TClassData.Create;
    Tem_P_ClassData^:=Tem_ClassData;
    P4_:=Tem_P_ClassData;

  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Tem_P_RecordData:P_TRecordData;
  Tem2_P_RecordData:P_TRecordData;
begin
  log2({$I %LINENUM%},' Heap Allocation Array -------------------------');

  if P3_ <> nil then
  begin
    Tem_P_RecordData:=P3_;
    Finalize(Tem_P_RecordData^);
    FreeMem(Tem_P_RecordData);
    P3_:=nil;
  end;

  GetMem(Tem_P_RecordData,SizeOf(TRecordData)*2);
  Try
    Initialize(Tem_P_RecordData^,2);
    Tem_P_RecordData[0].DataName:='A4';
    Tem_P_RecordData[0].DataID:=444;
    Tem_P_RecordData[1].DataName:='A5';
    Tem_P_RecordData[1].DataID:=555;

    P3_:= Tem_P_RecordData;
    Tem2_P_RecordData:=P3_;

    if GetTypeKind(P3_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type: P_TRecordData');
    if GetTypeKind(P3_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type: P_TRecordData');
    log2({$I %LINENUM%},' RecordData[0].DataName: '+Tem2_P_RecordData[0].DataName);
    log2({$I %LINENUM%},' RecordData[0].DataID: '+Tem2_P_RecordData[0].DataID.ToString);
    log2({$I %LINENUM%},' RecordData[1].DataName: '+Tem2_P_RecordData[1].DataName);
    log2({$I %LINENUM%},' RecordData[1].DataID: '+Tem2_P_RecordData[1].DataID.ToString);

  except    // Example error Exception
    on E: EConvertError do
     log2({$I %LINENUM%},' Error: Please enter a valid whole number.');
    on E: EDivByZero do
      log2({$I %LINENUM%},' Error: You cannot divide by zero.');
    on E: Exception do
      log2({$I %LINENUM%},' An unexpected error occurred: '+ E.Message);
    on E: EHeapException do
      log2({$I %LINENUM%},' An unexpected Dynamic memory problem: '+ E.Message);
    on E: EInvalidPointer do
      log2({$I %LINENUM%},' An unexpected bad memory pointer: '+ E.Message);
    on E: EInOutError do
      log2({$I %LINENUM%},' An unexpected IO error: '+ E.Message);

  //Finally

  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  Tem_P_ClassData:P_TClassData;
  Tem_ClassData:TClassData;
  Tem_ClassData2:TClassData;
begin
  log2({$I %LINENUM%},' Dynamic Allocation Class -------------------------');

  if P4_ <> nil then
  begin
    Tem_P_ClassData:=P4_;
    Tem_P_ClassData^.Free;
    Dispose(Tem_P_ClassData);
    P4_:=nil;
  end;

  New(Tem_P_ClassData);
  Tem_ClassData:=TClassData.Create;
  Tem_ClassData.DataName:='A6';
  Tem_ClassData.DataID:=66;

  Tem_P_ClassData^:=Tem_ClassData;
  P4_:=Tem_P_ClassData;
  Tem_ClassData2:=P_TClassData(P4_)^;

  if GetTypeKind(P4_) = GetTypeKind(P_TClassData) then  log2({$I %LINENUM%},' Type: P_TClassData');
  if GetTypeKind(P4_) = GetTypeKind(TClassData) then  log2({$I %LINENUM%},' Type: TClassData');
  log2({$I %LINENUM%},' ClassName: '+P_TClassData(P4_)^.ClassName);
  log2({$I %LINENUM%},' P4_.DataName: '+P_TClassData(P4_)^.DataName);
  log2({$I %LINENUM%},' P4_.DataID: '+P_TClassData(P4_)^.DataID.ToString);
  log2({$I %LINENUM%},' ClassData2.DataName: '+Tem_ClassData2.DataName);
  log2({$I %LINENUM%},' ClassData2.DataID: '+Tem_ClassData2.DataID.ToString);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  Tem_P_RecordData:P_TRecordData;
begin
  log2({$I %LINENUM%},' List all -------------------------');

  if P0_ <> nil then
  begin
    if GetTypeKind(P0_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type P0_: P_TRecordData');
    if GetTypeKind(P0_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type P0_: TRecordData');

    log2({$I %LINENUM%},' P0_.DataName: '+P_TRecordData(P0_)^.DataName);
    log2({$I %LINENUM%},' P0_.DataID: '+P_TRecordData(P0_)^.DataID.ToString);
  end;

  if P1_ <> nil then
  begin
    if GetTypeKind(P1_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type P1_: P_TRecordData');
    if GetTypeKind(P1_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type P1_: TRecordData');

    log2({$I %LINENUM%},' P1_.DataName: '+P_TRecordData(P1_)^.DataName);
    log2({$I %LINENUM%},' P1_.DataID: '+P_TRecordData(P1_)^.DataID.ToString);
  end;

  if P2_ <> nil then
  begin
    if GetTypeKind(P2_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type: P_TRecordData');
    if GetTypeKind(P2_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type: TRecordData');

    log2({$I %LINENUM%},' P2_.DataName: '+P_TRecordData(P2_)^.DataName);
    log2({$I %LINENUM%},' P2_.DataID: '+P_TRecordData(P2_)^.DataID.ToString);
  end;

  if P3_ <> nil then
  begin
    Tem_P_RecordData:=P3_;
    if GetTypeKind(P3_) = GetTypeKind(P_TRecordData) then  log2({$I %LINENUM%},' Type: P_TRecordData');
    if GetTypeKind(P3_) = GetTypeKind(TRecordData) then  log2({$I %LINENUM%},' Type: P_TRecordData');
    log2({$I %LINENUM%},' RecordData[0].DataName: '+Tem_P_RecordData[0].DataName);
    log2({$I %LINENUM%},' RecordData[0].DataID: '+Tem_P_RecordData[0].DataID.ToString);
    log2({$I %LINENUM%},' RecordData[1].DataName: '+Tem_P_RecordData[1].DataName);
    log2({$I %LINENUM%},' RecordData[1].DataID: '+Tem_P_RecordData[1].DataID.ToString);
  end;

  if P4_ <> nil then
  begin
    if GetTypeKind(P4_) = GetTypeKind(P_TClassData) then  log2({$I %LINENUM%},' Type: P_TClassData');
    if GetTypeKind(P4_) = GetTypeKind(TClassData) then  log2({$I %LINENUM%},' Type: TClassData');
    log2({$I %LINENUM%},' ClassName: '+P_TClassData(P4_)^.ClassName);
    log2({$I %LINENUM%},' P4_.DataName: '+P_TClassData(P4_)^.DataName);
    log2({$I %LINENUM%},' P4_.DataID: '+P_TClassData(P4_)^.DataID.ToString);
  end;

end;

procedure TForm1.Button8Click(Sender: TObject);
var
  sBuffer : array of Byte;
  i:integer;
  BufferByte : array of Byte;  // Dynamic Array
  cb: DWORD;
  ByteArrayPtr: PByteArray;
  s:string;
begin
  log({$I %LINE%}+' PByte array to Array Byte -------------------------');

  SetLength(sBuffer, 5);
  for i:=low(sBuffer) to high(sBuffer) do sBuffer[i]:= $30+i;
  //ByteArrayPtr := @sBuffer; // For Static / Fixed-Size Arrays
  //ByteArrayPtr := PByteArray(@sBuffer); // For Static / Fixed-Size Arrays
  ByteArrayPtr := PByteArray(@sBuffer[0]);  //For Dynamic Arrays
  log({$I %LINE%}+' chr(ByteArrayPtr^[0]): "'+ chr(ByteArrayPtr^[0]) +'"');

  cb:=length(sBuffer);
  SetLength(BufferByte, cb);
  Move(ByteArrayPtr^[0], BufferByte[0], cb);

  s := StringOf(BufferByte);
  log({$I %LINE%}+' BufferByte: "'+ s +'"');

  s:='';
  for i:=0 to cb-1 do
  begin
    if i <> 0 then s:=s+':';
    s:=s+IntToHex(Ord(BufferByte[i]), 2);
  end;

  log({$I %LINE%}+' BufferByte[Hex]: "'+ s +'"');
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  sBuffer : array of Byte;
  i:integer;
  BufferByte : array of Byte;  // Dynamic Array
  cb: DWORD;
  lpData:Pbyte;
  s:string;
begin
  log({$I %LINE%}+' PByte to Array of Byte -------------------------');

  SetLength(sBuffer, 5);
  for i:=low(sBuffer) to high(sBuffer) do sBuffer[i]:= $30+i;
  lpData := @sBuffer[0];
  log({$I %LINE%}+' chr(lpData^): "'+ chr(lpData^) +'"');

  cb:=length(sBuffer);
  SetLength(BufferByte, cb);
  Move(lpData^, BufferByte[0], cb);

  s := StringOf(BufferByte);
  log({$I %LINE%}+' BufferByte: "'+ s +'"');

  s:='';
  for i:=0 to cb-1 do
  begin
    if i <> 0 then s:=s+':';
    s:=s+IntToHex(Ord(BufferByte[i]), 2);
  end;

  log({$I %LINE%}+' BufferByte[Hex]: "'+ s +'"');
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Tem_RecordData:P_TRecordData;
  Tem_P_ClassData:P_TClassData;
begin
  if P0_ <> nil then
  begin
    Tem_RecordData:=P0_;
    Dispose(Tem_RecordData);
    P0_:=nil;
  end;

  if P1_ <> nil then
  begin
    Tem_RecordData:=P1_;
    Dispose(Tem_RecordData);
    P1_:=nil;
  end;

  if P2_ <> nil then
  begin
    Tem_RecordData:=P2_;
    Finalize(Tem_RecordData^);
    FreeMem(Tem_RecordData);
    P2_:=nil;
  end;

  if P3_ <> nil then
  begin
    Tem_RecordData:=P3_;
    Finalize(Tem_RecordData^);
    FreeMem(Tem_RecordData);
    P3_:=nil;
  end;

  if P4_ <> nil then
  begin
    Tem_P_ClassData:=P4_;
    Tem_P_ClassData^.Free;
    Dispose(Tem_P_ClassData);
    P4_:=nil;
  end;
end;

constructor TForm1.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  Memo_:=Memo1;

  P_ClassData:=@ClassData;   // Just force P_ClassData is memory position of ClassData
  P_RecordData:=@RecordData; // Just force P_RecordData is memory position of RecordData

  log2({$I %LINENUM%},' Form.Create');
  //showmessage('TForm1.Create');
end;

end.

