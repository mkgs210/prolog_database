DATABASE
	db_detail (string,real,string,integer,integer,integer) /*Brand, Engine hp(horsepower), Artikul, width mm, thickness mm, weight g(grams)*/

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
	add_detail
	retquation4
	findquation4
	find(integer)
	print_db
	print_db(strings,reals,strings,integers,integers,integers)
	print_db2
	print_db2(strings,reals,strings,integers,integers,integers)
	find_detail(symbol)
	find_detail_name(symbol)
	find_os(symbol)
	find_name(symbol)
	dely
	read_rows()
	front_string(string, string, string)
	insert_into_database(string,real,string,integer,integer,integer)

GOAL
	makewindow(1, 30, -3, "BD valve ", 0,0,25,80, 1, -1,"\218\191\192\217\196\179"),
	menu.

CLAUSES
	menu:- clearwindow,
						write("1 - clean and create new database"),nl,
						write("2 - read database from file"),nl,
						write("3 - add detail"),nl,
						write("4 - find detail"),nl,
						write("5 - delete detail"),nl,
						write("6 - edit detail"),nl,
						write("7 - save in file"),nl,
						write("8 - see all database"), nl,
						write("9 - exit"), nl, readchar(N), reaction(N).


	reaction('1'):-deldb,write("DB was clear"),dely,menu.

	reaction('2'):-clearwindow, write("Enter name of file "),
		readln(Filename), exists(Filename),
		openread(datafile, Filename), readdevice(datafile), deldb, read_rows(),
		closefile(datafile), readdevice(keyboard),
									dely,menu.
	reaction('3'):-add_detail, write("detail added"),nl, dely, menu.

	reaction('4'):-clearwindow, findquation4, menu.

	reaction('5'):-clearwindow, retquation4,write("record removed"),nl, dely, menu.
	reaction('5'):-write("No such entry exists! "), dely, menu.
	
	reaction('6'):-clearwindow, retquation4, add_detail,write("detail edited"),nl, dely, menu.
	reaction('6'):-write("No such entry exists! "), dely, menu.
	
	reaction('7'):-write("Enter name of file "), readln(Fname),Fname<>"", openwrite(datafile, Fname), writedevice(datafile),
	print_db(), closefile(datafile), writedevice(screen), dely, menu.

	reaction('8'):- print_db2(), dely, menu.
	reaction('9').

	reaction(_):-write("Error :( "), dely, menu.
	
	
	find(1):-clearwindow, write("Enter Brand of detail "), readln(Brand),
						find_detail_name(Brand), find_name(Brand).

	find(1):-write("No such detail in database!"), dely.

	find(2):-clearwindow, write("Enter Artikul of detail "), readln(Artikul),
						find_detail(Artikul), find_os(Artikul).

	find(2):-write("No such detail in database!"), dely.

	find(_):-write("Error "), dely.

	find_detail_name(Brand):-db_detail(Brand,HP,Artikul,Width,Thickness,Weight),write("\nDetail: "),
						nl, write("Brand: ",Brand),
						nl, write("Engine: ",HP," hp;"),
						nl, write("Artikul: ",Artikul," OS;"),
						nl, write("Width: ",Width," mm;"),
						nl, write("Thickness: ",Thickness," mm;"),
						nl, write("Weight: ",Weight," g;"),
				 		dely, fail.
	find_detail_name(_).
	
	find_detail(Artikul):-db_detail(Brand,HP,Artikul,Width,Thickness, Weight),write("\nDetail: "),
						nl, write("Brand: ",Brand),
						nl, write("Engine: ",HP," hp;"),
						nl, write("Artikul: ",Artikul," OS;"),
						nl, write("Width: ",Width," mm;"),
						nl, write("Thickness: ",Thickness," mm;"),
						nl, write("Weight: ",Weight," g;"),
				 		dely, fail.

	find_detail(_).
 
	find_name(Brand):-db_detail(Brand,_,_,_,_,_).
	find_os(Artikul):-db_detail(_,_,Artikul,_,_,_).


	retquation4:-write("Enter Brand of detail "), nl, readln(Brand),
					retract(db_detail(Brand,_,_,_,_,_)).


	dely:-nl, nl, write("Any key to continue"), nl, readchar(_).
	
	
	print_db2() :-%write("DB2_1"),
		findall(P1, db_detail(P1, _, _, _,_,_), P1s),
		findall(P2, db_detail(_, P2, _, _,_,_), P2s),
		findall(P3, db_detail(_, _, P3, _,_,_), P3s),
		findall(P4, db_detail(_, _, _, P4,_,_), P4s),
		findall(P5, db_detail(_, _, _, _,P5,_), P5s),
		findall(P6, db_detail(_, _, _, _,_,P6), P6s),
		print_db(P1s, P2s, P3s, P4s, P5s, P6s);
		writedevice(screen).

	print_db2([], [], [], [], [], []) :- !.
	print_db2([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5], [P6|T6]) :-
		%write("DB2_2"),
		write("\nBrand: ", P1, ";\nEngine: ", P2, " hp;\nArtikul: ", P3, ";\nWidth: ",P4, " mm;\nThickness: ",P5, " mm;\nWeight: ", P6, " g."), nl,
		print_db2(T1, T2, T3, T4, T5, T6).


	print_db() :-
		findall(P1, db_detail(P1, _, _, _,_,_), P1s),
		findall(P2, db_detail(_, P2, _, _,_,_), P2s),
		findall(P3, db_detail(_, _, P3, _,_,_), P3s),
		findall(P4, db_detail(_, _, _, P4,_,_), P4s),
		findall(P5, db_detail(_, _, _, _,P5,_), P5s),
		findall(P6, db_detail(_, _, _, _,_,P6), P6s),
		print_db2(P1s, P2s, P3s, P4s, P5s, P6s);
		writedevice(screen).

	print_db([], [], [], [], [], []) :- !.
	print_db([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5], [P6|T6]) :-
		write(P1, ";", P2, ";", P3, ";",P4, ";",P5, ";",P6), nl,
		print_db(T1, T2, T3, T4, T5, T6).


	read_rows() :-not(eof(datafile)),
					readln(Line),
					front_string(Line, F1_STR, Tail1), %str_int(F1_STR, F1),
					front_string(Tail1, F2_STR, Tail2), str_real(F2_STR, F2_real),
					front_string(Tail2, F3_STR, Tail3), %str_int(F3_STR, F3),
					front_string(Tail3, F4_STR, Tail4), str_int(F4_STR, F4),
					front_string(Tail4, F5_STR, Tail5), str_int(F5_STR, F5),
					front_string(Tail5, F6_STR, _), str_int(F6_STR, F6),
					insert_into_database(F1_STR, F2_real, F3_STR, F4,F5, F6), !, read_rows();
					
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

	insert_into_database(F1, F2, F3, F4,F5, F6) :-assertz(db_detail(F1, F2, F3, F4,F5, F6)).

	exists(Filename) :-existfile(Filename), !.
	

	deldb:-retract(db_detail (_,_,_,_,_, _)), fail.
	deldb.

	add_detail:-clearwindow,write("Enter Brand: "), nl, readln(Brand),
							write("Enter Engine horsepower: "),nl, readreal(HP),HP>0,
							write("Enter Artikul: "),nl, readln(Artikul),
							write("Enter Width mm: "),nl, readint(Width),Width>0,
							write("Enter Thickness mm: "),nl, readint(Thickness),Thickness>0,
							write("Enter Weight grams: "),nl, readint(Weight),Weight>0,
							assertz(db_detail(Brand,HP,Artikul,Width,Thickness,Weight)).
	
	findquation4:-clearwindow, write("1 - find detail by Brand "),nl,
									 		write("2 - find record by Artikul "),nl, readint(N), find(N).