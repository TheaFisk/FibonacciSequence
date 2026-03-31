
%% Fibonacci Sequence using Erlang

-module(fibonacci).
-export([run_all/0,        %% Runs all demos
         fib/1,            %% Single Fibonacci number (recursive)
         fib_list/1,       %% List of Fibonacci numbers up to N
         fib_even/1,       %% Filter: only even Fibonacci numbers
         fib_sum/1,        %% Sum of Fibonacci sequence using foldl
         fib_safe/1,       %% Safe Fibonacci with exception handling
         fib_classify/1    %% Classify Fibonacci numbers using case...of
        ]).


%% fib/1  —  Recursive Fibonacci using PATTERN MATCHING and GUARDS
%%
%% Base cases are matched by pattern, and a guard ensures the input is valid.


%% Base cases
fib(0) -> 0;
fib(1) -> 1;

%% Recursive case: only allow positive integers (guard: N > 1)
fib(N) when is_integer(N), N > 1 ->
    fib(N - 1) + fib(N - 2).



%% fib_list/1  —  Build a LIST of the first N Fibonacci numbers

%% Uses a helper with an accumulator to collect results via RECURSION.
%% The list is built in reverse (efficient), then reversed at the end.

fib_list(N) when is_integer(N), N >= 0 ->
    fib_list_helper(N, 0, []).

%% Helper: when Index exceeds N, reverse the accumulator and return
fib_list_helper(N, Index, Acc) when Index > N ->
    lists:reverse(Acc);

%% Helper: compute fib(Index), prepend to accumulator, recurse
fib_list_helper(N, Index, Acc) ->
    fib_list_helper(N, Index + 1, [fib(Index) | Acc]).


%% fib_even/1  —  LAMBDA with lists:filter

%% Generates the first N Fibonacci numbers, then filters to keep only evens.
%% The lambda `fun(X) -> X rem 2 =:= 0 end` is an anonymous function.


fib_even(N) when is_integer(N), N >= 0 ->
    Sequence = fib_list(N),
    IsEven = fun(X) -> X rem 2 =:= 0 end,   %% Lambda: true if X is even
    lists:filter(IsEven, Sequence).



%% fib_sum/1  —  LAMBDA with lists:foldl

%% Sums all Fibonacci numbers from fib(0) to fib(N).
%% lists:foldl(Fun, Acc0, List) applies Fun to each element, threading Acc.


fib_sum(N) when is_integer(N), N >= 0 ->
    Sequence = fib_list(N),
    Adder = fun(X, Acc) -> X + Acc end,      %% Lambda: add element to accumulator
    lists:foldl(Adder, 0, Sequence).



%% fib_safe/1  —  EXCEPTION THROWING and HANDLING (Stretch)
%% Wraps fib/1 in a try...catch to handle bad inputs gracefully.
%% Throws a descriptive error atom for negative or non-integer inputs.


fib_safe(N) when is_integer(N), N >= 0 ->
    %% Valid input: compute normally
    fib(N);

fib_safe(N) when is_integer(N), N < 0 ->
    %% Negative integer: throw a typed error
    throw({invalid_input, negative_not_allowed, N});

fib_safe(N) ->
    %% Non-integer: throw a type error
    throw({invalid_input, integer_required, N}).

%% Wrapper that catches exceptions and returns a friendly message
safe_call(N) ->
    try
        Result = fib_safe(N),
        io:format("fib_safe(~w) = ~w~n", [N, Result])
    catch
        throw:{invalid_input, negative_not_allowed, Val} ->
            io:format("ERROR: ~w is negative. Only non-negative integers allowed.~n", [Val]);
        throw:{invalid_input, integer_required, Val} ->
            io:format("ERROR: ~w is not an integer.~n", [Val]);
        _:Other ->
            io:format("UNEXPECTED ERROR: ~w~n", [Other])
    end.


%% fib_classify/1  —  CASE...OF block (Stretch)
%%
%% Generates fib_list(N) and classifies each number using case...of.
%% Labels: zero | one | small | medium | large


fib_classify(N) when is_integer(N), N >= 0 ->
    Sequence = fib_list(N),
    
    %% Use lists:map with a lambda containing a case...of block
    Classifier = fun(X) ->
        Label = case X of
            0              -> zero;
            1              -> one;
            V when V < 10  -> small;
            V when V < 100 -> medium;
            _              -> large
        end,
        {X, Label}
    end,
    lists:map(Classifier, Sequence).


%% Master demo: runs and prints all features
run_all() ->
    io:format("~n- - - - - - - - - - - - - - - - -~n"),
    io:format("FIBONACCI SEQUENCE — ERLANG DEMO~n"),
    io:format("- - - - - - - - - - - - - - - - -~n~n"),

    %% Single Fibonacci numbers
    io:format("- Single Fibonacci Numbers (fib/1)~n"),
    io:format("fib(0)  = ~w~n", [fib(0)]),
    io:format("fib(1)  = ~w~n", [fib(1)]),
    io:format("fib(7)  = ~w~n", [fib(7)]),
    io:format("fib(10) = ~w~n", [fib(10)]),
    io:format("~n"),

    %% List of first N Fibonacci number
    io:format("- Fibonacci Sequence List (fib_list/1)~n"),
    Seq10 = fib_list(10),
    io:format("fib_list(10) = ~w~n", [Seq10]),
    io:format("~n"),

    %% Filter: even Fibonacci numbers
    io:format("- Even Fibonacci Numbers (fib_even/1 via lists:filter)~n"),
    Even = fib_even(10),
    io:format("Even values in fib_list(10) = ~w~n", [Even]),
    io:format("~n"),

    %% Sum using foldl + lambda
    io:format("- Sum of Fibonacci Sequence (fib_sum/1 via lists:foldl)~n"),
    Sum = fib_sum(10),
    io:format("Sum of fib_list(10) = ~w~n", [Sum]),
    io:format("~n"),

    %% Safe Fibonacci with exception handling
    io:format("- Safe Fibonacci with Exception Handling (fib_safe/1)~n"),
    safe_call(5),
    safe_call(-3),
    safe_call(hello),
    io:format("~n"),

    %% Classification using case...of
    io:format("- Fibonacci Classification with case...of (fib_classify/1)~n"),
    Classes = fib_classify(10),
    lists:foreach(
        fun({Val, Label}) ->
            io:format("fib value ~3w  =>  ~w~n", [Val, Label])
        end,
        Classes
    ),
    io:format("~n"),
    io:format("- - - - - - - -~n"),
    io:format("Demo complete.~n"),
    io:format("- - - - - - - -~n~n").

%% Add this so escript knows where to start
main(_) ->
    run_all().