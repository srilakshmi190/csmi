% Define the rule for the riddle
that_man(X) :-
    father(Y, X),     % X's father is Y
    father(Z, Y),     % Y's father is Z
    father(Z, me),    % My father is Z, which means Y is me
    X \= me.          % Ensure X is not me (so X is my son)

% Facts: me is the speaker
father(me, my_son).      % I am the father of my son
father(my_father, me).   % My father is the father of me

% Initialization to run the query when the program starts
:- initialization(main).

main :-
    that_man(X),
    write('That man is: '),
    write(X), nl,
    halt.
