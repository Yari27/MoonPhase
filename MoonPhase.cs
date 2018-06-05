﻿using System;

namespace Moon
{
    class MoonPhase
    {
        public enum PhaseType
        {
            NewMoon,
            Quarter1,
            Fullness,
            Quarter3//last quarter
        }

        private static double rang(double x)
        {
            double a, b;
            b = x / 360;
            a = 360 * (b - (int)(b));
            if (a < 0)
                a = a + 360;
            return a;
        }

        private static double phi(double tzd)
        {
            double elm, ams, aml, asd;

            elm = rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + tzd * tzd * tzd / 545868 - tzd * tzd * tzd * tzd / 113065000);
            ams = rang(357.5291092 + 35999.0502909 * tzd - 0.0001536 * tzd * tzd + tzd * tzd * tzd / 24490000);
            aml = rang(134.9634114 + 477198.8676313 * tzd - 0.008997 * tzd * tzd + tzd * tzd * tzd / 69699 - tzd * tzd * tzd * tzd / 14712000);
            asd = 180 - elm - (6.289 * Math.Sin((Math.PI / 180) * ((aml)))) +
                            (2.1 * Math.Sin((Math.PI / 180) * ((ams)))) -
                            (1.274 * Math.Sin((Math.PI / 180) * (((2 * elm) - aml)))) -
                            (0.658 * Math.Sin((Math.PI / 180) * ((2 * elm)))) -
                            (0.214 * Math.Sin((Math.PI / 180) * ((2 * aml)))) -
                            (0.11 * Math.Sin((Math.PI / 180) * ((elm))));
            return (1 + Math.Cos((Math.PI / 180) * (asd))) / 2;
        }

        /// <summary>
        /// The Moon phase calculating from the current date and time.
        /// </summary>
        /// <param name="Year"></param>
        /// <param name="Month"></param>
        /// <param name="Day"></param>
        /// <param name="Hour"></param>
        /// <param name="Minute"></param>
        /// <param name="Second"></param>
        /// <returns>
        /// Wynik dodatni (prawa strona ksiezyca oswietlona - elongacja dodatnia)
        /// Wynik ujemny (lewa strona ksiezyca oswietlona - elongacja ujemna)
        /// Now        =   0.00
        /// I kwadra   =  50.00
        /// Pelnia     = 100.00
        /// III kwadra = -50.00 //Między ostatnią kwadrą a nowiem
        /// </returns>
        public static double Phase(double Year, double Month, double Day, double Hour, double Minute, double Second)
        {
            double a, b;
            double phi1, phi2, jdp, tzd;

            if (Month <= 2)
            {
                Month = Month + 12;
                Year = Year - 1;
            }
            a = (int)(Year / 100);
            b = 2 - a + (int)(a / 4);
            jdp = (int)(365.25 * (Year + 4716)) + (int)(30.6001 * (Month + 1)) + Day + b +
                ((Hour + Minute / 60 + Second / 3600) / 24) - 1524.5;
            tzd = (jdp - 2451545) / 36525;
            phi1 = phi(tzd);

            tzd = (jdp + (0.5 / 24) - 2451545) / 36525;
            phi2 = phi(tzd);

            if ((phi2 - phi1) < 0)
                phi1 = -1 * phi1;
            return 100 * phi1;
        }

        /// <summary>
        /// The Moon phase calculating from the current date and time.
        /// </summary>
        /// <param name="datetime">Current date and time</param>
        /// <returns></returns>
        public static PhaseType Phase(DateTime datetime)
        {
            double phase = Phase(datetime.Year, datetime.Month, datetime.Day, datetime.Hour, datetime.Minute, datetime.Second);
            switch ((int)phase)
            {
                case 0: return PhaseType.NewMoon;
                case 50: return PhaseType.Quarter1;
                case 100: return PhaseType.Fullness;
                case -50: return PhaseType.Quarter3;
                default: 
                    return PhaseType.NewMoon;
            }
        }

    }
}
