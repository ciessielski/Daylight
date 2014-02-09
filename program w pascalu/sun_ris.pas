{$n+}

{cybermoon.w.interia.pl}

uses wincrt;{lub uses crt;}

var
 R,M,D,Lat,Long,Req,
 J,Cent,L,G,O,F,E,A,C,U,UD,P,Wsch,Tran,Zach:double;


Function Acos(x:double):double;
begin
 ACos:= ArcTan (sqrt (1-sqr (x)) /x);
End;


Function Asin(x:double):double;
begin
 ASin:= ArcTan (x/sqrt (1-sqr (x)));
End;


function modd(x,y:double):double;
{funkcja zwraca wartosc dzielenia liczb rzeczywistych}
var il:double;
begin
il:=int(x/y);
modd:=x-(il*y);
end;


begin

R:=2005;
M:=1;
D:=1;
Lat:=50.0;   {szerokosc geograficzna    ujemna - S  dodatnia - N}
Long:=19.00; {dlugosc geograficzna      ujemna - W  dodatnia - E}
Req:=-0.833; {wysokosc Slonca podczas Wschodu i Zachodu}

{------------------------------------}
J:=367*R-int(7*(R+int((M+9)/12))/4)+int(275*M/9)+D-730531.5;
Cent:=J/36525;
L:=modd((4.8949504201433+628.331969753199*Cent),6.28318530718);
G:=MODD((6.2400408+628.3019501*Cent),6.28318530718);
O:=0.409093-0.0002269*Cent;
F:=0.033423*SIN(G)+0.00034907*SIN(2*G);
E:=0.0430398*SIN(2*(L+F)) - 0.00092502*SIN(4*(L+F)) - F;
A:=ASIN(SIN(O)*SIN(L+F));
C:=(SIN(0.017453293*Req) - SIN(0.017453293*Lat)*SIN(A))/(COS(0.017453293*Lat)*COS(A));

Wsch:=(PI - (E+0.017453293*Long + 1*ACOS(C)))*57.29577951/15;
Tran:=(PI - (E+0.017453293*Long + 0*ACOS(C)))*57.29577951/15;
Zach:=(PI - (E+0.017453293*Long + -1*ACOS(C)))*57.29577951/15;

writeln('Wschod i Zachod Slonca dla');
writeln('Miejscowosci :  Sze : ',Lat:0:2,' , Dlu : ',Long:0:2);
writeln;
writeln;
writeln('Czas UT');
writeln;
writeln('Wschód   :  ',int(Wsch):0:0,':',(60*(Wsch-int(Wsch))):0:3);
writeln('Tranzyt  :  ',int(Tran):0:0,':',(60*(Tran-int(Tran))):0:3,'     - Gorowanie');
writeln('Zachód   :  ',int(Zach):0:0,':',(60*(zach-int(Zach))):0:3);

readln;
end.

