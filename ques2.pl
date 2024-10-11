% Boat capacity is 100kg; man and woman each weigh 80kg, children weigh 30kg each.

% Initial state: everyone is on the left bank
initial_state(state([m, w, c1, c2], [], left)).

% Final state: everyone is on the right bank
final_state(state([], [m, w, c1, c2], right)).

% Moves for crossing: one or two people cross the river in the boat
move(state(Left, Right, left), state(NewLeft, NewRight, right), Crossers) :-
    select_persons(Left, Crossers),
    safe_crossing(Crossers),
    subtract(Left, Crossers, NewLeft),
    append(Crossers, Right, NewRight).

move(state(Left, Right, right), state(NewLeft, NewRight, left), Crossers) :-
    select_persons(Right, Crossers),
    safe_crossing(Crossers),
    subtract(Right, Crossers, NewRight),
    append(Crossers, Left, NewLeft).

% Select one or two people to cross
select_persons(People, [P1]) :-
    member(P1, People).
select_persons(People, [P1, P2]) :-
    member(P1, People),
    member(P2, People),
    P1 \= P2.

% Check that the crossing is safe (doesn't exceed 100kg)
safe_crossing(Crossers) :-
    weight(Crossers, W),
    W =< 100.

% Define the weights of individuals
weight([], 0).
weight([m|T], W) :-
    weight(T, Wt),
    W is Wt + 80.
weight([w|T], W) :-
    weight(T, Wt),
    W is Wt + 80.
weight([c1|T], W) :-
    weight(T, Wt),
    W is Wt + 30.
weight([c2|T], W) :-
    weight(T, Wt),
    W is Wt + 30.

% Solve the puzzle: try to get from the initial state to the final state
solve(State, Moves) :-
    final_state(State),
    write('Solution found!'), nl,
    write_moves(Moves).
solve(State, Moves) :-
    move(State, NewState, Crossers),
    \+ member(NewState, Moves),  % Ensure no loops
    solve(NewState, [NewState|Moves]).

% Write the moves to the output
write_moves([]).
write_moves([state(L, R, B)|T]) :-
    format('Left bank: ~w, Right bank: ~w, Boat: ~w~n', [L, R, B]),
    write_moves(T).

% Start solving the puzzle
start :-
    initial_state(State),
    solve(State, [State]).
