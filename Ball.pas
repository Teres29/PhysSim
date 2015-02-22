unit Ball;

interface
uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics;
type
  TVector = record
    x : extended;
    y : extended;
  end;

  TBall = class
  private
    position : TVector;
    velocity : TVector;
    radius   : double;
    color    : TColor;
  public
    constructor Create(x,y:extended; vx,vy:extended; r: extended);
    function GetPosition(): TVector;
    procedure SetPosition(x,y : extended);
    function GetVelocity(): TVector;
    procedure SetVelocity(x,y : extended);
    function GetRadius(): extended;
    procedure SetRadius(r: extended);
    procedure Move();
    procedure SetColor(c: Tcolor);
    function GetColor(): TColor;
    function isColide(ball: TBall): boolean;
  end;



implementation
  constructor TBall.Create(x,y:extended; vx,vy:extended; r: extended);
  begin
    position.x := x;
    position.y := y;
    velocity.x := vx;
    velocity.y := vy;
    radius := r;
    color := clBlue;
  end;

  function TBall.GetPosition: TVector;
  begin
     result.x := position.x;
     result.y := position.y;
  end;

  procedure TBall.SetPosition(x,y : extended);
  begin
    position.x := x;
    position.y := y;
  end;

  function TBall.GetVelocity: TVector;
  begin
    result.x := velocity.x;
    result.y := velocity.y;
  end;

  function TBall.isColide(ball: TBall): boolean;
  begin
    if( ( ((position.x - ball.GetPosition.x)*(position.x - ball.GetPosition.x)) +
    ((position.y - ball.GetPosition.y)*(position.y - ball.GetPosition.y))) <= (radius + ball.GetRadius)*(radius + ball.GetRadius))
    then result := true
    else result := false;
  end;

  procedure TBall.SetVelocity(x, y: extended);
  begin
    velocity.x := x;
    velocity.y := y;
  end;

  function TBall.GetRadius: extended;
  begin
    result := radius;
  end;

  procedure TBall.SetRadius(r: extended);
  begin
    radius := r;
  end;

  procedure TBall.Move();
  begin
    position.x := position.x + velocity.x;
    position.y := position.y + velocity.y;
  end;

  procedure TBall.SetColor(c: TColor);
  begin
    color := c;
  end;

  function TBall.GetColor: TColor;
  begin
    result := color;
  end;

  end.
