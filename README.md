# Overview
This project is an Erlang module that demonstrates core functional programming concepts through the Fibonacci sequence. The program computes individual Fibonacci numbers, generates sequences as lists, filters and sums those lists using lambda functions, classifies values with case expressions, and handles invalid input through structured exception handling. All results are printed to the terminal using formatted output.
 
My goal with this software was to explore the functional programming paradigm through a language purpose-built for it. I wanted to demonstrate my understanding of recursion, immutable data, pattern matching, and higher-order functions. This project showcases my ability to think in a functional style, apply guards and pattern clauses in place of conditional branching, and use Erlang's standard library to process lists cleanly and expressively.
 
[Software Demo Video](INSERT_VIDEO_LINK_HERE)
 
---
 
# Development Environment
This project was developed using the following tools and technologies:
 
* Visual Studio Code with Erlang Extension
* Erlang / OTP Programming Language
* erlc (Erlang Compiler)
* erl (Erlang Interactive Shell)
* Git and GitHub for version control
 
The module is compiled using `erlc` from the terminal and run interactively through the `erl` shell. The design is platform-independent and runs on Windows, macOS, or Linux systems with Erlang installed.
 
---
 
# Useful Websites
The following resources were helpful while developing this project:
 
* https://www.erlang.org/doc/reference_manual/users_guide.html
* https://www.erlang.org/doc/man/lists.html
* https://learnyousomeerlang.com/content
* https://www.erlang.org/doc/reference_manual/expressions.html#case
* https://www.erlang.org/doc/reference_manual/errors.html
* https://erlang-by-example.com
 
---
 
# AI Disclosure
I used Claude AI as a development partner during this project. I primarily used it to help structure the module layout, review idiomatic Erlang patterns, and explore how to demonstrate multiple functional programming concepts within a single cohesive program.
 
In one specific part of the project, I asked for assistance designing the list-building helper function that accumulates Fibonacci values using a reverse-and-return pattern. The AI suggested using a tail-recursive helper with an accumulator list, prepending each value for efficiency and reversing at the end. I did not copy the implementation verbatim. I adapted the approach to fit my module structure, added guards to validate inputs, and integrated it as the foundation for the filtering, folding, and classification functions built on top of it.
 
Through this process, I learned how Erlang handles recursion without mutable loop variables, why accumulator patterns are preferred for list construction, and how pattern matching clauses can replace conditional logic entirely. I felt confident using the suggestions because I understood how each function clause was selected at runtime, traced through the recursion manually, and verified the output against expected Fibonacci values.
 
---
 
# Future Work
If I were to continue improving this project, I would like to:
 
* Implement a more efficient iterative Fibonacci using tail recursion with two accumulators
* Add memoization using an Erlang process dictionary or ETS table to cache computed values
* Demonstrate message passing by spawning a Fibonacci server process
* Add a command-line argument parser so values can be passed without entering the shell
* Expand the classification system to include prime and perfect square detection
* Write unit tests using the EUnit testing framework
* Explore generating Fibonacci numbers as a lazy infinite stream
* Add file output so sequences can be saved to disk for external analysis
* Extend the module to support other mathematical sequences such as Lucas or Tribonacci numbers
* Package the module as a proper OTP application with a supervision tree
