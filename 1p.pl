%---------------------------------
%File: 1p.pl                      |
%Type: Prolog source code         |
%Line: List processing library    |
%Date: October 9,2020 due         |
%---------------------------------

%Writing elements of a list in order and in reverse order 
%--------------------------------------------------------

%write_list(List) :: Write the elements of the list in order,
%one per line 
%================Write_List Works========================
write_list([]).
write_list([H|T]) :-
  write(H),nl,
  write_list(T).
  
%--------------------------------------------------------

%write_list_reversed(List) :: Write the elemetns of the list in
% reverse order, one per line 
%================write_list_reversed=====================
write_list_reversed([]).
write_list_reversed([H|T]) :-
  write_list_reversed(T),
  write(H),nl.
  
%-------------------------Four explicit references-------
%=======================first Works======================
%first(List,First) :: Presuming the list is nonempty reference its 
%first element
first( [First|_], First).
%=======================rest Works=======================
%rest(List,Rest) :: Presuming the is nonempty, reference the
%list except for the first element
rest( [_|Rest], Rest).
%===============================last Works===============
%last(List,Last) :: Presuming the list is nonempty, reference the
%last element on the list 

last( [oneElement], oneElement).
last( [_|Rest], Last) :- last(Rest, Last).
%=========================NTH Works======================
%nth(N,List,NthElement) :: Presuming the is nonempty, reference the nth element of the list. 

nth(0, [H|_], H).
nth(N, [_|T], NthElement) :- NM1 is N-1, nth(NM1,T,NthElement).

%========================Homework Questions PART 1==============
%==================item works============================
%------------------------1 item--------------------------
%item(N,List,Item) :: Goes to the indicated index and prints it. 
item(N,[H|_],H) :- N = 0.
item(N,[_|T],E) :- N > 0, K is N - 1, item(K,T,E).

%=========================member works===================
%------------------------2 member------------------------
%member(Element,List) :: Interactively prints the list. 
member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

%=========================Count Works=====================
%------------------------3 count -------------------------
%count(Element,List,Count) :: Counts how many elements are in the list
count(_,[],0).
count(Element,[Element|Rest],Count) :-
  count(Element,Rest,RestCount),
  Count is RestCount + 1.
count(Element,[_|Rest],Count) :-
  count(Element,Rest,Count).
%=======================Append Works======================
%-----------------------4 append--------------------------
%append(L1,L2,Result) :: Adds element or list to the end of the established list.
append1([],L,L).
append1([H|T1],L2,[H|T3]) :- append1(T1,L2,T3).

%append1(L1,L2,L3,Result) :: Adds three list into one list.
append1(L1,L2,L3,Result) :-
  append1(L1,L2,L12),append(L12,L3,Result).
  
%append(L1,L2,L3,L4,Result) :: Adds a list to the three established list.
append1(L1,L2,L3,L4,Result) :-
  append1(L1,L2,L3,L123),append1(L123,L4,Result).
  
%========================Remove Works============================
%--------------------5 remove------------------------------------
%remove(E,L,Result) :: Removes an element from the list 
remove(_,[],[]).
remove(First,[First|Rest],Rest).
remove(Element,[First|Rest].[First|RestLessElement]) :-
  remove(Element,Rest,RestLessElement).
%=======================replace Works============================
%--------------------6 replace-----------------------------------
%replace(Position,Value,InList,OutList) :: Replaces a value at a certain index point
replace(0,Object,[_|T],[Object|T]).
replace(ListPosition,Object,[H|T1],[H|T2]) :-
  K is ListPosition - 1,
  replace(K,Object,T1,T2).
  
%=======================Make list WORKS=========================
%-------------------7 make list---------------------------------
%make_list(Size,Element,List) :: Makes a list based on how many indexes and a value provided. 
make_list(0,_,[]).
make_list(Length,Element,[Element|Rest]) :-
  K is Length - 1,
  make_list(K,Element,Rest).
%=========================Reverse WORKS=========================
%------------------8 reverse------------------------------------
%reverse(L,R) :: Makes the given list to be 
reverse([],[]).
reverse([H|T],R) :- 
  reverse(T,Rev),add_last(H,Rev,R).
%=======================Add first WORKS=========================
%------------------9 add first----------------------------------
%add_first(E,L,R) :: Adds the element in front of the list.
add_first(X,L,[X|L]).

%======================Add Last works===========================
%-----------------10 add last-----------------------------------
%add_last(E,L,R) :: Adds the elemnt at the end of the list
add_last(X,[],[X]).
add_last(X,[H|T],[H|TX]) :- add_last(X,T,TX).

%======================Pick WORKS===============================
%-----------------11 pick---------------------------------------
%pick(List,Item) :: Checks to see if the element is in the list or not. 
pick(L,Item) :-
length(L,Length),
random(0,Length,RN),
item(RN,L,Item).
%==========================take has syntax issues===============
%-----------------12 take---------------------------------------
%take(InList,OutElement,OutList):: Takes out the element in the list
take(List,Element,Rest) :-
  pick(List,Element),
  remove(Element,List,Rest).

%=======================iota has issues=========================
%-----------------13 iota---------------------------------------
%iota(K,IotaK) :: Takes the number in the list and decreases it by 1

