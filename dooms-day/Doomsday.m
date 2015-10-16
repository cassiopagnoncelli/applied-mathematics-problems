(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)

Off[General::spell];
Off[General::spell1]; (*Turn off spelling correction.*)

GregLeapYear[y_]:=
If[
 Mod[y,400]==0 || Mod[y,100]!=0 && Mod[y,4]==0,
 1,0]

GregMonthDD[m_,y_]:=If[Mod[m,2]==0,m,m+4]
GregMonthDD[1,y_]=31+GregLeapYear[y];
GregMonthDD[2,y_]=28+GregLeapYear[y];
GregMonthDD[9,y_]=5;
GregMonthDD[11,y_]=7;

GregCenturyDD[y_]:=
Mod[2+5 Mod[Floor[y/100],4],7]

GregYearDD[y_]:=
Mod[
 GregCenturyDD[y]+Mod[y,100]+Floor[Mod[y,100]/4],7]

GregDay[month_,day_,year_]:=
Mod[GregYearDD[year]+day-GregMonthDD[month,year],7]
 

JulLeapYear[y_]:=
If[Mod[y,4]==0,1,0]

JulMonthDD[m_,y_]:=If[Mod[m,2]==0,m,m+4]
JulMonthDD[1,y_]=31+JulLeapYear[y];
JulMonthDD[2,y_]=28+JulLeapYear[y];
JulMonthDD[9,y_]=5;
JulMonthDD[11,y_]=7;

JulCenturyDD[y_]:=Mod[6 Floor[y/100],7]

BCFixer[y_]:=y-28 Floor[y/28]+1

JulYearDD[y_]:=
If[y>0,
 Mod[JulCenturyDD[y]+Mod[y,100]+Floor[Mod[y,100]/4],7],
 JulYearDD[BCFixer[y]]]

JulDay[month_,day_,year_]:=
Mod[JulYearDD[year]+day-JulMonthDD[month,year],7]
 

Change={10,15,1582};

Gregorian=1;Julian=0;
Cal[month_,day_,year_]:=
If[(year>Change[[3]])||
   (year==Change[[3]]) && (month>Change[[1]])||
   (year==Change[[3]]) && (month==Change[[1]]) && (day>=Change[[2]]),
   Gregorian,Julian]

DayNumber[month_,day_,year_]:=
If[Cal[month,day,year]==Gregorian,
   GregDay[month,day,year],
   JulDay[month,day,year]]

Clear[Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday]
DaysOfWeek={Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday};

CalDay[month_,day_,year_]:=
 DaysOfWeek[[DayNumber[month,day,year]+1]]

Clear[LeapYear,ml,monthlength,randdomdate]

LeapYear[x_/;x>=0]:=
 If[x>Change[[3]],GregLeapYear[x],JulLeapYear[x]]
LeapYear[x_/;x<0]:=LeapYear[x+Ceiling[-x/28] 28+1]

ml={31,28,31,30,31,30,31,31,30,31,30,31};

monthlength[m_,y_]:=
 ml[[m]]+ If[LeapYear[y]==1 && (m==2),1,0]
 
randomdate[a_,b_]:=Module[{m,d,y},
 m=Random[Integer,{1,12}];
 y=Random[Integer,{a,b}];
 d=Random[Integer,{1,monthlength[m,y]}];
 {m,d,y}]

EasterG[year_]:=Mod[year,19]+1;
GregorianEasterC[year_]:=
 Module[{c=Floor[year/100]},
 -c+Floor[c/4]+Floor[8(c+11)/25]];
 JulianEasterC[year_]:=3
EasterC[year_]:=
 If[year>Change[[3]],
    GregorianEasterC[year],JulianEasterC[year]]

Paschal1[year_]:=50-Mod[11 EasterG[year] + EasterC[year],30]
Paschal[year_]:=
If[Paschal1[year]<49,Paschal1[year],
 If[Paschal1[year]==50,49,
  If[EasterG[year]>11,48,49] ] ]

EasterNumber[year_]:=
Paschal[year]+7-DayNumber[3,Paschal[year],year]

Easter[year_]:=
If[EasterNumber[year]<32,
{March,EasterNumber[year]},
{April,EasterNumber[year]-31}]
 

