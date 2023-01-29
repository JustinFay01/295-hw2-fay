use strict;
use warnings;

my @objects;

if(@ARGV == 1){
# take in file name
# Grab Author using git cat file
# Print commmit number 
# cat the file
my $file = $ARGV[0];
my $commit;
chomp(@objects = `git log -1 --name-only $file`);
for(my $i = 0; $i < $#objects; $i++){
    my @val = split / /, $objects[$i];
    if($i == 0){
        $commit = $val[1];
    } 
    elsif ($i == 1) {
        print($objects[$i] . "\n\n"); 
    }
}

print("SHA-1 for " . $file . ": " . $commit . "\n");
chomp(my @print = `cat $file`);
for my $line (@print){
print("\n". $line . "\n");
}

} else {
    print("Incorrect Command. \n");
    exit -1;
}