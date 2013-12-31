{$R+}
unit lib_seal_calendar;

interface

type
  t_Day = 1..31;
  t_Month = 1..12;

function f_IsLeapYear( p : integer ) : boolean;
function f_NumberOfDaysInMonth( p_month : t_Month; p_year : integer ) : t_Day;

implementation

function f_IsLeapYear( p : integer ) : boolean;
begin
  f_IsLeapYear := false;
  if p mod 4 = 0 then
    if p mod 100 <> 0 then
      f_IsLeapYear := true
    else
      if p mod 400 = 0 then
        f_IsLeapYear := true
end;

function f_NumberOfDaysInMonth( p_month : t_Month; p_year : integer ) : t_Day;
begin
  case p_month of
    1:f_NumberOfDaysInMonth := 31;
    2:if not f_IsLeapYear( p_year ) then
        f_NumberOfDaysInMonth := 28
      else
        f_NumberOfDaysInMonth := 29;
    3:f_NumberOfDaysInMonth := 31;
    4:f_NumberOfDaysInMonth := 30;
    5:f_NumberOfDaysInMonth := 31;
    6:f_NumberOfDaysInMonth := 30;
    7:f_NumberOfDaysInMonth := 31;
    8:f_NumberOfDaysInMonth := 31;
    9:f_NumberOfDaysInMonth := 30;
    10:f_NumberOfDaysInMonth := 31;
    11:f_NumberOfDaysInMonth := 30;
    12:f_NumberOfDaysInMonth := 31
  end
end;

end.
