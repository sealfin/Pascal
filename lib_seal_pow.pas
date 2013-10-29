unit lib_seal_pow;

interface

function f_Pow( p_base, p_exponent : integer ) : real;

implementation

function f_Pow( p_base, p_exponent : integer ) : real;
var
  result : real;
  i : integer;
begin
  if p_exponent = 0 then
    result := 1
  else begin
    result := p_base;
    for i := 1 to abs( p_exponent ) - 1 do
      result := result * p_base;
    if p_exponent < 0 then
      result := 1 / result
  end;
  f_Pow := result
end;

end.
