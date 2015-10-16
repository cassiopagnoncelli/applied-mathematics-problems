(*^
::[	Information =

	"This is a Mathematica Notebook file.  It contains ASCII text, and can be
	transferred by email, ftp, or other text-file transfer utility.  It should
	be read or edited using a copy of Mathematica or MathReader.  If you 
	received this as email, use your mail application or copy/paste to save 
	everything from the line containing (*^ down to the line containing ^*)
	into a plain text file.  On some systems you may have to give the file a 
	name ending with ".ma" to allow Mathematica to recognize it as a Notebook.
	The line below identifies what version of Mathematica created this file,
	but it can be opened using any other version as well.";

	FrontEndVersion = "Macintosh Mathematica Notebook Front End Version 2.2";

	MacintoshStandardFontEncoding; 
	
	fontset = title, inactive, noPageBreakBelow, noPageBreakInGroup, nohscroll, preserveAspect, groupLikeTitle, center, M7, bold, e8,  24, "Times"; 
	fontset = subtitle, inactive, noPageBreakBelow, noPageBreakInGroup, nohscroll, preserveAspect, groupLikeTitle, center, M7, bold, e6,  18, "Times"; 
	fontset = subsubtitle, inactive, noPageBreakBelow, noPageBreakInGroup, nohscroll, preserveAspect, groupLikeTitle, center, M7, italic, e6,  14, "Times"; 
	fontset = section, inactive, noPageBreakBelow, nohscroll, preserveAspect, groupLikeSection, grayBox, M22, bold, a20,  18, "Times"; 
	fontset = subsection, inactive, noPageBreakBelow, nohscroll, preserveAspect, groupLikeSection, blackBox, M19, bold, a15,  14, "Times"; 
	fontset = subsubsection, inactive, noPageBreakBelow, nohscroll, preserveAspect, groupLikeSection, whiteBox, M18, bold, a12,  12, "Times"; 
	fontset = text, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, "Courier"; 
	fontset = smalltext, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  10, "Times"; 
	fontset = input, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeInput, M42, N23, bold,  12, "Courier"; 
	fontset = output, output, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23, L-3,  12, "Courier"; 
	fontset = message, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23,  12, "Courier"; 
	fontset = print, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23,  12, "Courier"; 
	fontset = info, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeOutput, M42, N23,  12, "Courier"; 
	fontset = postscript, PostScript, formatAsPostScript, output, inactive, noPageBreakInGroup, nowordwrap, preserveAspect, groupLikeGraphics, M7, l34, w282, h287,  12, "Courier"; 
	fontset = name, inactive, noPageBreakInGroup, nohscroll, preserveAspect, M7, italic, B32768,  10, "Times"; 
	fontset = header, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7, italic,  12, "Times"; 
	fontset = leftheader, inactive, L2,  12, "Times"; 
	fontset = footer, inactive, nohscroll, noKeepOnOnePage, preserveAspect, center, M7, italic,  12, "Times"; 
	fontset = leftfooter, inactive, L2,  12, "Times"; 
	fontset = help, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	fontset = clipboard, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	fontset = completions, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, "Courier"; 
	fontset = special1, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	fontset = special2, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	fontset = special3, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	fontset = special4, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	fontset = special5, inactive, nohscroll, noKeepOnOnePage, preserveAspect, M7,  12, ""; 
	paletteColors = 128; showRuler; currentKernel; 
]
:[font = title; inactive; Cclosed; preserveAspect; startGroup]
Programs for the Doomsday Rule
:[font = text; inactive; preserveAspect]
The cells below contain programs that implement the Doomsday Rule in Mathematica. If your interested in seeing these routines, open up the cells below. If not, go on the section marked "Random Dates-Practcing the Doomsday Rule."
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Gregorian Subroutines
:[font = text; inactive; preserveAspect]
The first routine tells us whether or not y is a leap year under the Gregorian calendar. GregLeapYear[y] is 1 if y is a leap year and 0 otherwise.
:[font = input; initialization; preserveAspect]
*)
Off[General::spell];
Off[General::spell1]; (*Turn off spelling correction.*)
(*
:[font = input; initialization; preserveAspect]
*)
GregLeapYear[y_]:=
If[
 Mod[y,400]==0 || Mod[y,100]!=0 && Mod[y,4]==0,
 1,0]
