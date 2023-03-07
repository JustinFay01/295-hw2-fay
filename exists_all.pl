use strict;
use warnings;

if($#ARGV >= 1) {
    my $file = $ARGV[0];
    my $found = 0;
    unless (-e $file){ print("File not found.\n"); exit -2; } 

    # cycle through input commits
    for (my $i = 1; $i < @ARGV; $i++) {
        my $commit = $ARGV[$i];

        # check type of git-cat file
        chomp(my $type = `git cat-file -t $commit`);
        if($type ne "commit") {
            if($type eq "tree") { print($commit . " is a ". $type . " object, not a commit object.\n"); }
            else                { print($commit . " does not represent a valid Git object\n"); }
            exit -2;
        } else {
            # git cat file the given commit
            chomp(my @commitFiles = `git cat-file -p $commit`);
            my @firstLine = split(" ", $commitFiles[0]);
            my $treeSHA = $firstLine[1]; # Got tree sha

            # git cat file the found tree
            chomp(my @files = `git cat-file -p $treeSHA`);
            # check for file 
            foreach(@files){ if($_ =~ /$ARGV[0]/) { $found++ }; } # find file
        }
    }
    if($found == $#ARGV){ print("True\n"); exit 0;} 
    else { print("False\n"); 
           exit 1; }
} else { print("Enter one or more commit SHA's\n"); 
           exit -1; }