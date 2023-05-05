%let pgm=utl-adding-a-prefixes-to-existing-labels-for-one-hundred-variable;

Adding a prefixes to existing labels for one hundred variable

Problem

   Add the prefix NUM to all existing labels for varables that beging with NUM
   Add the prefix VAR to all existing labels for varables that beging with VAR

 Three Solutions
      1. Roger macro

      2  Mark native code
         Mark Keintz
         mkeintz@outlook.com

      3  Bart native code
         Bartosz Jablonski
         yabwon@gmail.com

github
https://tinyurl.com/yes7wn74
https://github.com/rogerjdeangelis/utl-adding-a-prefixes-to-existing-labels-for-one-hundred-variable-

SAS Commumities
https://tinyurl.com/2s49mx6d
https://communities.sas.com/t5/SAS-Programming/RE-label-multiple-variables/td-p/873287

With DOSUBL I could do the entire process within the input dataset.
Mybe some day SAS will make dosubl an executable. Currently it is slow.

If _n_=0 the create label datasets
input var1 - var78 num1 - num20
if end of file drop down using dosubl to proc datasets

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
data have;
  retain var1 - var78 num1 - num20 1;
  ATTRIB
    var1 -- var78 label= "some label"
    num1 -- num20 label= "other label"
  ;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                                                                                        */
/*             Variables in Creation Order                 |     RULES PREFIC NUM AND VAR                                 */
/*                                                         |                                                              */
/*   #    Variable    Type    Len    Label                 |      LABEM                                                   */
/*                                                         |                                                              */
/*   1    VAR1        Char      3    some label            |      VAR some label    ==> add VAR to label for char vars    */
/*   2    VAR2        Char      3    some label            |      VAR some label                                          */
/*   3    VAR3        Char      3    some label            |      VAR some label                                          */
/*  ....                                                   |      VAR                                                     */
/*  76    VAR76       Char      3    some label            |      VAR some label                                          */
/*  77    VAR77       Char      3    some label            |      VAR some label                                          */
/*  78    VAR78       Char      3    some label            |      VAR some label                                          */
/*                                                         |                                                              */
/*  79    NUM1        Num       8    other label           |      NUM other label   ==> add NUM to label for numeric vars */
/*  80    NUM2        Num       8    other label           |      NUM other label                                         */
/*  81    NUM3        Num       8    other label           |      NUM other label                                         */
/*        ...                                              |                                                              */
/*  96    NUM18       Num       8    other label           |      NUM  other label                                        */
/*  97    NUM19       Num       8    other label           |      NUM  other label                                        */
/*  98    NUM20       Num       8    other label           |      NUM  other label                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __ ___   __ _  ___ _ __   _ __ ___   __ _  ___ _ __ ___
| `__/ _ \ / _` |/ _ \ `__| | `_ ` _ \ / _` |/ __| `__/ _ \
| | | (_) | (_| |  __/ |    | | | | | | (_| | (__| | | (_) |
|_|  \___/ \__, |\___|_|    |_| |_| |_|\__,_|\___|_|  \___/
           |___/
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*              Variables in Creation Order                                                                               */
/*                                                                                                                        */
/*    #    Variable    Type    Len    Label                                                                               */
/*                                                                                                                        */
/*    1    VAR1        Char      3    VAR some label                                                                      */
/*    2    VAR2        Char      3    VAR some label                                                                      */
/*    3    VAR3        Char      3    VAR some label                                                                      */
/*   ....                             VAR                                                                                 */
/*   76    VAR76       Char      3    VAR some label                                                                      */
/*   77    VAR77       Char      3    VAR some label                                                                      */
/*   78    VAR78       Char      3    VAR some label                                                                      */
/*                                                                                                                        */
/*   79    NUM1        Num       8    NUM other label                                                                     */
/*   80    NUM2        Num       8    NUM other label                                                                     */
/*   81    NUM3        Num       8    NUM other label                                                                     */
/*         ...                                                                                                            */
/*   96    NUM18       Num       8    NUM  other label                                                                    */
/*   97    NUM19       Num       8    NUM  other label                                                                    */
/*   98    NUM20       Num       8    NUM  other label                                                                    */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

/*---- create label table. I have added prefix               ----*/
data havlbl (DROP=num: var:);
  set have (obs=1);
  array vars var:;
  array nums num:;
  if _n_=1 then do;
     do over vars; nam=vname(vars); lbl=catx(" ","VAR",vlabel(vars)) ; output havLbl; end;
     do over nums; nam=vname(nums); lbl=catx(" ","NUM",vlabel(nums)) ; output havLbl; end;
  end;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Up to 40 obs from HAVLBL total obs=98 04MAY2023:17:47:54                                                               */
