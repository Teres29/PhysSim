program PhysSimProject;

uses
  Vcl.Forms,
  Ball in 'Ball.pas',
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
