/* Eli Peters
 * Peter Oliver
 * CS 480 Artificial Inteligence
 * Botany Expert System Project
 */

start :- identify(Plant),
         write('The plant you described is:  '), write(Plant), nl,
         undo.

% Possible identifications
identify('Redwood')                :- 'Redwood', !.
identify('Douglas Fir')            :- 'Douglas Fir'.
identify('Big Leaf Maple')         :- 'Big Leaf Maple', !.
identify('Tanoak')                 :- 'Tanoak', !.
identify('Rhododendron')           :- 'Rhododendron', !.
identify('Poison Oak')     		   :- 'Poison Oak', !.
identify('Redwood Sorrel')         :- 'Redwood Sorrel', !.
identify('Salal Berry')            :- 'Salal Berry', !.
identify('Red Huckleberry')        :- 'Red Huckleberry', !.
identify('Evergreen Huckleberry')  :- 'Evergreen Huckleberry', !.
identify('Cobra Lily')             :- 'Cobra Lily', !.
identify(unknown).

% Plant attributes
'Redwood'       		:-	tree,
							conifer,
							check('feather-like needles').
'Douglas Fir'    		:- 	tree,
							conifer,
							check('bush-like needles').
'Tanoak'         		:- 	tree,
							broadleaf,
							check('serrated, single-pointed leaves').
'Big Leaf Maple' 		:- 	tree,
							broadleaf,
							check('large five-pointed leaves').
'Rhododendron'   		:- 	shrub,
							check('smooth single-pointed leaves').
'Poison Oak'     		:- 	shrub,
							check('glossy, lobed leaves'),
							check('three leaf groupings').
'Redwood Sorrel' 		:- 	herb,
							check('heart shaped leaves').
'Salal Berry'	 		:- 	berry,
							check('glossy leaves'),
							check('lantern-shaped flowers').
'Red Huckleberry'		:- 	shrub,
							berry,
							check('smooth leaves'),
							check('red fruit').
'Evergreen Huckleberry'	:-	shrub,
							berry,
							check('serrated leaves'),
							check('black fruit').
'Cobra Lily'			:-  herb,
							check('cobra-shaped leaves'),
							check('a taste for the blood of innocent insects').
'Thimbleberry'			:-	shrub,
							fruit,
							check('red fruit'),
							check('dome-shaped fruit').
'Blackberry'			:-  shrub,
							fruit,
							check('thorns'),
							check('black fruit').
'Oregon Grape'			:-	shrub,
							berry,
							check('serrated leaves'),
							check('blue fruit').

% Plant Classifications
tree             :- check('a height greater than 20 feet').
conifer          :- tree,
                    check('cones').
broadleaf        :- tree,
                    check('broad leaves').
shrub            :- check('a height between 2 and 20 feet').
herb             :- check('a height shorter than 2 feet').
fruit			 :- check('fruit').
berry			 :- fruit,
					check('berries').

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
