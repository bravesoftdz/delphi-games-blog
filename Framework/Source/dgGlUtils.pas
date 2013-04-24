unit dgGlUtils;

interface

uses
  dglOpenGL;

type
  TGlUtils = class
  public
    class procedure SquarePlane(AWidth: GLfloat); static;
  end;

implementation


{ TGlUtils }

class procedure TGlUtils.SquarePlane(AWidth: GLfloat);
var
  AHalfW : GLfloat;
begin
  AHalfW := AWidth / 2;
     // as primitivas s�o desenhadas no sentido anti-hor�rio
    (****************
      A          B
      +---------+
      |         |
      |    x    | h
      |         |
      +---------+
      D    w      C
      **************)
  glBegin(GL_QUADS);
    glColor3f(1,0,0);  glVertex2f(-AHalfW, AHalfW);   //A
    glColor3f(0,1,0);  glVertex2f(AHalfW, AHalfW);    //B
    glColor3f(0,0,1);  glVertex2f(AHalfW, -AHalfW);   //C
    glColor3f(1,1,1);  glVertex2f(-AHalfW, -AWidth);  //D
  glEnd;
end;

end.