iota(0,[]).
iota(N,IotaN) :-
 K is N - 1, 
 iota(K,IotaK),
 add_last(N,IotaK,IotaN).
%==========================Sum Works============================
%-----------------14 sum----------------------------------------
%sum(ListOfNumbers,Sum) :: Adds the rest together 

sum([],0).
sum([Head|Tail],Sum) :-
  sum(Tail,SumOfTail),
  Sum is Head + SumOfTail.
%=========================Product Works=========================
%-----------------15 product------------------------------------
%product(ListOfNumbers,Product):: Multiply the list of numbers in the list.
product([],1).
product([Head|Tail],Product) :-
  product(Tail,ProductOfTail),
  Product is Head * ProductOfTail.
%======================factorial works==========================
%-----------------16 factorial----------------------------------
%factorial(N,F) :: Takes the indicated number and uses it as an exponent then decrease after each use by 1 until 0
factorial(N,Nfactorial) :-
iota(N,IotaN),
product(IotaN,Nfactorial).
%===============================================================
%=================Actual QUESTIONS==============================
%=================1 Minimum Works===============================
%min[NumericList,MinimumNumber] :: find the smallest number in the list

min_list([NumericList|MinimumNumber], MinNum) :-
     min_list(MinimumNumber,NumericList,MinNum).
	 
min_list([], MinNum,MinNum).
min_list([NumericList|MinimumNumber], MinNum0,MinNum) :-
    MinNum1 is min(NumericList, MinNum0),
	min_list(MinimumNumber, MinNum1, MinNum).
%================================================================
%=====================2 Maximum Works============================
%max[NumericList,MinimumNumber] :: Find the largest number in a list.
max_List([NumericList],NumericList).
max_List([NumericList, Y|Rest],MinimumNumber) :-
 max_List([Y | Rest], Rest_Max), max(NumericList,Rest_Max,MinimumNumber).
 
 max(NumericList,Y,NumericList) :- NumericList >= Y.
 max(NumericList,Y,Y) :- NumericList < Y.
 
%=================================================================
%=======================3 sort ascending==========================
%sort_inc[UnorderedNumericList,OrderedNumericList] :: order low to high
sort_inc([],[]).
sort_inc([X],[X]).
sort_inc([H,P|T],ListSorted):-
    split_sort2(P,[H|T],UnorderedNumericList,OrderedNumericList),
	sort_inc(UnorderedNumericList,Less),
	sort_inc(OrderedNumericList,Greater),
	append(Less,[P|Greater],ListSorted).

split_sort2(_,[],[],[]).
split_sort2(P,[X|T],[X|UnorderedNumericList],OrderedNumericList):-
     X >= P,split_sort2(P,T,UnorderedNumericList,OrderedNumericList).
split_sort2(P,[X|T],UnorderedNumericList,[X|OrderedNumericList]):-
     X < P,split_sort2(P,T,UnorderedNumericList,OrderedNumericList).
%=======================4 sort descending=========================
%%sort_des[UnorderedNumericList,OrderedNumericList] :: order low to high
sort_des([],[]).
sort_des([X], [X]).
sort_des([Head, Pivot|Tail],Sorted):-
         split_sort(Pivot,[Head|Tail],UnorderedNumericList,OrderedNumericList),
		 sort_des(UnorderedNumericList,LessSorted),
		 sort_des(OrderedNumericList,GreaterSorted),
		 append(LessSorted,[Pivot|GreaterSorted],Sorted).
		 
split_sort(_,[],[],[]).
split_sort(Pivot,[X|Tail],[X|UnorderedNumericList],OrderedNumericList):-
     X =< Pivot,split_sort(Pivot,Tail,UnorderedNumericList,OrderedNumericList).
split_sort(Pivot,[X|Tail],UnorderedNumericList,[X|OrderedNumericList]):-
     X > Pivot,split_sort(Pivot,Tail,UnorderedNumericList,OrderedNumericList).
%=======================5 alist===================================
%alist(FirstList,SecondList,AssociationList) :: create the association list
%alist([],[],Assoc_List) :-

%=======================6 assoc===================================

%=======================7 freqCount Works=========================
%freq_count(List,FCL) :: ...

freq_count(List,FC_list) :-
make_set(List,Set),
freq_counter(Set,List,FC_list).

freq_counter([],_,[]).
freq_counter([H|T],List,FC_list) :-
  count(H,List,H_count),
  freq_counter(T,List,FCT_list),
  FC_list = [pair(H,H_count) | FCT_list].
%=======================8 make set WORKS=================================
%make_set(List,Set) :: Makes a set from two list 

make_set([],[]).
make_set([H|T],TS) :-
member(H,T),
  make_set(T,TS).
make_set([H|T],[H|TS]) :-
make_set(T,TS).
%======================9 flatten WORKS====================================
%flatten(HL,FL) :: Takes the elements out of the list and makes it into an empty list

flatten([],[]).
flatten([[]|T],L) :-
   flatten(T,L).
flatten([H|T],L) :-
 atom(H),
 flatten(T,Tflattened),
 append1([H],Tflattened,L).
flatten([H|T],L) :-
  flatten(H,FlatHead),
  flatten(T,FlatTail),
  append1(FlatHead,FlatTail,L).