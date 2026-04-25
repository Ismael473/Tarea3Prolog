:- consult('BD.pl').

start :-
    retractall(answer(_,_)),
    ask_next.
	
read_answer :-
    read_line_to_string(user_input, Input),
	string_lower(Input, Lower),
    split_string(Input, " ", "", Words),
    maplist(atom_string, Atoms, Words),
    analyze(Atoms).

/* 
Esta regla calcula el puntaje de una carrera en específico.
*/
score(Career, Score) :-
    findall(A, (affinity(Career, A), answer(positive, A)), List1),
    length(List1, P1),
	
	findall(B, (affinity(Career, B), answer(negative, B)), List2),
    length(List2, P2),

    findall(C, (antagonism(Career, C), answer(positive, C)), List3),
    length(List3, P3),

    Score is P1 - P2 - P3.

/* 
Esta regla busca la carrera con mayor puntaje
según las afinidades y las antagonías.
*/
best_career(Career) :- 
    career(Career),
    score(Career, Score),
    \+ (
        career(OtherCareer),
        score(OtherCareer, OtherScore),
        OtherScore > Score
    ).

next_question(Trait) :-
    best_career(Career),
    affinity(Career, Trait),
    \+ answer(_, Trait), !.

next_question(Trait) :-
    question(Trait, _),
    \+ answer(_, Trait).

enough_confidence :-
    best_career(Career),
    score(Career, BestScore),
	BestScore > 0,
    \+ (
        career(OtherCareer),
        OtherCareer \= Career,
        score(OtherCareer, OtherScore),
        BestScore - OtherScore < 2
    ).

ask_next :-
    enough_confidence,
    recommend.

ask_next :-
    next_question(Trait),
    question(Trait, Text),
    write(Text), nl,
    read_answer.

ask_next :-
    \+ next_question(_),
    recommend.

/*
Recomendación final
*/
recommend :-
    best_career(Career),
    write('Dadas tus preferencias te recomendaria estudiar: '),
    write(Career), nl.