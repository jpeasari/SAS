/* Richard A. DeVenezia
 * http://www.devenezia.com
 * 11/28/03
 *
 * orginally posted to SAS-L Oct 17, 2002
 */

%macro calendar_report (month, year);

  data grid;
    date1 = mdy (&month,1,&year);
    date2 = intnx ('month', date1, 1) - 1;
    do date = date1 to date2;
      wim = intck ('week', date1, date);
      dim = date-date1+1;
      dow = weekday (date);
      output;
    end;
  run;

  proc format;
    value dayname
    1 = 'Sunday'
    2 = 'Monday'
    3 = 'Tuesday'
    4 = 'Wednesday'
    5 = 'Thursday'
    6 = 'Friday'
    7 = 'Saturday'
    ;
  run;

  options missing=' ';

  proc report nowindows data=grid
    style (column) = { just=center cellheight=50pt cellwidth=14.29% just=left vjust=top  }
  ;
    column wim ("%sysfunc(mdy(&month,1,&year), monname) &year" dow, dim) ;
    define wim / group noprint ;
    define dow / across ' '  format=dayname. order=internal;
    define dim / ' ';
  run;

  options missing='.';

%mend;
