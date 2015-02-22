unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, ShellAPI, Ball, Math, IniFiles, Vcl.Menus;

type
  TMainForm = class(TForm)
    MainTimer: TTimer;
    EditVx: TSpinEdit;
    EditVy: TSpinEdit;
    ColorDialog1: TColorDialog;
    Image: TImage;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    EditVx2: TSpinEdit;
    EditVy2: TSpinEdit;
    procedure MainTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChangeVelocity();
    procedure EditVxChange(Sender: TObject);
    procedure EditVyChange(Sender: TObject);
    procedure Init();
    procedure N4Click(Sender: TObject);
    procedure LoadData();
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure EditVx2Change(Sender: TObject);
    procedure EditVy2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  MaxBallsCount = 1000;

var
  BallsCount, r, engine: Integer;
  MainForm: TMainForm;
  balls: array [1 .. MaxBallsCount] of TBall;
  BallsColor: TColor;
  started: Boolean;

implementation

{$R *.dfm}

procedure TMainForm.EditVx2Change(Sender: TObject);
begin
  balls[2].SetVelocity(EditVx2.Value, balls[2].GetVelocity.y);
end;

procedure TMainForm.EditVxChange(Sender: TObject);
begin
  balls[1].SetVelocity(EditVx.Value, balls[1].GetVelocity.y);
end;

procedure TMainForm.EditVy2Change(Sender: TObject);
begin
  balls[2].SetVelocity(balls[2].GetVelocity.x, EditVy2.Value);
end;

procedure TMainForm.EditVyChange(Sender: TObject);
begin
  balls[1].SetVelocity(balls[1].GetVelocity.x, EditVy.Value);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  BallsColor := clBlack;
  BallsCount := 40;
  r := 20;
  started := false;
  engine := 1;
  MainForm.Caption := 'PhypSim v1.0 ' + 'Source:' + ' Empty';
end;

procedure TMainForm.Init;
var
  i: Integer;
begin
  for i := 1 to BallsCount do
  begin
    balls[i] := TBall.Create(Random(MainForm.ClientWidth - 2 * r) + r,
      Random(MainForm.ClientHeight - 2 * r) + r, Random(11) - 5, Random(11) - 5,
      Random(r) + r);
    balls[i].SetColor(BallsColor);
  end;
  balls[1].SetColor(clWhite);
  started := true;
  MainForm.Caption := 'PhypSim v1.0 ' + '  Engine: v' + IntToStr(engine) +
    ';  Source:' + ' Generated';
end;

procedure TMainForm.LoadData;
var
  inifile: TIniFile;
  cr, cg, cb, i: Integer;
  randomgen: Integer;
  p, v: TVector;
begin
  inifile := TIniFile.Create(OpenDialog1.FileName);
  BallsCount := inifile.ReadInteger('Main', 'BallsCount', 20);
  engine := inifile.ReadInteger('Main', 'Engine', 1);
  r := inifile.ReadInteger('Main', 'BallsRad', 20);
  cr := inifile.ReadInteger('Main', 'BallColorR', 50);
  cg := inifile.ReadInteger('Main', 'BallColorG', 50);
  cb := inifile.ReadInteger('Main', 'BallColorB', 50);
  BallsColor := RGB(cr, cg, cb);
  randomgen := inifile.ReadInteger('Main', 'RandomGen', 1);
  if randomgen = 0 then
  begin
    for i := 1 to BallsCount do
    begin
      p.x := inifile.ReadInteger('Ball' + IntToStr(i), 'posx', 100);
      p.y := inifile.ReadInteger('Ball' + IntToStr(i), 'posy', 100);
      v.x := inifile.ReadInteger('Ball' + IntToStr(i), 'velx', 5);
      v.y := inifile.ReadInteger('Ball' + IntToStr(i), 'vely', 5);
      balls[i] := TBall.Create(p.x, p.y, v.x, v.y, RandomRange(r, 2 * r));
      balls[i].SetColor(BallsColor);
    end;
    started := true;
  end
  else
    Init;
  MainForm.Caption := 'PhypSim v1.0 ' + '  Engine: v' + IntToStr(engine) +
    ';  Source:' + ' Loaded from: ' + OpenDialog1.FileName;
end;

procedure TMainForm.MainTimerTimer(Sender: TObject);
var
  i, j: Integer;
  alpha: double;
  v: TVector;
  vel1, vel2: extended;

  //
  AB, aa, bb, V1, V2, aPrXx, aPrXy, aPrYx, aPrYy, aPrX, aPrY, bPrXx, bPrXy,
    bPrYx, bPrYy, bPrX, bPrY, alfaA, betaA, gammaA, alfaB, betaB,
    gammaB: extended;
  av, bv: extended;

  //
  d, delta, ddx, ddy: real;