(*
:[font = input; preserveAspect]
GregLeapYear[1992]
GregLeapYear[2000]
GregLeapYear[1900]
:[font = input; preserveAspect]
Table[GregLeapYear[y],{y,1600,2400,100}]
:[font = input; preserveAspect]
Table[GregLeapYear[y],{y,1900,1916}]
:[font = text; inactive; preserveAspect]
GregMonthDD[m,y] gives a day in the month m and year y that is a Doomsday.
:[font = input; initialization; preserveAspect]
*)
GregMonthDD[m_,y_]:=If[Mod[m,2]==0,m,m+4]
GregMonthDD[1,y_]=31+GregLeapYear[y];
GregMonthDD[2,y_]=28+GregLeapYear[y];
GregMonthDD[9,y_]=5;
GregMonthDD[11,y_]=7;
(*
:[font = input; preserveAspect]
Table[GregMonthDD[m,1992],{m,1,12}]
Table[GregMonthDD[m,1994],{m,1,12}]
:[font = text; inactive; preserveAspect]
The routine GregCenturyDD[y] gives the Doomsday for the first year in the century of y. For example, GregCenturyDD[1976] is the Doomsday of 1900.
:[font = input; initialization; preserveAspect]
*)
GregCenturyDD[y_]:=
Mod[2+5 Mod[Floor[y/100],4],7]
(*
:[font = input; preserveAspect]
GregCenturyDD[1976]
Table[GregCenturyDD[y],{y,1600,2300,100}]
:[font = text; inactive; preserveAspect]
The routine GregYearDD[y] gives the Doomsday for the year y.
:[font = input; initialization; preserveAspect]
*)
GregYearDD[y_]:=
Mod[
 GregCenturyDD[y]+Mod[y,100]+Floor[Mod[y,100]/4],7]
(*
:[font = input; preserveAspect]
Table[GregYearDD[y],{y,1976,2003}]
:[font = text; inactive; preserveAspect]
The ultimate routine that will be used here is GregDay. GregDay[3,19,1994] gives the day of the week of March 19, 1994. The answer is a number between 0 and 6. 
:[font = input; initialization; preserveAspect]
*)
GregDay[month_,day_,year_]:=
Mod[GregYearDD[year]+day-GregMonthDD[month,year],7]
 
(*
:[font = input; preserveAspect; endGroup]
GregDay[3,19,1994]
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Julian Subroutines
:[font = text; inactive; preserveAspect]
Most of the routines here are Julian analogs of the Gregorian subroutines.
:[font = input; initialization; preserveAspect]
*)
JulLeapYear[y_]:=
If[Mod[y,4]==0,1,0]
(*
:[font = input; initialization; preserveAspect]
*)
JulMonthDD[m_,y_]:=If[Mod[m,2]==0,m,m+4]
JulMonthDD[1,y_]=31+JulLeapYear[y];
JulMonthDD[2,y_]=28+JulLeapYear[y];
JulMonthDD[9,y_]=5;
JulMonthDD[11,y_]=7;
(*
:[font = input; initialization; preserveAspect]
*)
JulCenturyDD[y_]:=Mod[6 Floor[y/100],7]
(*
:[font = text; inactive; preserveAspect]
BCFixer[y] turns a negative (i.e. BC) date into an equivalent positive date. It does this by adding an appropriate multiple of 28 and adding 1 to allow for the fact that there was no year 0.
:[font = input; initialization; preserveAspect]
*)
BCFixer[y_]:=y-28 Floor[y/28]+1
(*
:[font = input; preserveAspect]
BCFixer[-44]
:[font = input; initialization; preserveAspect]
*)
JulYearDD[y_]:=
If[y>0,
 Mod[JulCenturyDD[y]+Mod[y,100]+Floor[Mod[y,100]/4],7],
 JulYearDD[BCFixer[y]]]
(*
:[font = input; initialization; preserveAspect]
*)
JulDay[month_,day_,year_]:=
Mod[JulYearDD[year]+day-JulMonthDD[month,year],7]
 
