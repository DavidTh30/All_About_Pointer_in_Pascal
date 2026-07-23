unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, StdCtrls;

type
  P_TClassData = ^TClassData;  //TClassDataPointer
  TClassData = class
    DataName: string;
    DataID: Integer;
  end;

type
  P_TRecordData = ^TRecordData;  //TRecordDataPointer
  TRecordData = record
    DataName: string;
    DataID: Integer;
  end;

procedure log(message_: string);
procedure log2(LINENUM_: integer; message_: string);

var
  Memo_:TMemo;
  P0_:Pointer; //UnTypePointer
  P1_:Pointer; //UnTypePointer
  P2_:Pointer; //UnTypePointer
  P3_:Pointer; //UnTypePointer
  P4_:Pointer; //UnTypePointer

  P_ClassData:P_TClassData;
  ClassData:TClassData;

  P_RecordData:P_TRecordData;
  RecordData:TRecordData;

implementation

procedure log(message_: string);
begin
  Memo_.Append(message_);
end;

procedure log2(LINENUM_: integer; message_: string);
begin
  Memo_.Append(LINENUM_.ToString+message_);
end;

end.

