# YARSS - Yet Another Recursive Sudoku Solver
**A Sudoku solver which uses brute force, recursion and backtracking to solve any (solveable) Sudoku puzzle.**

Written in VBScript (for Windows) and Perl (for other operating systems). You can run the Perl one in Windows if you want, but you'll need to install Perl to do it.

Reads Sudoku puzzles in `.sdk` or `.ss` file formats and outputs any possible solutions. If the puzzle has been devised poorly then there may be no solutions or more than one solution. The code will get them all.

## Usage

 * Windows - open a command line prompt and type `cscript yarss.vbs <puzzle>`
 * Others - open a command line prompt and type `perl yarss.pl <puzzle>`

`<puzzle>` is the filename of a Sudoku puzzle. Some sample puzzles are included, including one which proclaims to be the [world's hardest](https://puzzling.stackexchange.com/questions/252/how-do-i-solve-the-worlds-hardest-sudoku).

If you want to create your own (or solve one that is bugging you) then details of the file formats can be found in the links below:

* https://www.sudocue.net/fileformats.php
* http://www.sadmansoftware.com/sudoku/faq19.php

There is no benefit (with this code) to using one format over another.

## How does it work?

`load_grid` loads an external sudoku file into a two dimensional (9x9) array. Each cell contains the number in it and `0` if it is empty.

`is_possible` takes the x and y co-ordinates of the grid (eg. `x=1,y=1` is the top-left corner) and a number and returns whether or not it is possible to have that number in that cell without breaking the rules of Sudoku. It does this by checking that the number isn't already there in the same row or column and not in the 3x3 cells.

`solve_grid` walks through each cell in the grid and stops at one which doesn't have a number. It starts at `1` and uses `is_possible` to determine if that number can go there. If it can then it calls itself (this is the recursion), which then walks through each cell in the grid and stops at the next one that doesn't have a number. If no numbers are possible then the function exits and returns to the previous call (this is the backtracking) which then increases the number. If it gets to the very end with no problems then we have a solution. If it rolls back to the very first call then we've exhausted the options and we are finished.

If this is making your head spin, then there is a very good [YouTube video on how it works](https://www.youtube.com/watch?v=G_UYXzGuqvM), although they use Python to create the solution.

## Do we really need another Sudoku solver?

No, not really.

However it was fun to write and a cursory search on Github showed a lot of solutions which were significantly more complicated than this - mainly because they didn't use recursion.
