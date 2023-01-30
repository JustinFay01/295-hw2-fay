use strict;
use warnings;

if($#ARGV >= 1)
{
my $file = $ARGV[0];
my @foundAt;
 my $found = 0;
if(-e $file)
{
    chomp(@foundAt = `git log --pretty=%H $file`);    
}
else 
{
    print("File not found.\n");
    exit -2;
}
#cycle through input commits
for (my $i = 1; $i < @ARGV; $i++)
{
    #check length
    my $commit = $ARGV[$i];
    if(length($commit) != 40)
    {
        print($commit . " does not represent a valid Git object\n");
        exit -2;
    }
    else
    {
        #check type of git-cat file
        chomp(my $type = `git cat-file -t $commit`);
        if($type ne "commit")
        {
            print($commit . " is a ". $type . " not a commit object.\n");
            exit -2;
        }
        else
        {
            #compare found commits and input commits
            for(my $j = 0; $j < @foundAt; $j++)
            {
                if($ARGV[$i] eq $foundAt[$j]) 
                {
                    $found++;
                }
            }
        }
    }
}
if($found == $#ARGV)
{
    print("True\n");
    exit 0;
}
else
{
    print("False\n");
    exit 1;
}
}
else
{
print("Enter one or more commit SHA's". "\n");
exit -1;
}