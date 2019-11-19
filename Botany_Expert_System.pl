/* Eli Peters
 * Peter Oliver
 * CS 480 Artificial Inteligence
 * Botany Expert System Project
 */

start :- identify(Plant),
         write('The plant you described is:  '), write(Plant), nl,
         undo.

% Possible identifications
identify('Redwood')        :- 'Redwood', !.
identify('Big Leaf Maple') :- 'Big Leaf Maple', !.
identify('Sorrel')         :- 'Sorrel', !.
identify(unknown).

% Plant attributes
'Redwood'        :- tree,
                    evergreen,
                    check('flat needles').
'Big Leaf Maple' :- tree,
                    deciduous,
                    check('broad leaves').
'Sorrel'         :- herb,
                    check('heart shaped leaves').

% Plant Classifications
tree             :- check('a height greater than 20 ft.').
evergreen        :- tree,
                    check('needles').
deciduous        :- tree,
                    check('leaves').
herb             :- check('a height shorter than 2 ft.').

% Asking questions
ask(Question) :- write('Does the plant have '),
                 write(Question), write('?  '),
                 read(Answer),
                 nl,
                 (
                     (Answer == yes ; Answer == y)
                     -> assert(yes(Question)) ;
                        assert(no(Question)), fail
                 ).

:- dynamic yes/1, no/1.

% Checking attributes
check(Attribute) :-
    (
        yes(Attribute)
        -> true;
           (   no(Attribute)
               -> fail;
                  ask(Attribute)
           )
    ).

% undo yes/no assertions
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
