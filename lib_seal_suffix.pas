unit lib_seal_suffix;

interface

function f_Suffix( p : longint ) : string;

implementation

function f_Suffix( p : longint ) : string;
begin
  f_Suffix := 'th';
  case p mod 10 of
    1:if p mod 100 <> 11 then
      f_Suffix := 'st';
    2:if p mod 100 <> 12 then
      f_Suffix := 'nd';
    3:if p mod 100 <> 13 then
      f_Suffix := 'rd'
  end
end;

end.