begin
  Image.Repaint;
  Image.Canvas.Brush.Color := MainForm.Color;
  Image.Canvas.FillRect(ClientRect);

  for i := 1 to BallsCount do
  begin
    balls[i].Move;
    Image.Canvas.Brush.Color := (balls[i].GetColor);
    Image.Canvas.Pen.Color := (balls[i].GetColor);
    Image.Canvas.Ellipse(Round(balls[i].GetPosition.x - balls[i].GetRadius),
      Round(balls[i].GetPosition.y - balls[i].GetRadius),
      Round(balls[i].GetPosition.x + balls[i].GetRadius),
      Round(balls[i].GetPosition.y + balls[i].GetRadius));

    if ((balls[i].GetPosition.x - balls[i].GetRadius) <= 0) then
    begin
      balls[i].SetVelocity(-balls[i].GetVelocity.x, balls[i].GetVelocity.y);
      balls[i].SetPosition(0 + balls[i].GetRadius, balls[i].GetPosition.y);
    end;

    if ((balls[i].GetPosition.x + balls[i].GetRadius) >= ClientWidth) then
    begin
      balls[i].SetVelocity(-balls[i].GetVelocity.x, balls[i].GetVelocity.y);
      balls[i].SetPosition(MainForm.ClientWidth - balls[i].GetRadius,
        balls[i].GetPosition.y);
    end;

    if ((balls[i].GetPosition.y - balls[i].GetRadius) <= 0) then
    begin
      balls[i].SetVelocity(balls[i].GetVelocity.x, -balls[i].GetVelocity.y);
      balls[i].SetPosition(balls[i].GetPosition.x, 0 + balls[i].GetRadius);
    end;

    if ((balls[i].GetPosition.y + balls[i].GetRadius) >= ClientHeight) then
    begin
      balls[i].SetVelocity(balls[i].GetVelocity.x, -balls[i].GetVelocity.y);
      balls[i].SetPosition(balls[i].GetPosition.x, MainForm.ClientHeight -
        balls[i].GetRadius);
    end;

    for j := 1 to BallsCount do
    begin
      if (i <> j) then
      begin
        if balls[i].isColide(balls[j]) then
        begin // 1

          d := sqrt(sqr(balls[i].GetPosition.x - balls[j].GetPosition.x) +
            sqr(balls[i].GetPosition.y - balls[j].GetPosition.y));
          if d = 0 then
            d := 0.001; //гряхный хак
          if (d <= balls[i].GetRadius + balls[j].GetRadius) then
          begin // 2
            // раздвигаем шары, если расстояние между ними
            // меньше суммы их радиусов
            delta := (balls[i].GetRadius + balls[j].GetRadius - d) / 2 + 1;
            ddx := (balls[j].GetPosition.x - balls[j].GetPosition.x) / d;
            ddy := (balls[j].GetPosition.y - balls[i].GetPosition.y) / d;
            balls[i].SetPosition(balls[i].GetPosition.x - ddx * delta,
              balls[i].GetPosition.y - ddy * delta);
            balls[j].SetPosition(balls[j].GetPosition.x + ddx * delta,
              balls[j].GetPosition.y + ddy * delta);
          end; // 2

          if engine = 1 then
          begin // 3
            v.x := balls[i].GetVelocity.x;
            v.y := balls[i].GetVelocity.y;
            balls[i].SetVelocity(balls[j].GetVelocity.x,
              balls[j].GetVelocity.y);
            balls[j].SetVelocity(v.x, v.y);
          end // 3

          else if engine = 2 then
          begin // 4
            alpha := ArcTan2(balls[j].GetPosition.y - balls[i].GetPosition.y,
              balls[j].GetPosition.x - balls[i].GetPosition.x);
            vel2 := sqrt((balls[i].GetVelocity.x) * (balls[i].GetVelocity.x) +
              (balls[i].GetVelocity.y) * (balls[i].GetVelocity.y));
            vel1 := -sqrt((balls[j].GetVelocity.x) * (balls[j].GetVelocity.x) +
              (balls[j].GetVelocity.y) * (balls[j].GetVelocity.y));
            balls[i].SetVelocity(vel1 * sin(alpha), vel1 * cos(alpha));
            balls[j].SetVelocity(vel2 * sin(alpha), vel2 * cos(alpha));
          end // 4
        end; // 1
      end;
    end;
    ChangeVelocity;
  end;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  ShowMessage('Function not availble in this version');
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
  ShowMessage('Function not availble in this version');
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    LoadData;
end;

procedure TMainForm.N5Click(Sender: TObject);
begin
  if started then
  begin
    if MainTimer.Enabled then
    begin
      MainTimer.Enabled := false;
      N5.Caption := 'Пуск';
    end
    else
    begin
      MainTimer.Enabled := true;
      N5.Caption := 'Пауза';
    end;
  end
  else
    ShowMessage
      ('Нет объектов! Сгенерируйте объекты или загрузите их из файла.');
end;

procedure TMainForm.N6Click(Sender: TObject);
begin
  if OpenDialog1.FileName <> '' then
    LoadData
  else
    Init;
end;

procedure TMainForm.N7Click(Sender: TObject);
begin
  ShowMessage('Function not availble in this version');
end;

procedure TMainForm.ChangeVelocity;
begin
  EditVx.Value := Round(balls[1].GetVelocity.x);
  EditVy.Value := Round(balls[1].GetVelocity.y);
  EditVx2.Value := Round(balls[2].GetVelocity.x);
  EditVy2.Value := Round(balls[2].GetVelocity.y);
end;

end.
