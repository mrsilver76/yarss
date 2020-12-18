# YARSS - Yet Another Recursive Sudoku Solver
**A solver which uses brute force, recursion and backtracking to solve any (solvable) Sudoku puzzle.**

## Abstract

This program (written in Perl) reads [Sudoku](https://en.wikipedia.org/wiki/Sudoku) puzzles (in `.sdk` or `.ss` file formats) and outputs any possible solutions. If there is more than one solution then it will display them all. Properly constructed Sudoku puzzles should have only one solution.

## Usage

Download the latest version from https://github.com/mrsilver76/yarss/archive/main.zip and extract all the files.

 * **Windows** - open a command line prompt and type `yarss.exe <puzzle>`. Make sure that you have the `perl58.dll` and `lib.zip` files in the same location as `yarss.exe`.
 * **Others** - open a command line prompt and type `perl yarss.pl <puzzle>`. Make sure you have Perl installed on your system.

`<puzzle>` is the filename of a Sudoku puzzle. Some sample puzzles are included in the `puzzles` folder, including one which proclaims to be the [world's hardest](https://puzzling.stackexchange.com/questions/252/how-do-i-solve-the-worlds-hardest-sudoku) (imaginately titled `worlds-hardest.sdk`).

Windows users are recommended to just run the provided executable (which has been created using [TinyPerl](http://tinyperl.sourceforge.net/)). However it is possible (albeit more complicated) to install something like [Strawberry Perl](https://strawberryperl.com/) and run `yarss.pl` instead. 

## Puzzle file format

If you want to create your own (or solve one that is bugging you) then details of the supported file formats can be found in the links below:

* https://www.sudocue.net/fileformats.php
* http://www.sadmansoftware.com/sudoku/faq19.php

The included puzzles all use different styles to demonstrate what can be used - so it's worthwhile opening them in a text editor and taking a look. 

At it's most basic level, it's just 9 lines of 9 numbers in a row with `0`, `X` or `.` to indicate an empty cell. You can use spaces, newlines and other characters to make the file more readable if you'd like as they'll be ignored. Lines starting with `#` will also be ignored (which is useful for embedding commentary).

It does not matter if you use the `.sdk` or `.ss` file format and you don't have to have the match the format to the correct extention - so there is no benefit (with this program) in using one format over the other.

Here is an example file which can be saved with either the `.ss` or `.sdk` file ending:

    # This puzzle is on the wikipedia page for 'sudoku'
    # https://en.wikipedia.org/wiki/Sudoku
    53. .7. ...
    6.. 195 ...
    .98 ... .6.
    
    8.. .6. ..3
    4.. 8.3 ..1
    7.. .2. ..6
    
    .6. ... 28.
    ... 419 ..5
    ... .8. .79

## How does it work?

The code itself (`yarss.pl`) contains a lot of comments about how it works. You can open it in any good text editor.

`load_grid` loads an external sudoku file into a two dimensional (9x9) array. Each cell contains the number in it and `0` if it is empty. Lines which start with `#` are ignored, `.` and `X` are treated as `0` and anything which isn't a number is ignored. This allows the file to contain spacing, dashes and other elements to make it easier to read.

`is_possible` takes the x and y co-ordinates of the grid (eg. `x=1,y=1` is the top-left corner) and a number and returns whether or not it is possible to have that number in that cell without breaking the rules of Sudoku. It does this by checking that the number isn't already there in the same row or column and not in the 3x3 cells.

`solve_grid` walks through each cell in the grid and stops at one which doesn't have a number. It starts at `1` and uses `is_possible` to determine if that number can go there. If it can then it calls itself (this is the recursion), which then walks through each cell in the grid and stops at the next one that doesn't have a number. If no numbers are possible then the function exits and returns to the previous call (this is the backtracking) which then increases the number. If it gets to the very end with no problems then we have a solution. If it rolls back to the very first call then we've exhausted the options and we are finished.

`display_grid` takes the array and outputs it in a (moderately) pretty way so that you can easily read the grid. It uses `|` and `-` to draw lines between each of the 3x3 blocks.

If this is making your head spin, then there is a very good [YouTube video on how it works](https://www.youtube.com/watch?v=G_UYXzGuqvM), although they use Python to create the solution.

## Do we really need another Sudoku solver?

No, not really.

However it was fun to write and a cursory search on Github showed a lot of solutions which were significantly more complicated than this - mainly because they didn't use recursion.
