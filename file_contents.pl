use strict;
use warnings;

my @objects;

if(@ARGV == 1){ 
my $file = $ARGV[0];
my $commit;
#Find objects associated with file
chomp(@objects = `git log -1 --name-only $file`);
#find commit and author
for(my $i = 0; $i < @objects; $i++){
    my @val = split / /, $objects[$i];
    if($i == 0){
        $commit = $val[1];
    } 
    elsif ($i == 1) {
        print($objects[$i] . "\n\n"); 
    }
}
#print file name and sha
print("SHA-1 for " . $file . ": " . $commit . "\n\n");
#print file
chomp(my @print = `cat $file`);
for my $line (@print){
print($line . "\n");
}

} else {
    print("Incorrect Command. \n");
    exit -1;
}