%FILE: dotsville.pl
%Date: Due October 28,2020       
%---------------------------------

%=================================
%Description of Dotsville
% The dotsville is made of 24 cells. Which is 4 ROWS and 6 
%----The Table-----
%4 
%3 
%2 
%1 
%0 - - - - - - 
%  1 2 3 4 5 6
%The Table:
%dot(cell(0,1), color(table)).
%dot(cell(0,2), color(table)).
%dot(cell(0,3), color(table)).
%dot(cell(0,4), color(table)).
%dot(cell(0,5), color(table)).
%dot(cell(0,6), color(table)).
%=============================
%---------------------------------------------------------
%Program to make the table and a call to actually make it
make_table :-
    assert(dot( cell(0,1),color(table))),
	assert(dot( cell(0,2),color(table))),
	assert(dot( cell(0,3),color(table))),
	assert(dot( cell(0,4),color(table))),
	assert(dot( cell(0,5),color(table))),
	assert(dot( cell(0,6),color(table))).
:- make_table.
%---------------------------------------------------------
%Display the world, one row at a time, from the top, including the underworld
display_world :-
   display_row(4),
   display_row(3),
   display_row(2),
   display_row(1),
   display_row(0).

display_row(R) :-
  display_cell(R,1), write(' '),
  display_cell(R,2), write(' '),
  display_cell(R,3), write(' '),
  display_cell(R,4), write(' '),
  display_cell(R,5), write(' '),
  display_cell(R,6), write(' '),
  nl.
  
display_cell(R,C) :-
   dot(cell(R,C),color(Color)),
   color_code(Color,Code),
   write(Code).
display_cell(_,_) :-
   write(' ').
%----------------------------------------------------------
%Variables to be used to print in the cell table 
color_code(red,   'R').
color_code(blue,  'B').
color_code(yellow,'Y').
color_code(orange,'O').
color_code(purple,'P').
color_code(green, 'G').
color_code(table, '-').
%----------------------------------------------------------
%==========================================================
%The add dot predicate (with some integrity!)

add_dot(cell(R,_),_) :- not(member(R,[1,2,3,4])),
   write('### Cannot add dot: row position is invalid.'),nl.
%---To inform that you can't add the dot at the selected ROW.---

add_dot(cell(_,C),_) :- not(member(C,[1,2,3,4,5,6])),
   write('### Cannot add dot: column position is invalid.'),nl.
%---To inform that you can't add a dot on the selected COLUMN.---

add_dot(cell(R,C),_) :- dot(cell(R,C),_),
   write('### Cannot add dot: cell is already filled.'),nl.
%---To inform that you can't place a DOT because its already filled.---

add_dot(cell(R,C),_) :- SubR is R-1, not(dot(cell(SubR,C),_)),
   write('### Cannot add dot: dots cannot float.'),nl.
%---To inform you that you can't place a DOT there cause it doesn't automatically float--
 
add_dot(_,color(Color)) :- not(member(Color,[red,blue,yellow,orange,purple,green])),
   write('### Cannot add dot: invalid color.'),nl.
%---To ensure that the color mentioned in the list is only used in the dotsville---

add_dot(cell(R,C),color(Color)) :-
  assert(dot(cell(R,C),color(Color))).
%---Ensures to add the users selected colors at the particular cell--
%--------------------------------------------------------------
%==============================================================
%========================DEMOS=================================
%------------------------DEMO 1: Display the empty-------------
demo1 :-
   display_world,
   listing(dot).
%------------------------DEMO 2: Display the world with diff----
%------------------------colored dots on the table--------------
demo2 :-
   add_dot(cell(1,1),color(red)),
   add_dot(cell(1,2),color(blue)),
   add_dot(cell(1,3),color(yellow)),
   add_dot(cell(1,4),color(green)),
   add_dot(cell(1,5),color(purple)),
   add_dot(cell(1,6),color(orange)),
   display_world,
   listing(dot).
%----------------------------------------------------------------
%Clears the world, one row at a time
clear_world :-
  clear_cell(_,_),fail.
clear_world :-
  make_table.
  
clear_cell(_,_) :-
  retract(dot(cell(_,_),_)).
clear_cell(_,_).
%-----------------------------------------------------------------
%---------------------------DEMO 3: demonstrate that the clear world
%---------------------------command works-------------------------
demo3 :-
  clear_world,
  demo2,
  clear_world,
  demo1.
%-------------------------------------------------------------------
%--------------------------DEMO 4: demonstrate that we cannot place-
%-----a dot in a full postion---------------------------------------
demo4 :-
  clear_world,
  add_dot(cell(1,1),color(red)),
  add_dot(cell(1,1),color(blue)),
  add_dot(cell(1,2),color(blue)),
  display_world.
%----------------------------------------------------------------------
%--------------DEMO 5: demonstrating that the dots cannot float--------
demo5 :-
   clear_world,
   add_dot(cell(1,1),color(red)),
   add_dot(cell(1,2),color(blue)),
   add_dot(cell(4,3),color(yellow)),
   add_dot(cell(3,4),color(green)),
   add_dot(cell(2,5),color(purple)),
   add_dot(cell(1,6),color(orange)),
   display_world.
