use strict;
use warnings;
#use DateTime;

sub getDate {
    #$unix_timestamp = '1461241125.31307';
    #my $dt = DateTime->from_epoch(epoch => $unix_timestamp);
    #print $dt->strftime('%Y-%m-%d %H:%M:%S'),"\n";
}

my @authorsEmails;
my %emailCount;
chomp(@authorsEmails = `git log --pretty=%ae`);
for my $email (@authorsEmails){
    if(exists($emailCount{$email})){
        $emailCount{$email}++;
    } else {
        $emailCount{$email} = 1;
    }
}

for my $key (keys %emailCount){
    print($key . ", " . $emailCount{$key} . "\n");
}
