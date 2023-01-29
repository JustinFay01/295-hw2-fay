use strict;
use warnings;

my @objects;
my @out;
#Acesses Input Line
if(@ARGV == 1){
    my $commit = $ARGV[0];
    chomp (@objects = `git cat-file -p $commit`);
    for my $file (@objects){
        @out = split / /, $file;
        if($out[0] eq "tree"){
            print($out[1]. "\n"); 
            exit 0;
        }
    }
} else {
    print("Incorrect Command. \n");
    exit -1;
}


  