%=========================================================================
%=========================PART 2 =========================================
state1 :-
  clear_world,
  add_dot(cell(1,1),color(blue)),
  add_dot(cell(2,1),color(blue)),
  add_dot(cell(1,3),color(red)),
  add_dot(cell(2,3),color(yellow)),
  add_dot(cell(3,3),color(orange)),
  display_world.

state2 :-
  clear_world,
  add_dot(cell(1,1),color(red)),
  add_dot(cell(1,2),color(blue)),
  add_dot(cell(2,2),color(red)),
  display_world.

state3 :-
  clear_world,
  add_dot(cell(1,2),color(yellow)),
  add_dot(cell(1,4),color(red)),
  add_dot(cell(2,4),color(red)),
  add_dot(cell(1,6),color(blue)),
  add_dot(cell(2,6),color(green)),
  add_dot(cell(3,6),color(blue)),
  add_dot(cell(4,6),color(green)),
  display_world.
% ------------------------------------------------------------------------- Task #1 COMPLETED
% exists_dot_of_color(Color)
% --- succeeds if there is a dot of color Color

% --> Task 1: Define the method here
exists_dot_of_color(Color) :- 
dot(cell(_,_),color(Color)).

demo__exists_dot_of_color :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_of_color'), nl,
  state3,
  exists_dot_of_color(blue),
  write('>>> there is a blue dot'),nl,
  not(exists_dot_of_color(purple)),
  write('>>> there is no purple dot'),nl.

% ------------------------------------------------------------------------- Task #2 COMPLETED
% exists_dot_of_color_on_table(Color)
% --- succeeds if there is a dot of color Color

% --> Task 2: Define the method here
exists_dot_of_color_on_table(Color) :-
dot(cell(1,_),color(Color)).

demo__exists_dot_of_color_on_table :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_of_color_on_table'), nl,
  state3,
  exists_dot_of_color_on_table(blue),
  write('>>> there is a blue dot on the table'),nl,
  not(exists_dot_of_color_on_table(green)),
  write('>>> there is no green dot on the table'),nl.
  
% ------------------------------------------------------------------------- Task #3 COMPLETED
% exists_dot_left_of(Color1,Color2)
% --- succeeds if there is a dot of Color1 to the left of a dot of Color2

% --> Task 3: Define the method here
exists_dot_left_of(Color1,Color2) :-
dot(cell(_,ColA),color(Color1)),
dot(cell(_,ColB),color(Color2)),
ColA < ColB.

demo__exists_dot_left_of :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_left_of'), nl,
  state3,
  exists_dot_left_of(red,blue),
  write('>>> there is a red dot to the left of a blue dot'),nl,
  not(exists_dot_left_of(blue,red)),
  write('>>> there is not a blue dot to the left of a red dot.'),nl.
  
% ------------------------------------------------------------------------- Task #4 COMPLETED
% exists_dot_right_of(Color1,Color2)
% --- succeeds if there is a dot of Color1 to the right of a dot of Color2

% --> Task 4: Define the method here
exists_dot_right_of(Color1,Color2):-
dot(cell(_,ColA),color(Color1)),
dot(cell(_,ColB),color(Color2)),
ColB < ColA.

demo__exists_dot_right_of :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_right_of'), nl,
  state3,
  exists_dot_right_of(blue,red),
  write('>>> there is a blue dot to the right of a red dot'),nl,
  not(exists_dot_right_of(red,blue)),
  write('>>> there is not a red dot to the right of a blue dot.'),nl.
  
% ------------------------------------------------------------------------- Task #5 COMPLETED
% list_dots_of_color(Color)
% --- lists all of the dots of color Color

% --> Task 5: Just study this code, and carefully enter it into your file

list_dots_of_color(Color) :-
  dot(cell(R,C),color(Color)),
  write(dot(cell(R,C),color(Color))), nl,
  fail.
list_dots_of_color(_).

demo__list_dots_of_color :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  list_dots_of_color'), nl,
  state3,
  write('>>> these are the blue dots ...'),nl,
  list_dots_of_color(blue),
  write('>>> these are the red dots ...'),nl,
  list_dots_of_color(red),
  write('>>> these are the purple dots ...'),nl,
  list_dots_of_color(purple).
  
% -------------------------------------------------------------------------  Task #6 COMPLETED!!!
% list_dots_in_column(Column)
% --- lists all of the dots in column Column

% --> Task 6: Define the method here
list_dots_in_column(Column):-
dot(cell(R,Column),color(Color)),
Color \= '-',
R \= 0,
write(dot(cell(R,Column),color(Color))),nl,
fail.
list_dots_in_column(_).

