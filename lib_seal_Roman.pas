unit lib_seal_Roman;

interface

function f_RomanNumeralsToInteger( p_romanNumerals : string; var p_integer : integer ) : boolean;
{
Returns true if the Roman numerals passed to the function were converted to an integer without error.
An error will occur if:
* the string passed to the function is zero characters in length;
* the string passed to the function contains non-Roman numeral characters.
}

function f_IntegerToRomanNumerals( p_integer : integer; var p_romanNumerals : string ) : boolean;
{
Returns true if the integer passed to the function was converted to Roman numerals without error.
An error will occur if:
* the integer passed to the function is ≤0.
}

implementation

function f_RomanNumeralsToInteger( p_romanNumerals : string; var p_integer : integer ) : boolean;

  function f_private( p_romanNumeral : char; var p_integer : integer ) : boolean;
  begin
    f_private := true;
    p_romanNumeral := upcase( p_romanNumeral );
    case p_romanNumeral of
      'I':p_integer := 1;
      'V':p_integer := 5;
      'X':p_integer := 10;
      'L':p_integer := 50;
      'C':p_integer := 100;
      'D':p_integer := 500;
      'M':p_integer := 1000
    else
      f_private := false
    end
  end;

label
  l_END;
var
  i_r, i_1, i, i_2 : integer;
begin
  f_RomanNumeralsToInteger := true;
  if length( p_romanNumerals ) = 0 then begin
    f_RomanNumeralsToInteger := false;
    goto l_END
  end;
  i_r := 0;
  i_1 := 0;
  for i := 1 to length( p_romanNumerals ) do begin
    if not f_private( p_romanNumerals[ i ], i_2 ) then begin
      f_RomanNumeralsToInteger := false;
      goto l_END
    end;
    if i_1 < i_2 then begin
      i_r := i_r - i_1;
      i_2 := i_2 - i_1
    end;
    i_r := i_r + i_2;
    i_1 := i_2
  end;
  p_integer := i_r;
l_END:end;

function f_IntegerToRomanNumerals( p_integer : integer; var p_romanNumerals : string ) : boolean;

  function f_private( p_i : integer; p_c, p_c_multipleOf5, p_c_multipleOf10 : char ) : string;
  var
    s : string;
    i : integer;
  begin
    case p_i of
      9:s := p_c + p_c_multipleOf10;
      4:s := p_c + p_c_multipleOf5
    else
      begin
        s := '';
        if p_i >= 5 then begin
          s := p_c_multipleOf5;
          p_i := p_i - 5
        end;
        for i := 1 to p_i do
          s := s + p_c
      end
    end;
    f_private := s
  end;

label
  l_END;
var
  thousands, hundreds, tens, units : integer;
  s : string;
  i : integer;
begin
  f_IntegerToRomanNumerals := true;
  if p_integer <= 0 then begin
    f_IntegerToRomanNumerals := false;
    goto l_END
  end;
  thousands := p_integer div 1000;
  p_integer := p_integer mod 1000;
  hundreds := p_integer div 100;
  p_integer := p_integer mod 100;
  tens := p_integer div 10;
  p_integer := p_integer mod 10;
  units := p_integer;
  s := '';
  for i := 1 to thousands do
    s := s + 'M';
  s := s + f_private( hundreds, 'C', 'D', 'M' );
  s := s + f_private( tens, 'X', 'L', 'C' );
  s := s + f_private( units, 'I', 'V', 'X' );
  p_romanNumerals := s;
l_END:end;

end.
