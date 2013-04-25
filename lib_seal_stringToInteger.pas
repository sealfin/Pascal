unit lib_seal_stringToInteger;

interface

function f_StringToInteger( p_string : string; var p_integer : integer ) : boolean;
{
Returns true if the string passed to this function was converted to an integer without error.
An error will occur if:
* the string passed to the function is zero characters in length;
* the string passed to the function contains only a sign character;
* the string passed to the function contains a sign character and that character is not the first character in the string;
* the string passed to the function contains a character which is neither a sign nor a numerical character.
}

implementation

function f_StringToInteger( p_string : string; var p_integer : integer ) : boolean;
label
  l_END;
var
  result, multiplier, i : integer;
begin
  f_StringToInteger := false;
  if length( p_string ) = 0 then
    goto l_END
  else
    if ( length( p_string ) = 1 ) and ( p_string[ 1 ] in [ '+', '-' ] ) then
      goto l_END
    else begin
      result := 0;
      multiplier := 1;
      for i := length( p_string ) downto 1 do begin
        if p_string[ i ] in [ '0'..'9' ] then
          result := result + (( ord( p_string[ i ] ) - ord( '0' )) * multiplier )
        else
          if i = 1 then begin
              if p_string[ 1 ] = '+' then
              else
                if p_string[ 1 ] = '-' then
                  result := -result
                else
                  goto l_END
            end
          else
            goto l_END;
        multiplier := multiplier * 10
      end
    end;
  p_integer := result;
  f_StringToInteger := true;
l_END:end;

end.