demo__list_dots_in_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  list_dots_in_column'), nl,
  state3,
  write('>>> these are the dots in column 1 ...'),nl,
  list_dots_in_column(1),
  write('>>> these are the dots in column 2 ...'),nl,
  list_dots_in_column(2),
  write('>>> these are the dots in column 3 ...'),nl,
  list_dots_in_column(3),
  write('>>> these are the dots in column 4 ...'),nl,
  list_dots_in_column(4),
  write('>>> these are the dots in column 5 ...'),nl,
  list_dots_in_column(5),
  write('>>> these are the dots in column 6 ...'),nl,
  list_dots_in_column(6).
  
% -------------------------------------------------------------------------  Task #7 COMPLETED.
% add_dot_to_column(Column,Color)
% --- add a dot of the given Color to the given Column

% --> Task 7: Just study this code, and carefully enter it into your file

add_dot_to_column(Column,Color) :-
  not(dot(cell(1,Column),_)),
  add_dot(cell(1,Column),color(Color)).
add_dot_to_column(Column,Color) :-
  not(dot(cell(2,Column),_)),
  add_dot(cell(2,Column),color(Color)).
add_dot_to_column(Column,Color) :-
  not(dot(cell(3,Column),_)),
  add_dot(cell(3,Column),color(Color)).
add_dot_to_column(Column,Color) :-
  not(dot(cell(4,Column),_)),
  add_dot(cell(4,Column),color(Color)).
add_dot_to_column(Column,_) :-
  write('### no room to add a dot to column '),write(Column),nl.

demo__add_dot_to_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  add_dot_to_column'), nl,
  state3,
  add_dot_to_column(2,red),
  add_dot_to_column(4,purple),
  add_dot_to_column(6,yellow),
  write('>>> after adding red and purple dots to columns 2 and 4:  '), nl,
  display_world.
  
%------------------------------------------------------------------------ Task #8 COMPLETED
% add_random_dot(Row,Col)
% --- add a randomly colored dot in row Row and column Col

% --> Task 8: Define the method here
add_random_dot(Row,Col):-
pick([red,blue,yellow,green,orange,purple],Color),
add_dot(cell(Row,Col),color(Color)).

demo__add_random_dot :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  add_random_dot'), nl,
  state3,
  add_random_dot(1,1),
  add_random_dot(2,1),
  add_random_dot(3,1),
  add_random_dot(4,1),
  add_random_dot(1,3),
  add_random_dot(2,3),
  add_random_dot(3,3),
  add_random_dot(4,3),
  write('>>> the world after filling columns 1 and 3 with random dots ...'),nl,
  display_world.
% ------------------------------------------------------------------------- Task #9 COMPLETED
% remove_dot_from_column(Column)
% --- succeeds if there is at least one dot in a column by removing top dot

% --> Task 9: Just study this code, and carefully enter it into your file

remove_dot_from_column(Column) :-
  dot(cell(4,Column),_), retract(dot(cell(4,Column),_) ).
remove_dot_from_column(Column) :-
  dot(cell(3,Column),_), retract(dot(cell(3,Column),_) ).
remove_dot_from_column(Column) :-
  dot(cell(2,Column),_), retract(dot(cell(2,Column),_) ).
remove_dot_from_column(Column) :-
  dot(cell(1,Column),_), retract(dot(cell(1,Column),_) ).
remove_dot_from_column(Column) :-
  write('### There is no dot in column '), write(Column), write(' to remove.'), nl.

demo__remove_dot_from_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  remove_dot_from_column'), nl,
  state3,
  remove_dot_from_column(1),
  remove_dot_from_column(2),
  remove_dot_from_column(3),
  remove_dot_from_column(4),
  remove_dot_from_column(5),
  remove_dot_from_column(6),
  write('>>> after removing a dot from each nonempty column ...'),nl,
  display_world.
  
% ------------------------------------------------------------------------- Task #10 50% DONE
% count_dots_in_column(Column,Count)
% --- returns the number of dots in the given column

% --> Task 10: Define the method here
count_dots_in_column(Column,Count) :-
count(dot(cell(_,Column),color(_)),[red,blue,yellow,green,orange,purple],Count).

demo__count_dots_in_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  count_dots_in_column'), nl,
  state3,
  count_dots_in_column(1,Count1),
  write('>>> number of dots in column 1:  '), write(Count1), nl,
  count_dots_in_column(2,Count2),
  write('>>> number of dots in column 2:  '), write(Count2), nl,
  count_dots_in_column(3,Count3),
  write('>>> number of dots in column 3:  '), write(Count3), nl,
  count_dots_in_column(4,Count4),
  write('>>> number of dots in column 4:  '), write(Count4), nl,
  count_dots_in_column(5,Count5),
  write('>>> number of dots in column 5:  '), write(Count5), nl,
  count_dots_in_column(6,Count6),
  write('>>> number of dots in column 6:  '), write(Count6), nl.
 % ------------------------------------------------------------------------- Task #11
% count_dots(Count)
% --- returns the number of dots in the world

% --> Task 11: Define the method here
%count_dots(Count):-
%count(
demo__count_dots :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  count_dots'), nl,
  state3,
  count_dots(Count),
  write('>>> number of dots in the world:  '), write(Count), nl.