/*                                                                                                                        */
/* Obs     NAM          LBL                                                                                               */
/*                                                                                                                        */
/*   1    VAR1     VAR some label                                                                                         */
/*   2    VAR2     VAR some label                                                                                         */
/*   3    VAR3     VAR some label                                                                                         */
/*  ...                                                                                                                   */
/*  75    VAR75    VAR some label                                                                                         */
/*  76    VAR76    VAR some label                                                                                         */
/*  77    VAR77    VAR some label                                                                                         */
/*  78    VAR78    VAR some label                                                                                         */
/*                                                                                                                        */
/*  79    NUM1     NUM other label                                                                                        */
/*  80    NUM2     NUM other label                                                                                        */
/*  81    NUM3     NUM other label                                                                                        */
/*  ,,,                                                                                                                   */
/*  96    NUM18    NUM other label                                                                                        */
/*  97    NUM19    NUM other label                                                                                        */
/*  98    NUM20    NUM other label                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*---- use the label dataset to apply the new labels         ----*/
/*---- this is very redable                                  ----*/
%array(_nam _lbl,data=havlbl,var=NAM LBL);

proc datasets nolist nodetails;
   modify have;
    label
      %do_over(_nam _lbl,phrase=%str(?_nam = "?_lbl"))
    ;
run;quit;

/*                                _
  __ _  ___ _ __     ___ ___   __| | ___
 / _` |/ _ \ `_ \   / __/ _ \ / _` |/ _ \
| (_| |  __/ | | | | (_| (_) | (_| |  __/
 \__, |\___|_| |_|  \___\___/ \__,_|\___|
 |___/
*/

%utlnopts;
data _null_;
 put "label";
 %do_over(_nam _lbl,phrase=%str(put "?_nam = '?_lbl'";))
 ;
run;quit;
%utlopts;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  label                                                                                                                 */
/*                                                                                                                        */
/*  VAR1 = 'VAR some label'                                                                                               */
/*  VAR2 = 'VAR some label'                                                                                               */
/*  VAR3 = 'VAR some label'                                                                                               */
/*  ...                                                                                                                   */
/*  VAR75 = 'VAR some label'                                                                                              */
/*  VAR76 = 'VAR some label'                                                                                              */
/*  VAR77 = 'VAR some label'                                                                                              */
/*  ...                                                                                                                   */
/*  VAR78 = 'VAR some label'                                                                                              */
/*  NUM1 = 'NUM other label'                                                                                              */
/*  NUM2 = 'NUM other label'                                                                                              */
/*  NUM3 = 'NUM other label'                                                                                              */
/*                                                                                                                        */
/*  NUM19 = 'NUM other label'                                                                                             */
/*  NUM20 = 'NUM other label'                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                    _                  _   _                           _
 _ __ ___   __ _ _ __| | __  _ __   __ _| |_(_)_   _____    ___ ___   __| | ___
| `_ ` _ \ / _` | `__| |/ / | `_ \ / _` | __| \ \ / / _ \  / __/ _ \ / _` |/ _ \
| | | | | | (_| | |  |   <  | | | | (_| | |_| |\ V /  __/ | (_| (_) | (_| |  __/
|_| |_| |_|\__,_|_|  |_|\_\ |_| |_|\__,_|\__|_| \_/ \___|  \___\___/ \__,_|\___|

*/

/*---- best solution uses natice SAS ----*/

/*---- Mark Keintz                   ----*/
/*---- mkeintz@outlook.com           ----*/

options validvarname=upcase;

filename tmp temp;

data _null_;
  if 0 then set have;
  length _vname $32 _vnam3 $3 _text $200;
  file tmp;
  do until (_vname='_VNAME');
    call vnext(_vname);
    _vnam3=upcase(_vname);
    if _vnam3 in ('NUM','VAR') then do;
      _text=cats(_vname,'="',_vnam3,catx(' ',':',vlabelx(_vname)),'"');
      put +3 _text;
    end;
  end;
  stop;
run;quit;

proc datasets lib=work nolist;
  modify have ;
  label
   %include tmp / source2 ;
  ;
  run;
quit;

/*                _                 _   _                           _
| |__   __ _ _ __| |_   _ __   __ _| |_(_)_   _____    ___ ___   __| | ___
| `_ \ / _` | `__| __| | `_ \ / _` | __| \ \ / / _ \  / __/ _ \ / _` |/ _ \
| |_) | (_| | |  | |_  | | | | (_| | |_| |\ V /  __/ | (_| (_) | (_| |  __/
|_.__/ \__,_|_|   \__| |_| |_|\__,_|\__|_| \_/ \___|  \___\___/ \__,_|\___|

*/

/*---- Bartosz Jablonski ----*/
/*---- yabwon@gmail.com  ----*/

data ;
  retain var1 - var78 "abc" num1 - num20 0 A B C D E F G "xxx";
  ATTRIB
    var1 -- var78 label= "some label"
    num1 -- num20 label= "other lable"
    A -- G        label= 'different variables'
  ;
run;

proc transpose data=have(obs=0) out=temp;
  var var: num:;
run;
data _null_;
  call execute('
    proc datasets nolist lib=work;
      modify have ;
        label');
  do until(eof);
    set temp end=eof;
    call execute(cat(_NAME_,"='",substr(_NAME_,1,3)," ",_LABEL_,"'"));
  end;

  call execute(';run;quit;');
stop;
run;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
