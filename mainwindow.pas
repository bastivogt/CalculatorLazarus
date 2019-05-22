unit MainWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  ExtCtrls, sebastian.vogt.operation;

type

  { TcalculatorFrm }

  TcalculatorFrm = class(TForm)

    btn0: TButton;
    btn7: TButton;
    Button10: TButton;
    btn8: TButton;
    btn9: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btnSign: TButton;
    btnPoint: TButton;
    btnDivision: TButton;
    btnMultiplication: TButton;
    btnSubstract: TButton;
    btnAddition: TButton;
    btnEquals: TButton;
    btnC: TButton;
    btnCE: TButton;
    operationTxt: TEdit;
    outputTxt: TEdit;
    testenBtn: TButton;


    iconList: TImageList;
    mainMenu: TMainMenu;
    fileMM: TMenuItem;
    closeMM: TMenuItem;
    helpMM: TMenuItem;
    infoMM: TMenuItem;
    procedure btnCClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnEqualsClick(Sender: TObject);
    procedure btnNumberClick(Sender: TObject);
    procedure btnOperatorClick(Sender: TObject);
    procedure btnPointClick(Sender: TObject);
    procedure btnSignClick(Sender: TObject);
    procedure divisionByZero(Sender: TObject);
    procedure closeMMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure infoMMClick(Sender: TObject);
    procedure outputTxtChange(Sender: TObject);
    procedure testenBtnClick(Sender: TObject);



    procedure removeFirstZero();
  private

  public

  end;

var
  calculatorFrm: TcalculatorFrm;
  baseOperation: TBaseOperation;
  point: Boolean;
  ZeroPressedAtFirst: Boolean;
  operantA: Boolean;
  operantB: Boolean;
  operation: string;
  strOperantA: string;
  strOperantB: string;


implementation

{$R *.lfm}

{ TcalculatorFrm }
// CREATE
procedure TcalculatorFrm.FormCreate(Sender: TObject);
begin
  baseOperation := TBaseOperation.Create;
  baseOperation.OnDivisionByZero := @calculatorFrm.divisionByZero;

  point := False;
  ZeroPressedAtFirst := False;
  operantA := False;
  operantB := False;
end;




// listener division by zero
procedure TcalculatorFrm.divisionByZero(Sender: TObject);
begin
  ShowMessage('Durch 0 geht nicht!!!');
  operationTxt.Text := 'Durch 0 geht nicht!!!';
  operantA := False;
  operation := '';
  ZeroPressedAtFirst := False;

end;


// Button C
procedure TcalculatorFrm.btnCClick(Sender: TObject);
begin
   outputTxt.Text := '0';
   operationTxt.Text := '';
   operantA := False;
   operation := '';
   ZeroPressedAtFirst := False;

end;



// Button CE
procedure TcalculatorFrm.btnCEClick(Sender: TObject);
begin
   if operantA then begin
     outputTxt.Text := FloatToStr(baseOperation.OperantA);
     operationTxt.Text := '';


     operation := '';
     ZeroPressedAtFirst := False;
   end;

end;



// Operator Button
procedure TcalculatorFrm.btnOperatorClick(Sender: TObject);
var me: TButton;
begin
  me := Sender as TButton;

  if not operantA then begin
    strOperantA := outputTxt.Text;
    baseOperation.OperantA := StrToFloat(strOperantA);
    operantA := True;
    point := False;
    ZeroPressedAtFirst := False;
  end;

  operation := me.Caption;
  operationTxt.Text := strOperantA + ' ' + operation;
  outputTxt.Text := '0';

end;


// Equals Button
procedure TcalculatorFrm.btnEqualsClick(Sender: TObject);
begin
  if operantA then begin
     strOperantB := outputTxt.Text;
     baseOperation.OperantB := StrToFloat(strOperantB);
     //baseOperation.Operation(operation);
     outputTxt.Text := FloatToStr(baseOperation.Operation(operation));
     operationTxt.Text := '';
     operantA := False;

     //operantB := True;
  end;
end;



// Nummern Buttons
procedure TcalculatorFrm.btnNumberClick(Sender: TObject);
var me: TButton;
var csVal: string;
begin
  me := Sender as TButton;
  csVal := me.Caption;
  //ShowMessage(me.Caption);


  //removeFirstZero();

  if (me.Caption = '0') and not ZeroPressedAtFirst and (Length(outputTxt.Text) < 1) then begin
    ZeroPressedAtFirst := True;
    //ShowMessage('zp');

  end else begin
    outputTxt.Text := outputTxt.Text + csVal;
  end;

  removeFirstZero();





  //ShowMessage(me.Caption);
end;

// remove first zero
procedure TcalculatorFrm.removeFirstZero();
var len: Integer;
var str: string;
var tempStr: string;
begin
  str := outputTxt.Text;
  len := Length(str);
  if (len <= 2) and (str.StartsWith('0') and not (str.Substring(1, 1) = ',') and not ZeroPressedAtFirst ) then begin
    tempStr := str.Substring(1);
    outputTxt.Text := tempStr;
  end;
end;



// btnPoint
procedure TcalculatorFrm.btnPointClick(Sender: TObject);
begin
  if not point then begin
    outputTxt.Text := outputTxt.Text + ',';
    point := True;
  end;

end;

// btnSign
procedure TcalculatorFrm.btnSignClick(Sender: TObject);
var tempStr: string;
var str: string;
begin
  str := outputTxt.Text;
  if str.StartsWith('-') then begin
    tempStr := str.Substring(1);
  end else begin
    tempStr := '-' + str;
  end;
  outputTxt.Text := tempStr;
end;

procedure TcalculatorFrm.closeMMClick(Sender: TObject);
begin
  Application.Terminate;
end;



procedure TcalculatorFrm.infoMMClick(Sender: TObject);
begin
  ShowMessage('Made by Sebastian Vogt.');
end;

// outputTxt change
procedure TcalculatorFrm.outputTxtChange(Sender: TObject);
(*var me: TEdit;
var len: Integer;
var str: string;
var tempStr: string;*)
begin
  (*me := Sender as TEdit;
  str := me.Text;
  len := Length(str);
  if (len <= 2) and (str.StartsWith('0') and not (str.Substring(1, 1) = '.') and not ZeroPressedAtFirst ) then begin
    tempStr := str.Substring(1);
    me.Text := tempStr;
  end;*)
end;



// testenBtn
procedure TcalculatorFrm.testenBtnClick(Sender: TObject);
var str: string;
begin
  str := '0.5';
  //ShowMessage(str.Substring(1, 1));
  //ShowMessage('Hu hu!');
  baseOperation.OperantA := 5;
  baseOperation.OperantB := 3;
  baseOperation.Operation(TBaseOperation.OP_ADDITION);
  //baseOperation.Operation(TBaseOperation.OP_SUBTRACTION);
  //baseOperation.Operation(TBaseOperation.OP_MULTIPLICATION);
  //baseOperation.Operation(TBaseOperation.OP_DIVISION);
  ShowMessage(FloatToStr(baseOperation._Result));
end;

end.

