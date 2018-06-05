#include <stdio.h>
#include <math.h>

#define PI 3.1415926535

double rang(double x)
{
	double a,b;
    b = x / 360;
    a = 360 * (b - (int)(b));
    if (a < 0)
    	a = a + 360;
    return a;
}

double phi(double tzd)
{
	double elm,ams,aml,asd;

	elm = rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + tzd*tzd*tzd / 545868 - tzd*tzd*tzd*tzd / 113065000);
	ams = rang(357.5291092 + 35999.0502909 * tzd - 0.0001536 * tzd * tzd + tzd*tzd*tzd / 24490000);
	aml = rang(134.9634114 + 477198.8676313 * tzd - 0.008997 * tzd * tzd + tzd*tzd*tzd / 69699 - tzd*tzd*tzd*tzd / 14712000);
	asd = 180 - elm -   (6.289 * sin((PI / 180) * ((aml)))) +
                    (2.1 * sin((PI / 180) * ((ams)))) -
                    (1.274 * sin((PI / 180) * (((2 * elm) - aml)))) -
                    (0.658 * sin((PI / 180) * ((2 * elm)))) -
                    (0.214 * sin((PI / 180) * ((2 * aml)))) -
                    (0.11 * sin((PI / 180) * ((elm))));
	return (1 + cos((PI / 180) * (asd))) / 2;
}

/**
* Faza Ksiezyca obliczana z biezacej daty i czasu
*
* \param[in] Rok - Rok w pełnym formacie
* \param[in] Miesiac - 
* \param[in] Dzien - Rok w pełnym formacie
* \param[in] godzina - Rok w pełnym formacie
* \param[in] min - Rok w pełnym formacie
* \param[in] sec - Rok w pełnym formacie
* @return Faza Ksiezyca
*  Wynik dodatni (prawa strona ksiezyca oswietlona - elongacja dodatnia)
*  Wynik ujemny (lewa strona ksiezyca oswietlona - elongacja ujemna)
*  Now        =   0.00
*  I kwadra   =  50.00
*  Pelnia     = 100.00
*  III kwadra = -50.00 //Między ostatnią kwadrą a nowiem
*/
double faza(double Rok, double Miesiac, double Dzien, double godzina,double min, double sec)
{
	double a,b;
	double phi1,phi2,jdp,tzd;

	if (Miesiac <= 2)
	{
    	Miesiac = Miesiac + 12;
    	Rok = Rok - 1;
	}
	a= (int)(Rok / 100);
    b = 2 - a + (int)(a / 4);
	jdp = (int)(365.25 * (Rok + 4716)) + (int)(30.6001 * (Miesiac + 1)) + Dzien + b +
          ((godzina + min / 60 + sec / 3600) / 24) - 1524.5;
	tzd = (jdp - 2451545) / 36525;
	phi1 = phi(tzd);

	tzd = (jdp + (0.5 / 24) - 2451545) / 36525;
	phi2 = phi(tzd);

	if ((phi2-phi1) < 0)  
		phi1 = -1 * phi1;
	return 100 * phi1;
}
