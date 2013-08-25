unit lib_seal_toLowercase;

interface

function f_ToLowercase( p : char ) : char;

implementation

function f_ToLowercase( p : char ) : char;
var
  i : integer;
begin
  f_ToLowercase := p;
  if p in [ 'A'..'Z' ] then begin
    i := ord( p );
    i := i - ord( 'A' );
    i := i + ord( 'a' );
    f_ToLowercase := chr( i )
  end
end;

end.
