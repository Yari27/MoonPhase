 {cybermoon.w.interia.pl}

 {$n+}
 uses wincrt;{lub uses crt;}

var R,M,D,G,Min,S:Integer;

Function rang(x:Double):double;
var a,b:double;
begin
    b:= x / 360;
    A:= 360 * (b - int(b));
    If (A < 0) Then A:= A + 360;
    rang:= A;
End;




Function faza(Rok, Miesiac, Dzien, godzina,min, sec:double):double;
var A:Double;    b:double;    phi1,phi2,jdp,tzd,elm,ams,aml,asd:double;
begin
    If (Miesiac > 2) Then begin
        Miesiac:= Miesiac;
        Rok:= Rok;
        End;
    If Miesiac <= 2 Then begin
    Miesiac:= Miesiac + 12;
    Rok:= Rok - 1;
    End;
    A:= int(Rok / 100);
    b:= 2 - A + int(A / 4);
    jdp:= int(365.25 * (Rok + 4716)) + int(30.6001 * (Miesiac + 1)) + Dzien + b +
          ((godzina + min / 60 + sec / 3600) / 24) - 1524.5;
    jdp:= jdp;
tzd:= (jdp - 2451545) / 36525;
elm:= rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + tzd*tzd*tzd / 545868 - tzd*tzd*tzd*tzd / 113065000);
ams:= rang(357.5291092 + 35999.0502909 * tzd - 0.0001536 * tzd * tzd + tzd*tzd*tzd / 24490000);
aml:= rang(134.9634114 + 477198.8676313 * tzd - 0.008997 * tzd * tzd + tzd*tzd*tzd / 69699 - tzd*tzd*tzd*tzd / 14712000);
asd:= 180 - elm -   (6.289 * sin((3.1415926535 / 180) * ((aml)))) +
                    (2.1 * sin((3.1415926535 / 180) * ((ams)))) -
                    (1.274 * sin((3.1415926535 / 180) * (((2 * elm) - aml)))) -
                    (0.658 * sin((3.1415926535 / 180) * ((2 * elm)))) -
                    (0.214 * sin((3.1415926535 / 180) * ((2 * aml)))) -
                    (0.11 * sin((3.1415926535 / 180) * ((elm))));
phi1:= (1 + Cos((3.1415926535 / 180) * (asd))) / 2;


tzd:= (jdp + (0.5 / 24) - 2451545) / 36525;
elm:= rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + tzd*tzd*tzd / 545868 - tzd*tzd*tzd*tzd / 113065000);
ams:= rang(357.5291092 + 35999.0502909 * tzd - 0.0001536 * tzd * tzd + tzd*tzd*tzd / 24490000);
aml:= rang(134.9634114 + 477198.8676313 * tzd - 0.008997 * tzd * tzd + tzd*tzd*tzd / 69699 - tzd*tzd*tzd*tzd / 14712000);
asd:= 180 - elm -   (6.289 * sin((3.1415926535 / 180) * ((aml)))) +
                    (2.1 * sin((3.1415926535 / 180) * ((ams)))) -
                    (1.274 * sin((3.1415926535 / 180) * (((2 * elm) - aml)))) -
                    (0.658 * sin((3.1415926535 / 180) * ((2 * elm)))) -
                    (0.214 * sin((3.1415926535 / 180) * ((2 * aml)))) -
                    (0.11 * sin((3.1415926535 / 180) * ((elm))));
phi2:= (1 + Cos((3.1415926535 / 180) * (asd))) / 2;


if (phi2-phi1)<0 then phi1:=-1*phi1;
faza:=100*phi1;
end;


begin

write('Podaj Rok     : ');readln(R);
write('Podaj Miesiac : ');readln(M);
write('Podaj Dzien   : ');readln(D);
write('Podaj Godzine : ');readln(G);
write('Podaj Minute  : ');readln(Min);
write('Podaj Sekunde : ');readln(S);
writeln;
writeln('Faza Ksiezyca to : ',faza(R,M,D,G,Min,S):0:4);
writeln;
writeln;
writeln;
writeln('Wynik dodatni (prawa strona ksiezyca oswietlona - elongacja dodatnia)');
writeln('Wynik ujemny (lewa strona ksiezyca oswietlona - elongacja ujemna)');
writeln('Now        =   0.00');
writeln('I kwadra   =  50.00');
writeln('Pelnia     = 100.00');
writeln('III kwadra = -50.00');

readln;

end.