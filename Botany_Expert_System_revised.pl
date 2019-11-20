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
identify('Douglas Fir')    :- 'Douglas Fir'.
identify('Big Leaf Maple') :- 'Big Leaf Maple', !.
identify('Tanoak')         :- 'Tanoak', !.
identify('Rhododendron')   :- 'Rhododendron', !.
identify('Poison Oak')     :- 'Poison Oak', !.
identify('Sorrel')         :- 'Sorrel', !.
identify(unknown).

% Plant attributes
'Redwood'        :- tree,
                    conifer,
                    check('feather-like needles').
'Douglas Fir'    :- tree,
                    conifer,
                    check('bush-like needles').
'Tanoak'         :- tree,
                    broadleaf,
                    check('serrated, single-pointed leaves').
'Big Leaf Maple' :- tree,
                    broadleaf,
                    check('large five-pointed leaves').
'Rhododendron'   :- shrub,
                    check('smooth single-pointed leaves').
'Poison Oak'     :- shrub,
                    check('glossy, lobed leaves'),
                    check('three leaf groupings').
'Sorrel'         :- herb,
                    check('heart shaped leaves').

% Plant Classifications
tree             :- check('a height greater than 20 feet').
conifer          :- tree,
                    check('cones').
broadleaf        :- tree,
                    check('broad leaves').
shrub            :- check('a height between 2 and 20 feet').
herb             :- check('a height shorter than 2 feet').

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
