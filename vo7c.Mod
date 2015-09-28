MODULE vo7c;

IMPORT Args, Out := Console, Strings(*, OP, OG*),
Unix;

VAR name : ARRAY 255 OF CHAR;
newSF, inchk, main : BOOLEAN;

(* args *)

PROCEDURE argscount*() : LONGINT;
   VAR l : LONGINT;
BEGIN
   l := Args.argc -1 ;
   RETURN(l);
END argscount;

PROCEDURE arg*(l : INTEGER; VAR str : ARRAY OF CHAR);
   VAR
      s : ARRAY 255 OF CHAR;
      i : LONGINT;
BEGIN
   Args.Get (l, s);
   COPY (s, str);
END arg;
 (* end of args *)

PROCEDURE Showhelp;
BEGIN
Out.String ("Usage:"); Out.Ln;
Out.String (" vo7c modulename options"); Out.Ln;
Out.String ("    options:"); Out.Ln;
Out.String (" -s  new symbol file"); Out.Ln;
Out.String (" -x  without runtime checks"); Out.Ln;
Out.String (" -m  main module"); Out.Ln;
HALT(0)
END Showhelp;


PROCEDURE CompileModule(VAR s : ARRAY OF CHAR);
VAR tmp, tmpstr : ARRAY 255 OF CHAR;
BEGIN
   COPY("./OP ", tmp);
   Strings.Append(s, tmp);
   Strings.Append (" /", tmp);
   IF newSF THEN Strings.Append("s", tmp) END;
   IF main THEN Strings.Append("m", tmp) END;
   Unix.system(tmp);
   (* later
   Strings.Append (OG.asmname, tmpstr);
   COPY ('as -o ', tmpstr);
   Strings.Append (OG.modname, tmpstr);
   Strings.Append ('.o ', tmpstr);
   Strings.Append (OG.modname, tmpstr);
   Strings.Append ('.s', tmpstr);
   Out.String (tmpstr); Out.Ln;
   Unix.system(tmpstr);
   *)
END CompileModule;

PROCEDURE ParseOptions;
VAR 
   ch : CHAR;
   options : ARRAY 255 OF CHAR;
   i : INTEGER;
BEGIN
(*OP.newSF := FALSE; OP.check := FALSE; main := FALSE;*)

IF argscount() < 1 THEN Out.String ("Error processing: wrong number of arguments"); Out.Ln; Showhelp END;
arg (1, name);
 IF ((name[0] = '-') OR (name[0]='/') OR (name[0]='\')) THEN 
    COPY(name, options); name := '';
    arg(2, name);
 ELSE
    arg(2, options);
 END;
i := 1;
REPEAT 
   ch := options[i];  INC( i );  
     CASE ch OF 
       "s":  newSF := TRUE;
     | "x":  inchk := TRUE;
     | "m":  main := TRUE;
     ELSE 
     IF ch > " " THEN Out.String( "Option not found:" );  Out.Char( ch );  Out.Ln;  END
     END
UNTIL ch = 0X;

END ParseOptions;

BEGIN
   COPY ("", name);
   ParseOptions;
   CompileModule(name);
END vo7c.