(*
:[font = text; inactive; preserveAspect]
To get the day of the week of September 20, 1519 under the Julian calendar, use the following command.
:[font = input; preserveAspect; endGroup]
JulDay[9,20,1519]
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Main routines
:[font = text; inactive; preserveAspect]
The routines in this section decide whether the Gregorian or Julian calendar should be used. Change gives the date of the changeover from Julian to Gregorian.
:[font = input; initialization; preserveAspect]
*)
Change={10,15,1582};
(*
:[font = input; initialization; preserveAspect]
*)
Gregorian=1;Julian=0;
Cal[month_,day_,year_]:=
If[(year>Change[[3]])||
   (year==Change[[3]]) && (month>Change[[1]])||
   (year==Change[[3]]) && (month==Change[[1]]) && (day>=Change[[2]]),
   Gregorian,Julian]
(*
:[font = input; initialization; preserveAspect]
*)
DayNumber[month_,day_,year_]:=
If[Cal[month,day,year]==Gregorian,
   GregDay[month,day,year],
   JulDay[month,day,year]]
(*
:[font = input; initialization; preserveAspect]
*)
Clear[Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday]
DaysOfWeek={Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday};
(*
:[font = input; initialization; preserveAspect]
*)
CalDay[month_,day_,year_]:=
 DaysOfWeek[[DayNumber[month,day,year]+1]]
