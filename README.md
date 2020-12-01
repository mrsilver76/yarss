# YARSS - Yet Another Recursive Sudoku Solver
**A Sudoku solver which uses brute force, recursion and backtracking to solve any (solveable) Sudoku puzzle.**

Written in VBScript (for Windows) and Perl (for other operating systems). You can run the Perl one in Windows if you want, but you'll need to install Perl to do it.

Reads Sudoku puzzles in `.sdk` or `.ss` file formats and outputs 1 (or more) solutions to the display.

## Usage

 * Windows - open a command line prompt and type `cscript yarss.vbs <puzzle>`
 * Others - open a command line prompt and type `perl yarss.pl <puzzle>`

`<puzzle>` is the filename of a Sudoku puzzle. Some sample puzzles are included, including one which proclaims to be the [world's hardest](https://puzzling.stackexchange.com/questions/252/how-do-i-solve-the-worlds-hardest-sudoku).

If you want to create your own (or solve one that is bugging you) then details of the file formats can be found in the links below:

* https://www.sudocue.net/fileformats.php
* http://www.sadmansoftware.com/sudoku/faq19.php

There is no benefit (with this code) to using one format over another.

## Do we really need another Sudoku solver?

No, not really.

However it was fun to write and a cursory search on Github showed a lot of solutions which were significantly more complicated than this - mainly because they didn't use recursion.
