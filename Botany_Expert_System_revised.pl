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
identify('Poison Oak')             :- 'Poison Oak', !.
identify('Redwood Sorrel')         :- 'Redwood Sorrel', !.
identify('Salal Berry')            :- 'Salal Berry', !.
identify('Red Huckleberry')        :- 'Red Huckleberry', !.
identify('Evergreen Huckleberry')  :- 'Evergreen Huckleberry', !.
identify('Cobra Lily')             :- 'Cobra Lily', !.
identify('Thimbleberry')           :- 'Thimbleberry', !.
identify('Blackberry')             :- 'Blackberry', !.
identify('Oregon Grape')           :- 'Oregon Grape', !.
identify('Cattail')                :- 'Cattail', !.
identify('Fetid Adderstongue')     :- 'Fetid Adderstongue', !.
identify('California Wildrose')    :- 'California Wildrose', !.
identify('Deerfern')               :- 'Deerfern', !.
identify('Swordfern')              :- 'Swordfern', !.
identify('Leather Fern')           :- 'Leather Fern', !.
identify('Douglas Iris')           :- 'Douglas Iris', !.
identify('California Poppy')       :- 'California Poppy', !.
identify('Blue Flax')              :- 'Blue Flax', !.
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
'Salal Berry'	 		:- 	herb,
							berry,
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
'Cattail'				:-  shrub,
							check('long, narrow leaves'),
							check('a penchant for wetlands'),
							check('sausage-on-a-stick-like stems').
'Fetid Adderstongue'	:-  herb,
							check('broad leaves'),
							check('liver-spotted leaves'),
							check('three-petalled flowers with an unpleasant scent').
'California Wildrose'	:-  shrub,
							check('prickly stems'),
							check('pleasantly-scented pink flowers with five petals').
'Deerfern'				:-  swordleaf,
							check('soft fronds').
'Swordfern'				:-  swordleaf,
                            check('firm fronds').
'Leather Fern'			:-  fern,
							check('rounded leaves').
'Douglas Iris'			:-  herb,
							check('a rhizome'),
							check('purple, white, or yellow flowers with three sepals').
'California Poppy'		:-  herb,
							check('feathery leaves'),
							check('orange, bell-shaped flowers').
'Blue Flax'				:-  herb,
							check('silky, blue flowers with five petals'),
							check('useful fibers').

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
fern			 :- herb,
                    check('fronds').
swordleaf		 :- fern,
					check('sword-shaped fronds').

% Asking questions
ask(Question) :- write('Does the plant have '),
                 write(Question), write(' (yes/no)? '),
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
