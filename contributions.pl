use strict;
use warnings;

#git log --pretty=%ad --author=justin.fay@hope.edu --date=unix -1 //Most Recent
# git log --pretty=%ad --author=justin.fay@hope.edu --date=unix --reverse //Odest

my @authorsEmails;
my %emailCount;
chomp(@authorsEmails = `git log --pretty=%ae`);
for my $email (@authorsEmails){
    if(exists($emailCount{$email})) { $emailCount{$email}++; } 
    else                            { $emailCount{$email} = 1; }
}

for my $key (keys %emailCount){
   chomp(my @oldestDate = `git log --date=unix --pretty=%cd --author=justin.fay\@hope.edu --reverse`);
   chomp(my $recentDate = `git log --date=unix --pretty=%cd --author=justin.fay\@hope.edu -1`);
   print($key . ", " . $emailCount{$key} . ", " . (scalar localtime $oldestDate[0]) . ", " . (scalar localtime $recentDate) . "\n")


}
