#!/bin/perl

# YARSS - Yet Another Recursive Suduku Solver
# by Richard Lawrence
#
# Uses a combination of brute force, recursion and backtracking to solve any
# (solveable) sudoku puzzle.
#
# Usage: perl yarss.pl <puzzle file>
#
# Supports the Sandman (.sdk) and Simple SudoCue (.ss) formats
#
# http://www.sadmansoftware.com/sudoku/faq19.php
# https://www.sudocue.net/fileformats.php

use strict;
use warnings;
my $VERSION = '1.0';

# The grid for storing the numbers
my @grid;

# Display header
print "Yet Another Recursive Sudoku Solver (YARSS) v${VERSION}, by Richard Lawrence\n";
print "https://github.com/mrsilver76/yarss\n";
print "\n";

# Get the name of the input file
my $input = $ARGV[0];
display_usage() if (not defined $input);

# Load the grid from the file
load_grid();

print "Going to solve '$input':\n\n";
display_grid();

my $attempts = 0;
my $solutions = 0;
solve_grid();

print "\nFinished with $solutions solution" . pluralise($solutions) . ".\n";
exit;

# ------------------------------------------------------------------------

# display_usage
# Display the title, copyright, usage information and an optional error message

sub display_usage
{
	my $error = shift;

	if ($0 eq "-e")
	{
		# Probably running as a tinyperl exe on Windows
		print "Usage: yarss.exe <puzzle>\n";
	}
	else
	{
		print "Usage: $0 <puzzle>\n";
	}
	print "       Puzzle format can be .sdk (Sadman) or .ss (Simple SudoCue).\n";
	
	if ($error)
	{
		print "\n";
		print "Error: $error\n";
	}
	exit;
}

# pluralise
# Given a number, returns a "s" if it's needed in a string for plurals

sub pluralise
{
	my $n = shift;
	return "s" if ($n != 1);
	return "";
}

# load_grid
# Load the sudoku grid from an external file into memory

sub load_grid
{
	display_usage("Puzzle file does not exist") unless (-e $input);

	open(FILE, $input) || display_usage("Could not load $input: $!");
	while(<FILE>)
	{
		# Remove newlines from Windows files
		tr/\r\n//d;
		# Ignore lines starting with #
		unless (/^#/)
		{
			# Replace . or X with a 0
			s/[\.x]/0/gi;
			# Remove anything which isn't a 0-9
			s/[^0-9]//g;
			# Stop if we find [State] in an extended SDK format
			last if (/\[state\]/i);
			
			# Split up each character and store
			my @fields = split(//);
			push @grid, \@fields if (@fields);
		}
	}
	close FILE;
}

# solve_grid
# Searches for the first empty blank space and checks if a number (starting from 1)
# is valid. If it is then places it into that cell and then calls itself again. If it
# is not then removes the number from the cell and continues.
# 
# If it gets stuck and cannot place any more numbers then this layout is not going to work
# so backtracks to try something else.

sub solve_grid
{
	$attempts++;
	
	for (my $x = 0; $x < 9; $x++)
	{
		for (my $y = 0; $y < 9; $y++)
		{
			# Check if the current cell is empty
			if ($grid[$x][$y] == 0)
			{
				for (my $i = 1; $i < 10; $i++)
				{
					# Can we put $i into this cell and it be valid
					if (is_possible($x, $y, $i) == 1)
					{
						# We can! So do it
						$grid[$x][$y] = $i;
						# Now try to solve the grid again
						solve_grid();
						# If we get to here that number in that cell didn't
						# work, so we need to take it back out again
						$grid[$x][$y] = 0;
					}
				}
				# If we are here then none of the numbers worked, so we need to
				# go back and try a different number earlier on
				return;
			}
		}
	}

	print "\nFound a solution in $attempts attempts:\n\n";
	display_grid();
	
	$attempts = 0;
	$solutions++;
}

# display_grid
# Print out the sudoku grid, including grid lines

sub display_grid
{
	for (my $x = 0; $x < 9; $x++)
	{
		for (my $y = 0; $y < 9; $y++)
		{
			if ($grid[$x][$y] == 0)
			{
				print "_ ";
			}
			else
			{
				print $grid[$x][$y] . " ";
			}
			print "| " if ($y == 2 || $y == 5);
		}
		print "\n";
		print "---------------------\n" if ($x == 2 || $x == 5);
	}
}

# is_possible
# Given $x and $y, return a 1 if $n can be put in that square or
# 0 if it cannot.

sub is_possible
{
 my ($x, $y, $n) = @_;

	# We cannot place $n if $n already exists in the same row
	# or column

	for (my $i = 0; $i < 9; $i++)
	{
		return 0 if ($grid[$i][$y] == $n || $grid[$x][$i] == $n);
	}

	# We cannot place $n if it is already in the same 3x3 block. To
	# do this we need to work out which cell ($xs and $ys) is the top-left
	# corner of the 3x3 box which has $x and $y in it

	my $xs = 3 * int($x/3);
	my $ys = 3 * int($y/3);

	# Check if any of the cells in this 3x3 box have $n in it

	for (my $i = 0; $i < 3; $i++)
	{
		for (my $j = 0; $j < 3; $j++)
		{
			return 0 if ($grid[$xs+$i][$ys+$j] == $n);
		}
	}

	# $n can be used in this cell
	return 1;
}
