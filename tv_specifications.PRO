DATABASE
	db_tv (string,real,string,string,string,real)/*Name, Diagonal sm, Brand, screen resolution, TYPES OF TV MATRICES , weight kg*/

DOMAINS
	file = datafile
	strings = string*
	reals = real*

PREDICATES
	menu
	reaction(char)
	exists(string)
	deldb
	add_tv
	retquation4
	findquation4
	find(real)
	write_db
	write_db(strings,reals,strings,strings,strings,reals)
	write_db2
	write_db2(strings,reals,strings,strings,strings,reals)
	find_tv(symbol)
	find_tv_name(symbol)
	find_os(symbol)
	find_name(symbol)
	dely
	read_rows()
	front_string(string, string, string)
	insert_into_database(string,real,string,string,string,real)

GOAL
	makewindow(1, 112, 0, "BD TV ", 0,0,25,80, 1, -1,"\218\191\192\217\196\179"),
	menu.

CLAUSES
	front_string("", "", "") :- !.
	front_string(Line, Param, Tail) :-frontchar(Line, LineH, LineT), 
									LineH = ';', !, 
									Param = "", Tail = LineT;
									
									frontchar(Line, LineH, LineT), 
									LineH <> ';', !, 
									front_string(LineT, T, Tail), 
									str_char(LineHS, LineH),	
									concat(LineHS, T, Param).

	insert_into_database(F1, F2, F3, F4,F5, F6) :-assertz(db_tv(F1, F2, F3, F4,F5, F6)).

	exists(Filename) :-existfile(Filename), !.
	

	deldb:-retract(db_tv (_,_,_,_,_, _)), fail.
	deldb.

	add_tv:-clearwindow,write("Enter Name: "), nl, readln(Name),
							write("Enter Diagonal sm: "),nl, readreal(Diagonal),Diagonal>0,
							write("Enter Brand: "),nl, readln(Brand),
							write("Enter Screen resolution: "),nl, readln(Screen),
							write("Enter Kind of matrix: "),nl, readln(MATRICES),
							write("Enter Weight kg: "),nl, readreal(Weight),Weight>0,Weight<100,
							assertz(db_tv(Name,Diagonal,Brand,Screen,MATRICES,Weight)).
	add_tv:-write("ERROR ERROR ERROR!!!!!!!!!!!!!!!!!!"), dely, add_tv.
	
	findquation4:-clearwindow, write("1 - find tv by Name "),nl,
									 		write("2 - find record by Brand "),nl, readint(N), find(N).
	
	menu:- clearwindow,
						write(" 1 - clean and create new database"),nl,
						write(" 2 - read database from file"),nl,
						write(" 3 - add tv"),nl,
						write(" 4 - find tv"),nl,
						write(" 5 - delete tv"),nl,
						write(" 6 - edit tv"),nl,
						write(" 7 - save in file"),nl,
						write(" 8 - see all database"), nl,
						write(" 9 - exit"), nl, readchar(N), reaction(N).


	reaction('1'):-deldb,write("DB was clear"),dely,menu.

	reaction('2'):-clearwindow, write("Enter name of file "),
		readln(Filename), exists(Filename),
		openread(datafile, Filename), readdevice(datafile), deldb, read_rows(),
		closefile(datafile), readdevice(keyboard),
									dely,menu.
	reaction('3'):-add_tv, write("tv added"),nl, dely, menu.

	reaction('4'):-clearwindow, findquation4, menu.

	reaction('5'):-clearwindow, retquation4,write("record removed"),nl, dely, menu.
	reaction('5'):-write("No such entry exists! "), dely, menu.
	
	reaction('6'):-clearwindow, retquation4, add_tv,write("tv edited"),nl, dely, menu.
	reaction('6'):-write("No such entry exists! "), dely, menu.
	
	reaction('7'):-write("Enter name of file "), readln(Fname),Fname<>"", openwrite(datafile, Fname), writedevice(datafile),
	write_db(), closefile(datafile), writedevice(screen), dely, menu.

	reaction('8'):- write_db2(), dely, menu.
	reaction('9').

	reaction(_):-write("Error."), dely, menu.
	
	
	find(1):-clearwindow, write("Enter Name of tv "), readln(Name),
						find_tv_name(Name), find_name(Name).

	find(1):-write("No such tv in database!"), dely.

	find(2):-clearwindow, write("Enter Brand of tv "), readln(Brand),
						find_tv(Brand), find_os(Brand).

	find(2):-write("No such tv in database!"), dely.

	find(_):-write("Error "), dely.
	
	find_tv_name(Name):-db_tv(Name,Diagonal,Brand,Screen,MATRICES,Weight),write("\nTV: "),
						nl, write("Name: ",Name),
						nl, write("Diagonal: ",Diagonal," sm;"),
						nl, write("Brand: ",Brand,";"),
						nl, write("Screen resolution: ",Screen,";"),
						nl, write("Matrix: ",MATRICES,";"),
						nl, write("Weight: ",Weight," kg;"),
				 		dely, fail.
	find_tv_name(_).
	
	find_tv(Brand):-db_tv(Name,Diagonal,Brand,Screen,MATRICES, Weight),write("\nTV: "),
						nl, write("Name: ",Name),
						nl, write("Diagonal: ",Diagonal," sm;"),
						nl, write("Brand: ",Brand,";"),
						nl, write("Screen resolution: ",Screen,";"),
						nl, write("Matrix: ",MATRICES,";"),
						nl, write("Weight: ",Weight," kg;"),
				 		dely, fail.

	find_tv(_).
 
	find_name(Name):-db_tv(Name,_,_,_,_,_).
	find_os(Brand):-db_tv(_,_,Brand,_,_,_).


	retquation4:-write("Enter Name of tv "), nl, readln(Name),
					retract(db_tv(Name,_,_,_,_,_)).


	dely:-nl, nl, write("Any key to continue"), nl, readchar(_).
	
	write_db2() :-
		findall(P1, db_tv(P1, _, _, _,_,_), P1s),
		findall(P2, db_tv(_, P2, _, _,_,_), P2s),
		findall(P3, db_tv(_, _, P3, _,_,_), P3s),
		findall(P4, db_tv(_, _, _, P4,_,_), P4s),
		findall(P5, db_tv(_, _, _, _,P5,_), P5s),
		findall(P6, db_tv(_, _, _, _,_,P6), P6s),
		write_db2(P1s, P2s, P3s, P4s, P5s, P6s);
		writedevice(screen).

	write_db2([], [], [], [], [], []) :- !.
	write_db2([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5], [P6|T6]) :-
		%write("DB2_2"),
		write("\nName: ", P1, "; \nDiagonal: ", P2, " sm; \nBrand: ", P3, "; \nScreen resolution: ",P4, "; \nMatrix: ",P5, "; \nWeight: ", P6, " kg."), nl,
		write_db2(T1, T2, T3, T4, T5, T6).


	write_db() :-
		findall(P1, db_tv(P1, _, _, _,_,_), P1s),
		findall(P2, db_tv(_, P2, _, _,_,_), P2s),
		findall(P3, db_tv(_, _, P3, _,_,_), P3s),
		findall(P4, db_tv(_, _, _, P4,_,_), P4s),
		findall(P5, db_tv(_, _, _, _,P5,_), P5s),
		findall(P6, db_tv(_, _, _, _,_,P6), P6s),
		write_db(P1s, P2s, P3s, P4s, P5s, P6s);
		writedevice(screen).

	write_db([], [], [], [], [], []) :- !.
	write_db([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5], [P6|T6]) :-
		write(P1, ";", P2, ";", P3, ";",P4, ";",P5, ";",P6), nl,
		write_db(T1, T2, T3, T4, T5, T6).


	read_rows() :-not(eof(datafile)),
					readln(Line),
					front_string(Line, F1_STR, Tail1), 
					front_string(Tail1, F2_STR, Tail2), str_real(F2_STR, F2_real),
					front_string(Tail2, F3_STR, Tail3), 
					front_string(Tail3, F4_STR, Tail4), 
					front_string(Tail4, F5_STR, Tail5), 
					front_string(Tail5, F6_STR, _), str_real(F6_STR, F6_real),
					insert_into_database(F1_STR, F2_real, F3_STR, F4_STR, F5_STR, F6_real), !, read_rows();
					
					not(eof(datafile)), !,
					write(" ********** "), nl,
					write(" * READING ERROR! * "), nl,
					write(" * REMAINING DATA WAS NOT READ! * "), nl,
					write(" * SOME MATERIALS ADDED! * "), nl,
					write(" ********** "), nl; !.