program tubestba;
uses crt;
type stack=record
        isi:array [0..1000] of char;
        top:integer;
        end;
var

	cc : string;
	indeks,i: integer;
	pita : string;
	stateA,stateB,stateC,stateD,stateE : string;
	data : string;
        S:stack;

procedure start();
begin
	pita := pita + '#';
	indeks := 1;
	cc := pita[indeks];
end;

procedure push(var S:stack; c:char);
var
i:integer;
begin
        inc(S.top);
        S.isi[S.top]:=c;
end;
procedure pop(var S:stack);
begin
        dec(S.top);
end;
procedure adv();
begin
	indeks := indeks + 1;
	cc := pita[indeks];
end;


procedure ignoreBlank();

begin
	while (cc = ' ') and (cc <> '#') do
	begin
		adv();
	end;
end;

function getLexic():string;
var
	lexic : string;
begin
	ignoreBlank();
	lexic := '';
	if (cc = '(') or (cc = ')') then
	begin
		lexic := cc;
		adv();
	end
	else
	begin
		while (cc <> ' ') and (cc <> '#') and (cc <> '(') and (cc <> ')') do
		begin
			lexic := lexic + cc;
			adv();
		end;
	end;
	getLexic := lexic;
end;

function cekOperator(B: string) : boolean;
begin
	if (B = '+') or (B = '-') or (B = 'x') or (B = ':') then
		cekOperator := true
	else
		cekOperator := false;
end;

function cekAngka(A:string) : boolean;
var
	b:boolean;
begin
	case A of
		'0' : b:=true;
		'1' : b:=true;
		'2' : b:=true;
		'3' : b:=true;
		'4' : b:=true;
		'5' : b:=true;
		'6' : b:=true;
		'7' : b:=true;
		'8' : b:=true;
		'9' : b:=true;
		else b := false;
	end;
	cekAngka := b;
 end;

function cekNum(S : string):boolean;
 var
	cek : boolean;
	i : integer;
	x : string;
 begin
	cek := true;
	i := 1;
	x := S + '#';

	if (x[i] = '-') or (x[i] = '+') then
		i := i + 1;

	if (cekAngka(x[i]) <> true) then
		cek := false;

	if (cek = true) then
	begin
		while (cekAngka(x[i]) = true) do
		begin
			i := i + 1;
		end;
	end;

	if (x[i] <> '#') and (cek = true) then
	begin

		if (x[i] = ',') then
		begin
			i := i + 1;

			if (cekAngka(x[i]) <> true) then
				cek := false;

			if (cek = true) then
			begin
				while (cekAngka(x[i]) = true) do
				begin
					i := i + 1;
				end;
			end;

		end
		else if (x[i] = 'E') then
		begin
			i := i + 1;
                        if (cek = true) then
			begin
				while (cekAngka(x[i]) = true) do
				begin
					i := i + 1;
				end;
			end;


			{if (x[i] = '-') or (x[i] = '+') then
			begin
				i := i + 1;
			end;

			if (cekAngka(x[i]) <> true) then
                        begin
				cek := false;
                        end;
			if (cek = true) then
			begin
				while (cekAngka(x[i]) = true) do
				begin
					i := i + 1;
				end;
			end;}
		end;

		if (x[i] <> '#') then
			cek := false;
	end;

	cekNum := cek;
 end;

BEGIN
	stateA := 'NUM';
	stateB := 'OPERATOR';
	stateC := 'KurBuka';
	stateD := 'KurTutup';
        stateE := 'Valid';
        stateF := 'Tidak Valid';

	repeat
		write('Masukan data : ');
		readln(pita);
	until (pita <> '');

	start();

	writeln;

	while cc <> '#' do
	begin
		data := getLexic();
		write(data,' : ');
		if (data = ')') then
		begin
			write(stateD);
                        if S.top<>0 then
                        begin
                                pop(S);
                        end
                        else
                        begin
                                for i:=0 to 99 do
                                begin
                                        push(S,'1');
                                end;
                        end;
		end
		else if (data = '(') then
		begin
			write(stateC);
                        if S.isi[S.top]='a'then
                        begin
                                pop(S);
                        end;
                        push(S,'(');
		end
		else if (cekOperator(data) = true) then
		begin
			write(stateB);
                        push(S,'a');

		end
		else if (cekNum(data) = true) then
		begin
                        if S.isi[S.top]='a'then
                        begin
                                pop(S);
                        end;
			write(stateA);
		end
		else
		begin
                        for i:=0 to 99 do
                        begin
                                push(S,'1');
                        end;
                        writeln('ERROR');
			break;
		end;
		writeln;
	end;
        if (S.top=0) then
        begin
                write(stateE);
        end
        else
        begin
                write('Tidak Valid');
        end;
	writeln;
        readln;
END.

