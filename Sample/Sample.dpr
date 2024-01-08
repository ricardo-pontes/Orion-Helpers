program Sample;

{$R *.dres}

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Entity in 'Entity.pas',
  Orion.Helpers in '..\Orion.Helpers.pas',
  Orion.Helpers.Reflections in '..\Orion.Helpers.Reflections.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
