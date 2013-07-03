{$R+}
unit lib_seal_integerToString;

interface

function f_IntegerToString( p_integer : integer; p_explicitSign : boolean ) : string;

implementation

function f_IntegerToString( p_integer : integer; p_explicitSign : boolean ) : string;
var
  s : string;
  i : integer;
  divisionResult : 0..9;
  k : integer;
  c : char;
begin
  s := '';
  i := 1;
  if p_integer > 0 then begin
      if p_explicitSign then begin
        s := '+';
        i := 2
      end
    end
  else
    if p_integer < 0 then begin
      p_integer := -p_integer;
      s := '-';
      i := 2
    end;
  repeat
    divisionResult := p_integer mod 10;
    p_integer := p_integer div 10;
    s := s + chr( divisionResult + ord( '0' ))
  until p_integer = 0;
  k := length( s );
  while i < k do begin
    c := s[ i ];
    s[ i ] := s[ k ];
    s[ k ] := c;
    i := i + 1;
    k := k - 1
  end;
  f_IntegerToString := s
end;

end.
