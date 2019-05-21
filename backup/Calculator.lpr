program Calculator;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainWindow, sebastian.vogt.operation
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TcalculatorFrm, calculatorFrm);
  baseOperation := TBaseOperation.Create;
  baseOperation.OnDivisionByZero := @calculatorFrm.divisionByZero;

  point := False;
  startWithZero := False;
  Application.Run;
end.

