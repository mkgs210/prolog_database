DATABASE
	db_phone (string,integer,string,integer,real) /*MODEL NAME, COASTS, SYSTEM, RAM, CPU GHZ*/

DOMAINS
	file = datafile
	integers = integer*
	strings = string*
	reals = real*

PREDICATES
	menu
	reaction(char)
	exists(string)
	deldb
	add_phone
	retquation4
	findquation4
	find(integer)
	print_db
	print_db(strings,integers,strings,integers,reals)
	print_db2
	print_db2(strings,integers,strings,integers,reals)
	find_phone(symbol)
	find_phone_name(symbol)
	find_os(symbol)
	find_name(symbol)
	dely
	read_rows()
	front_string(string, string, string)
	insert_into_database(string,integer,string,integer,real)

GOAL
	makewindow(1, 10, 3, "BD phone ", 3, 10, 19, 60, 1, -1,"\218\191\192\217\196\179"),
	menu.

CLAUSES
	menu:- clearwindow,
						write("1 - clean and create new database"),nl,
						write("2 - read database from file"),nl,
						write("3 - add phone"),nl,
						write("4 - find phone"),nl,
						write("5 - delete phone"),nl,
						write("6 - edit phone"),nl,
						write("7 - save in file"),nl,
						write("8 - see all database"), nl,
						write("9 - exit"), nl, readchar(N), reaction(N).


	reaction('1'):-deldb,write("DB was clear"),dely,menu.

	reaction('2'):-clearwindow, write("Enter name of file "),
		readln(Filename), exists(Filename),
		openread(datafile, Filename), readdevice(datafile), deldb, read_rows(),
		closefile(datafile), readdevice(keyboard),
									dely,menu.
	reaction('3'):-add_phone, write("phone added"),nl, dely, menu.

	reaction('4'):-clearwindow, findquation4, menu.

	reaction('5'):-clearwindow, retquation4,write("record removed"),nl, dely, menu.
	reaction('5'):-write("No such entry exists! "), dely, menu.
	
	reaction('6'):-clearwindow, retquation4, add_phone,write("phone edited"),nl, dely, menu.
	reaction('6'):-write("No such entry exists! "), dely, menu.
	
	reaction('7'):-write("Enter name of file "), readln(Fname),Fname<>"", openwrite(datafile, Fname), writedevice(datafile),
	print_db(), closefile(datafile), writedevice(screen), dely, menu.

	reaction('8'):- print_db2(), dely, menu.
	reaction('9').

	reaction(_):-write("Error :( "), dely, menu.
	print_db2() :-%write("DB2_1"),
		findall(P1, db_phone(P1, _, _, _,_), P1s),
		findall(P2, db_phone(_, P2, _, _,_), P2s),
		findall(P3, db_phone(_, _, P3, _,_), P3s),
		findall(P4, db_phone(_, _, _, P4,_), P4s),
		findall(P5, db_phone(_, _, _, _,P5), P5s),
		print_db2(P1s, P2s, P3s, P4s, P5s);
		writedevice(screen).

	print_db2([], [], [], [], []) :- !.
	print_db2([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5]) :-/*MODEL NAME, COAST, SYSTEM, RAM, CPU GHZ*/
		%write("DB2_2"),
		write("\nMODEL NAME: ", P1, ";\nCOAST ", P2, " RUB;\nSYSTEM ", P3, " OS;\nRAM ",P4, " GB;\nCPU ",P5, " GHZ."), nl,
		print_db2(T1, T2, T3, T4, T5).


	print_db() :-
		findall(P1, db_phone(P1, _, _, _,_), P1s),
		findall(P2, db_phone(_, P2, _, _,_), P2s),
		findall(P3, db_phone(_, _, P3, _,_), P3s),
		findall(P4, db_phone(_, _, _, P4,_), P4s),
		findall(P5, db_phone(_, _, _, _,P5), P5s),
		print_db(P1s, P2s, P3s, P4s, P5s);
		writedevice(screen).

	print_db([], [], [], [], []) :- !.
	print_db([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5]) :-
		write(P1, ";", P2, ";", P3, ";",P4, ";",P5), nl,
		print_db(T1, T2, T3, T4, T5).


	read_rows() :-not(eof(datafile)),/*string,integer,string,integer,integer*/
					readln(Line),
					front_string(Line, F1_STR, Tail1), %str_int(F1_STR, F1),
					front_string(Tail1, F2_STR, Tail2), str_int(F2_STR, F2),
					front_string(Tail2, F3_STR, Tail3), %str_int(F3_STR, F3),
					front_string(Tail3, F4_STR, Tail4), str_int(F4_STR, F4),
					front_string(Tail4, F5_STR, _), str_real(F5_STR, F5_real),
					insert_into_database(F1_STR, F2, F3_STR, F4,F5_real), !, read_rows();
					
					not(eof(datafile)), !,
					write(" ********** "), nl,
					write(" * READING ERROR! * "), nl,
					write(" * REMAINING DATA WAS NOT READ! * "), nl,
					write(" * SOME MATERIALS ADDED! * "), nl,
					write(" ********** "), nl; !.

	front_string("", "", "") :- !.
	front_string(Line, Param, Tail) :-frontchar(Line, LineH, LineT), 
									LineH = ';', !, 
									Param = "", Tail = LineT;
									
									frontchar(Line, LineH, LineT), 
									LineH <> ';', !, 
									front_string(LineT, T, Tail), 
									str_char(LineHS, LineH),	
									concat(LineHS, T, Param).

	insert_into_database(F1, F2, F3, F4,F5) :-assertz(db_phone(F1, F2, F3, F4,F5)).

	exists(Filename) :-existfile(Filename), !.
	

	deldb:-retract(db_phone (_,_,_,_,_)), fail.
	deldb.


	add_phone:-clearwindow,write("Enter MODEL NAME "), nl, readln(NAME),/*MODEL NAME, COAST RUB, SYSTEM, RAM, CPU GHZ*/
							write("Enter COAST RUB: "),nl, readint(COASTS),COASTS>0,
							write("Enter SYSTEM OS: "),nl, readln(SYSTEM),
							write("Enter RAM GB: "),nl, readint(RAM),RAM>0,
							write("Enter CPU GHZ: "),nl, readreal(CPU),CPU>0,
							assertz(db_phone(NAME,COASTS,SYSTEM,RAM,CPU)).
	



	findquation4:-clearwindow, write("1 - find phone by MODEL NAME "),nl,
									 		write("2 - find record by SYSTEM OS "),nl, readint(N), find(N).
											

	find(1):-clearwindow, write("Enter NAME of phone "), readln(Name),
						find_phone_name(Name), find_name(Name).

	find(1):-write("No such phone in database!"), dely.

	find(2):-clearwindow, write("Enter SYSTEM OS of phone "), readln(Name),
						find_phone(Name), find_os(Name).

	find(2):-write("No such phone in database!"), dely.

	find(_):-write("Error "), dely.

	find_phone_name(Name):-db_phone(Name,COASTS,SYSTEM,RAM,CPU),write("\nPhone: "),
						nl, write("NAME ",NAME),
						nl, write("COAST ",COASTS," RUB;"),
						nl, write("SYSTEM ",SYSTEM," OS;"),
						nl, write("RAM ",RAM," GB;"),
						nl, write("CPU ",CPU," GHZ;"),
				 		dely, fail.
	find_phone_name(_).
	
	find_phone(SYSTEM):-db_phone(NAME,COASTS,SYSTEM,RAM,CPU),write("\nPhone: "),
						nl, write("NAME ",NAME),
						nl, write("COAST ",COASTS," RUB;"),
						nl, write("SYSTEM ",SYSTEM," OS;"),
						nl, write("RAM ",RAM," GB;"),
						nl, write("CPU ",CPU," GHZ;"),
				 		dely, fail.

	find_phone(_).
 
	find_name(Name):-db_phone(Name,_,_,_,_).
	find_os(SYSTEM):-db_phone(_,_,SYSTEM,_,_).


	retquation4:-write("Enter NAME of phone "), nl, readln(NAME),
					retract(db_phone(NAME,_,_,_,_)).


	dely:-nl, nl, write("Any key to continue"), nl, readchar(_).
