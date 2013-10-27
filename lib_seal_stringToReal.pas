unit lib_seal_stringToReal;

interface

function f_StringToReal_FractionalPartLength( p_string : string; var p_real : real; var p_fractionalPartLength : integer ) : boolean;
{
Returns true if the string passed to this function was converted to a real without error.
An error will occur if:
* the string passed to the function is zero characters in length;
* the string passed to the function contains only a sign character;
* the string passed to the function contains a sign character and that character is not the first character in the string;
* the string passed to the function contains only a decimal point character;
* the string passed to the function contains numerical characters in neither the integer part nor the fractional part;
* the string passed to the function contains a character which is not a sign, decimal point, or numerical character.
}

function f_StringToReal( p_string : string; var p_real : real ) : boolean;
{
Refer to the documentation of the function f_StringToReal_FractionalPartLength.
}

implementation

uses
  lib_seal_pow;

function f_StringToReal_FractionalPartLength( p_string : string; var p_real : real; var p_fractionalPartLength : integer ) : boolean;

  function f_private( p_begin, p_end : integer; var p_integer : integer ) : boolean;
  label
    l_END;
  var
    multiplier, i, v : integer;
  begin
    f_private := false;
    p_integer := 0;
    multiplier := 1;
    for i := p_end downto p_begin do
      if p_string[ i ] in [ '0'..'9' ] then begin
          v := ord( p_string[ i ] ) - ord( '0' );
          v := v * multiplier;
          p_integer := p_integer + v;
          multiplier := multiplier * 10
        end
      else
        goto l_END;
    f_private := true;
  l_END:end;

label
  l_END;
var
  i_part_begin : integer;
  is_negative : boolean;
  i_part_end, i, l, f : integer;
  r : real;
begin
  f_StringToReal_FractionalPartLength := false;
  p_real := 0;
  p_fractionalPartLength := 0;
  if length( p_string ) = 0 then
    goto l_END;
  i_part_begin := 1;
  is_negative := false;
  if p_string[ 1 ] in [ '+', '-' ] then begin
    if length( p_string ) = 1 then
      goto l_END;
    i_part_begin := 2;
    is_negative := p_string[ 1 ] = '-'
  end;
  i_part_end := i_part_begin;
  while not ( i_part_end = length( p_string )) and not ( p_string[ i_part_end ] = '.' ) do
    i_part_end := i_part_end + 1;
  if p_string[ i_part_end ] = '.' then begin
      if length( p_string ) = 1 then
        goto l_END;
      if ( p_string[ 1 ] in [ '+', '-' ] ) and ( length( p_string ) = 2 ) then
        goto l_END;
      if not f_private( i_part_begin, i_part_end - 1, i ) then
        goto l_END;
      l := length( p_string ) - i_part_end;
      p_fractionalPartLength := l;
      if l > 0 then begin
        if not f_private( i_part_end + 1, length( p_string ), f ) then
          goto l_END;
        r := f;
        r := r / f_Pow( 10, l );
        p_real := r
      end
    end
  else
    if not f_private( i_part_begin, i_part_end, i ) then
      goto l_END;
  p_real := p_real + i;
  if is_negative then
    p_real := -p_real;
  f_StringToReal_FractionalPartLength := true;
l_END:end;

function f_StringToReal( p_string : string; var p_real : real ) : boolean;
var
  i : integer;
begin
  f_StringToReal := f_StringToReal_FractionalPartLength( p_string, p_real, i )
end;

end.