(*
:[font = text; inactive; preserveAspect]
If you want the day of the week of January 1, 2000, use the following command.
:[font = input; preserveAspect]
CalDay[1,1,2000]
:[font = text; inactive; preserveAspect]
Here is  how to use the English system with Gregorian Changeover day September 13, 1752.
:[font = input; preserveAspect]
CalDay[4,23,1616] (*Cervantes' death day*)
Change={9,13,1752} (*Change to English system*)
CalDay[4,23,1616] (*Shakespeare's death day*)
Change={10,15,1582} (*Change back to Continental system*)
:[font = text; inactive; preserveAspect; endGroup; endGroup]
  
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Random Dates
:[font = text; inactive; preserveAspect]
Here is a routine that produces  examples for practicing the Doomsday rule.
:[font = input; initialization; preserveAspect]
*)
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
(*
:[font = text; inactive; preserveAspect]
Here are some examples to practice with. The examples here will all be between 1900 and 1999.
:[font = input; inactive; locked; preserveAspect; startGroup]
randomdate[1900,1999]
:[font = output; output; inactive; locked; preserveAspect; endGroup]
{4, 24, 1946}
;[o]
{4, 24, 1946}
:[font = text; inactive; locked; preserveAspect]
I worked this out by hand, and I came up with 
:[font = subtitle; inactive; locked; preserveAspect]
Wednesday.
:[font = text; inactive; locked; preserveAspect]
Here's a check with Mathematica.
:[font = input; inactive; locked; preserveAspect; startGroup]
CalDay[4,24,1946]
:[font = output; output; inactive; locked; preserveAspect; endGroup]
Wednesday
;[o]
Wednesday
:[font = text; inactive; preserveAspect]
Now you take over and practice the Doomsday Rule.
:[font = input; preserveAspect]
randomdate[1900,1999]
:[font = text; inactive; preserveAspect; endGroup]
Run the cell above to get a random date. Use the Doomsday Rule to compute the day of the week by hand, then check yourself with the CalDay command. Repeat until you get really good at it.
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Famous Dates
:[font = text; inactive; preserveAspect]
The space shuttle Challenger exploded on January 28, 1986. What day of the week was that?
:[font = input; preserveAspect]
CalDay[1,28,1986]
:[font = text; inactive; preserveAspect]
World War II started on September 1, 1939 with the German invasion of Poland. What day of the week was it?
:[font = input; preserveAspect]
CalDay[9,1,1939]
:[font = text; inactive; preserveAspect]
The first atomic bomb used in combat was  dropped on Hiroshima on August 8, 1945. What day of the week was it?
:[font = input; preserveAspect]
CalDay[8,6,1945]
:[font = text; inactive; preserveAspect]
Compute the day of the week of your birthday.
:[font = text; inactive; preserveAspect]
Compute the day of the week of the birthday of someone in your family other than yourself.
:[font = text; inactive; preserveAspect]
Here are some  ``famous'' birthdays. Find the day of the week of each one.

August 29, 1950.
October 4, 1952.
June 25, 1976.
:[font = text; inactive; preserveAspect]
In 1966, there was exactly one Saturday between November 10 and November 16. Which day was it?
:[font = text; inactive; preserveAspect]
In the early morning hours of June 17, 1972, four men were arrested while breaking into Democratic party headquarters in the Watergate complex in Washington, D.C. What day of the week was it?
:[font = text; inactive; preserveAspect]
On the night of August 8, 1974, Richard M. Nixon announced that he would resign the Presidency. 
The resignation became official on the next day. What day of the week was the latter?
:[font = text; inactive; preserveAspect]
During a Monday night football game in early December  1980, Howard Cosell announced to a nationwide television audience that John Lennon had just been assasinated. What day was it? (Hint: It was after December 3 but before December 14.)
:[font = text; inactive; preserveAspect]
The Japanese attack on Pearl Harbor happened on the first Sunday in December, 1941. What day was it?
:[font = text; inactive; preserveAspect]
Sarah Bernhardt appeared  at the Calumet Theater on May 30, 1911.
What day of the week was it?
:[font = text; inactive; preserveAspect]
World War I started on August 4, 1914, and ended on November 11, 1918. Find the days of the week of these dates.
:[font = text; inactive; preserveAspect]
On December 5, 1933, the 21st Amendment to the U.S. Constitution was ratified. What was the purpose of this amendment, and what day of the week was it?
:[font = text; inactive; preserveAspect]
On May 26, 1959, Harvey Haddix, a pitcher for the Pittsburgh Pirates, pitched twelve perfect innings against the Milwaukee Braves. Despite this amazing performance, he lost the game in the 13th inning. What day of the week was it?
:[font = text; inactive; preserveAspect]
On April 8, 1974, Hank Aaron hit the 715th home run of career, and thereby broke a major league record that had been held by Babe Ruth. What day of the week was it?
:[font = text; inactive; preserveAspect]
In the book October 1964, David Halberstam chronicles the 1964 major league baseball season. The book is very well written, but there are some minor errors in the accounts of the last week of the pennant races. On page 299, he writes, ``On Sunday, September 29, Tony Kubek had a frustrating day at the plate ... .'' On page 307, he writes, ``On Monday, September 28, the Phillies went into St. Louis for a three-game series.'' At least one of these dates is clearly wrong. Which one?
;[s]
3:0,0;12,1;24,0;484,-1;
2:2,13,10,Courier,0,12,0,0,0;1,13,10,Courier,2,12,0,0,0;
:[font = text; inactive; preserveAspect]
The movie ``The Gunslinger'' has been featured on ``Mystery Science Theater 3000.'' In the movie, the words "Friday, May 21, 1878" are imposed on the opening scene. Did the scriptwriter get the day of the week correct?
:[font = text; inactive; preserveAspect]
In the movie ``Demolition Man'', the date August 3, 2032 is identified as a Monday. Is this correct?
:[font = text; inactive; preserveAspect]
The ``Star Trek: Deep Space Nine'' episode entitled ``Past Tense'' is set in the 21st century. In one scene, a calendar shows the date as Friday, August 30, 2030. Is the day of week correct?
:[font = text; inactive; preserveAspect]
In the book Fried Green Tomatoes at the Whistle Stop Cafe,
an elderly woman named Virginia Threadgoode recalls events from her 
distant past.  On page 12, she states, ``Some people thought it started the day she met Ruth, but I think it started that Sunday dinner, April the first, 1919, the same year Leona married John Justice.'' Explain why this
recollection is in error.
;[s]
3:0,0;12,1;57,0;375,-1;
2:2,13,10,Courier,0,12,0,0,0;1,13,10,Courier,2,12,0,0,0;
:[font = text; inactive; preserveAspect]
Let us assume that Virgina Threadgoode was correct about the
day of the week (Sunday) and the day of the year (April 1) in the 
passage in the previous problem. If so, she incorrectly remembered the
year. Find a year between 1915 and 1921 when
April 1 occurred on a Sunday.
:[font = text; inactive; preserveAspect]
Here are some famous Civil War dates. Compute the day of the week of each one.

Confederates fire on Fort Sumter: April 20, 1861.
The first day of the Battle of Gettysburg: July 1, 1863
Lee surrenders at Appomatox: April 10, 1865.
:[font = text; inactive; preserveAspect]
Each of the following days is the date of the assasination
of some historical figure. Find the day of the week and identify the person
who was assasinated.

(a) April 14, 1865.
(b) November 22, 1963.
(c) April 4, 1968.
(d) June 5, 1968.
(e) March 15, 44 B.C.
:[font = text; inactive; preserveAspect]
Cervantes and Shakespeare both died on April 23, 1616. However, Cervantes died on a Saturday, and Shakespeare died on a Tuesday. Explain.
:[font = text; inactive; preserveAspect]
According to legend, the ancient Greek philosopher Thales predicted that there would be a total eclipse of the Sun on May 28, 585 B.C. What day of the week was that?
:[font = text; inactive; preserveAspect]
Columbus ``discovered'' America on October 12, 1492. What day of the week was it?
:[font = text; inactive; preserveAspect]
Fermat announced his ``little theorem'' in a letter dated October 18, 1640. What day of the week was it?
:[font = text; inactive; preserveAspect]
In decreeing his calendar change, Pope Gregory XIII declared that the days of October 5--14, 1582, would be omitted. Thus the last day of the Julian Calendar was October 4, 1582. What day of the week was it? What day of the week was October 15, 1582?
:[font = text; inactive; preserveAspect]
As any English schoolboy (or schoolgirl) can tell you, The Battle of Hastings took place on October 14, 1066. What day of the week was it?
:[font = text; inactive; preserveAspect]
According to Archbishop Ussher, the first day of creation was October 23, 4004 B.C. What day of the week was it?
:[font = text; inactive; preserveAspect]
According to legend, Cleopatra committed suicide on August 30, 30 B.C. What day of the week was it?
:[font = text; inactive; preserveAspect; endGroup]

:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
The Changeover to the Gregorian Calendar
:[font = text; inactive; preserveAspect]
The Julian calendar was instituted by Julius Caesar in 45 B.C., and it was used throughout Europe until 1582. Under the Julian system, every year divisible by 4 is a leap year. In 1582, Pope Gregory instituted what is now called the Gregorian Calendar. He modified by the Julian Calendar by decreeing that century years (such as 1600, 1700, etc.) would be leap years if and only if they are divisible by 400. For example, 1900 was not a leap year, 2000 will be a leap year, and 2100 will not be a leap year. Pope Gregory also decreed that the days from October 5, 1582 to October 14, 1582 would be omitted. Thus Thursday, October 4, 1582 was followed by Friday, October 15, 1582.
:[font = input; preserveAspect]
CalDay[10,4,1582]
CalDay[10,15,1582]
:[font = text; inactive; preserveAspect]
The Gregorian Calendar was adopted immediately by the Catholic countries Italy, France, and Spain. Other countries adopted the Gregorian calendar at later dates. For example, Britain and the American colonies made the change in 1752, when they omitted the dates September 3-13. In Russia, the change was made in 1918, shortly after the "October Revolution" of November 1917. Sweden made a gradual changeover to the Gregorian calendar by omitting all leap years between 1700 and 1744.

The different calendar systems sometimes lead to international misunderstandings. For example, during the Napoleonic wars, the Russian military agreed to send troops to Prussia. Unfortunately, the troops arrived 11 days later than they were expected.
:[font = text; inactive; preserveAspect]
In the programs in this notebook, the changeover date is held in the variable "Change".
:[font = input; preserveAspect]
Change
:[font = text; inactive; preserveAspect]
All dates before Change are calculated with the Julian calendar, and all dates after Change are given in the Gregorian calendar. By default, Change is set to be October 14, 1582. You can reset Change to some other date if you like. For example, here is how to use the English system with Gregorian Changeover day September 13, 1752.
:[font = input; preserveAspect; endGroup]
CalDay[4,23,1616] (*Cervantes' death day*)
Change={9,13,1752} (*Change to English system*)
CalDay[4,23,1616] (*Shakespeare's death day*)
Change={10,15,1582} (*Change back to Continental system*)
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
How many Doomsdays?
:[font = text; inactive; preserveAspect]
Here is a Mathematica function that selects all of the years when Doomsday falls on a given date.
:[font = input; preserveAspect]
DDList[k_,y1_,y2_]:=Select[Range[y1,y2],GregYearDD[#]==k&]
:[font = text; inactive; preserveAspect]
DDList[k,y1,y2] gives you a list of all years y with $y1\le y \le y2$ and ${\hbox Doomsday}[y] = k$. For example, here is a list of all the years between 1900 and 1999 when Doomsday falls on a Wednesday.
:[font = input; preserveAspect]
DDList[3,1900,1999]
:[font = text; inactive; preserveAspect]
Here is a list of all the years between 1950 and 2050 when Doomsday falls on a Monday.
:[font = input; preserveAspect]
DDList[1,1950,2050]
:[font = text; inactive; preserveAspect]
You can use the Length function to count the number of elements in a list. For example, the following computation tells you how many times Doomsday falls on Wednesday in the years between 1900 and 1999.
:[font = input; preserveAspect]
Length[DDList[3,1900,1999]]
:[font = text; inactive; preserveAspect]
You can combine the functions Table, Length, and DDList to get a table for Doomsdays in the 20th Century.
:[font = input; preserveAspect]
Table[{k,Length[DDList[k,1900,1999]]},{k,0,6}]
:[font = text; inactive; preserveAspect]
This tells you, for example, that Doomsday is on Sunday 14 times in the 20th Century, on a Monday 14 times, and so on.
:[font = text; inactive; preserveAspect]
Questions:
:[font = text; inactive; preserveAspect]
The Gregorian Calendar has a cycle of 400 years. What are the most popular days for Doomsday in the Gregorian Calendar? What are the least popular days? 
:[font = text; inactive; preserveAspect]
Suppose you live to be exactly 100 years old. How many of your birthdays will be on Sunday? Do a similar computation for the other days of the week. You should count your date of birth as your ``zero-th'' birthday, so there will be 101 dates to consider. 
:[font = text; inactive; preserveAspect]
If you saved your 1994 calendar, you will be able to use it again in 2005. This is because 1994 and 2005 are both non-leap years with Doomsday on Monday. Suppose you save your 1995 calendar. When is the first year that you will be able to use it again? When is the first year that you will be able to use your 1996 calendar again?
:[font = text; inactive; preserveAspect; endGroup]
My grandfather was a miserly sort who was always looking for a way to save a few pennies. In 1896, when he was 17 years old, he noticed that there was never any need to throw away a calendar--it could always be used again. He resolved that in the future, he would buy a calendar if and only if he did not already have a copy of it.  Eventually, he collected all the calendars he would ever need. What years were in his collection?
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Routines for Easter
:[font = text; inactive; preserveAspect]
Easter is defined to be the first Sunday strictly after the Paschal Full Moon. The routines below compute the Paschal Full Moon, then use that information to compute Easter.
:[font = input; initialization; preserveAspect]
*)
EasterG[year_]:=Mod[year,19]+1;
GregorianEasterC[year_]:=
 Module[{c=Floor[year/100]},
 -c+Floor[c/4]+Floor[8(c+11)/25]];
 JulianEasterC[year_]:=3
EasterC[year_]:=
 If[year>Change[[3]],
    GregorianEasterC[year],JulianEasterC[year]]
(*
:[font = input; initialization; preserveAspect]
*)
Paschal1[year_]:=50-Mod[11 EasterG[year] + EasterC[year],30]
Paschal[year_]:=
If[Paschal1[year]<49,Paschal1[year],
 If[Paschal1[year]==50,49,
  If[EasterG[year]>11,48,49] ] ]
(*
:[font = input; initialization; preserveAspect]
*)
EasterNumber[year_]:=
Paschal[year]+7-DayNumber[3,Paschal[year],year]
(*
:[font = input; initialization; preserveAspect]
*)
Easter[year_]:=
If[EasterNumber[year]<32,
{March,EasterNumber[year]},
{April,EasterNumber[year]-31}]
 
(*
:[font = text; inactive; preserveAspect]
Here is Easter for 1994 and 1573.
:[font = input; preserveAspect]
Easter[1994]
Easter[1573]
:[font = text; inactive; preserveAspect]
Here is a table of dates for Easter between 1990 and 2000.
:[font = input; preserveAspect]
Table[Flatten[{Easter[x],x}],{x,1990,2000}]
:[font = text; inactive; preserveAspect]
The latest Easter can be is on April 25. Here is a listing of all the years between 1800 and 2000 with Easter on April 25.
:[font = input; preserveAspect; startGroup]
Select[Range[1800,2000],Function[Easter[#]=={April,25}]]
:[font = output; output; inactive; preserveAspect; endGroup]
{1886, 1943}
;[o]
{1886, 1943}
:[font = text; inactive; preserveAspect]
The earliest Easter can be is on March 22. Here is a listing of all years between 1800 and 2000 with Easter on March 22.
:[font = input; preserveAspect]
Select[Range[1800,2000],Function[Easter[#]=={March,22}]]
:[font = text; inactive; preserveAspect]
Find the next year when Easter will occur on April 25.
:[font = text; inactive; preserveAspect]
Find the next year when Easter will occur on March 22.
:[font = text; inactive; preserveAspect]
What is the most popular date for Easter in the 20th Century?
What will be the most popular date in the 21st Century?
:[font = smalltext; inactive; Cclosed; preserveAspect; startGroup]
For an answer to the first question, open up this cell.
:[font = smalltext; inactive; preserveAspect; center]
The following commands give a list of dates for Easter. The first number in each row is the number of times Easter occurs on that day in the 20th Century. To do the problem for the 21st century, simply change 1900 to 2000 and 1999 to 2099.
:[font = input; preserveAspect]
etable=Table[Easter[x],{x,1900,1999}];
freq[month_,day_]:=Length[Select[etable,#=={month,day}&]]
apriltable=Table[{freq[April,x],April,x},{x,1,25}];
marchtable=Table[{freq[March,x],March,x},{x,23,31}];
bigtable=Join[marchtable,apriltable];
ColumnForm[Sort[bigtable,(#2[[1]]<#1[[1]])&]]
:[font = output; output; inactive; preserveAspect; fontLeading = 0]
{5, April, 12}
{4, April, 19}
{4, April, 17}
{4, April, 16}
{4, April, 15}
{4, April, 11}
{4, April, 7}
{4, April, 6}
{4, April, 4}
{4, April, 3}
{4, April, 1}
{4, March, 31}
{4, March, 30}
{3, April, 22}
{3, April, 21}
{3, April, 20}
{3, April, 18}
{3, April, 14}
{3, April, 10}
{3, April, 9}
{3, April, 5}
{3, March, 29}
{3, March, 27}
{3, March, 26}
{2, April, 23}
{2, April, 13}
{2, April, 8}
{2, April, 2}
{2, March, 28}
{1, April, 25}
{1, March, 25}
{1, March, 24}
{1, March, 23}
{0, April, 24}
;[o]
{5, April, 12}
{4, April, 19}
{4, April, 17}
{4, April, 16}
{4, April, 15}
{4, April, 11}
{4, April, 7}
{4, April, 6}
{4, April, 4}
{4, April, 3}
{4, April, 1}
{4, March, 31}
{4, March, 30}
{3, April, 22}
{3, April, 21}
{3, April, 20}
{3, April, 18}
{3, April, 14}
{3, April, 10}
{3, April, 9}
{3, April, 5}
{3, March, 29}
{3, March, 27}
{3, March, 26}
{2, April, 23}
{2, April, 13}
{2, April, 8}
{2, April, 2}
{2, March, 28}
{1, April, 25}
{1, March, 25}
{1, March, 24}
{1, March, 23}
{0, April, 24}
:[font = smalltext; inactive; preserveAspect; center; endGroup]
From the above, you see that April 12 is the most popular day for Easter in the 20th century, with 5 occurrences.  April 24 is the least popular day; it will never occur as Easter in the 20th century.
:[font = text; inactive; preserveAspect; endGroup]
  
:[font = subsection; inactive; Cclosed; preserveAspect; startGroup]
Credits
:[font = text; inactive; preserveAspect; endGroup]
Doomsday rule and rule for calculating Easter were taken from the book ``Winning Ways for your Mathematical Plays'' by E.R. Berlekamp, J.H. Conway, and R.K. Guy. Mathematica routines written by Sid Graham. 
^*)
