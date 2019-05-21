unit sebastian.vogt.operation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TBaseOperation = class

    const
      OP_ADDITION = '+';
      OP_SUBTRACTION = '-';
      OP_MULTIPLICATION = '*';
      OP_DIVISION = '/';



    private
      FOperantA: Double;
      FOperantB: Double;
      FResult: Double;


      function Addition(): Double;
      function Subtraction(): Double;
      function Multiplication(): Double;
      function Division(): Double;



    public
      OnDivisionByZero: TNotifyEvent;
      constructor Create; overload;
      procedure SetOperantA(v: Double);
      function GetOperantA(): Double;

      procedure SetOperantB(v: Double);
      function GetOperantB(): Double;

      function GetResult(): Double;

      function Operation(VOperator: string): Double;

      property OperantA: Double read getOperantA write setOperantA;
      property OperantB: Double read getOperantB write setOperantB;
      property _Result: Double read getResult;

  end;

implementation

// public
constructor TBaseOperation.Create;
begin
  inherited;
end;

procedure TBaseOperation.SetOperantA(v: Double);
begin
  FOperantA := v;
end;

function TBaseOperation.GetOperantA(): Double;
begin
  Result := FOperantA;
end;


procedure TBaseOperation.SetOperantB(v: Double);
begin
  FOperantB := v;
end;

function TBaseOperation.GetOperantB(): Double;
begin
  Result := FOperantB;
end;

function TBaseOperation.GetResult(): Double;
begin
  Result := FResult;
end;


function TBaseOperation.Operation(VOperator: string): Double;
begin
  if VOperator = OP_ADDITION then begin
    FResult := Addition();
  end else if VOperator = OP_SUBTRACTION then begin
    FResult := Subtraction();
  end else if VOperator = OP_MULTIPLICATION then begin
    FResult := Multiplication();
  end else if VOperator = OP_DIVISION then begin
    FResult := Division();
  end else begin
    // unbekannte Operation
  end;

  Result := FResult;
end;

// private
function TBaseOperation.Addition(): Double;
begin
  Result := FOperantA + FOperantB;
end;

function TBaseOperation.Subtraction(): Double;
begin
  Result := FOperantA - FOperantB;
end;

function TBaseOperation.Multiplication(): Double;
begin
  Result := FOperantA * FOperantB;
end;

function TBaseOperation.Division(): Double;
begin
  if FOperantB = 0 then begin
      if Assigned(OnDivisionByZero) then begin
          Result := 0;
          OnDivisionByZero(Self);

          Exit;
      end;
  end else begin
    Result := FOperantA / FOperantB;
  end;
end;

end.

