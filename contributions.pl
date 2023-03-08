use strict;
use warnings;
use Time::Piece;

# Get most recent branch commit
# Iterate through branches grabbing parent and incrementing count for that email as well as date
# Hash<Email, @array[recent date, count, oldest date]>
# If there is no key, that becomes the most recent date so 
# if it does contain a key then just update old date
# Count++ every Time
# opendir(DH, ".git/refs/heads/");
# my @branches = readdir(DH);
# closedir(DH);
# foreach my $branch (@branches)
# {
    open(my $br, ".git/HEAD");
    my $branch  = <$br>;
    $branch = substr($branch, 16); #get current branch
    
    # Hash and Array
    my %emailHash;
    open(my $fh, ".git/refs/heads/" . $branch) or die "Couldn't open file, $!";
    my $SHA = <$fh>; # Obtained the most recent commit on this branch
    my @recentCommit; # git cat-file -p the commit
    chomp(@recentCommit = `git cat-file -p $SHA`);
    while($recentCommit[1] =~ m/parent/){
        my @emailInfo;
        #Find author
        my @authorInfo = split(" ", $recentCommit[2]);
        my $author = $authorInfo[3];
        $author =~ tr/[<>]//d; # remove <> from string
        push(@emailInfo, $author);
        #Find Date
        push(@emailInfo, $authorInfo[4]); 
        # check email hash for key
        if(!(exists ($emailHash{$author}))){# if not set count = 1 & add most recent date & oldest date
            push(@emailInfo, 1);
            $emailHash{$author} = \@emailInfo;
            ${$emailHash{$author}}[3] =  $authorInfo[4]; # Set oldest date to the the same current date
        } else { # else increment count & update oldest date 
            ${$emailHash{$author}}[2]++; # Count incremented
            ${$emailHash{$author}}[3] =  $authorInfo[4]; # Update oldest date
        }
        # find parent
        my @parentInfo = split(" ", $recentCommit[1]);
        my $parent = $parentInfo[1];
        # update recentCommit to be the parent
        chomp(@recentCommit = `git cat-file -p $parent`);
    }
    # Hash<Email, @array[recent date, count, oldest date]>
    foreach my $key (keys %emailHash){
        print($key . "," . ${$emailHash{$key}}[2] . "," . 
        (localtime(${$emailHash{$key}}[3]))->strftime('%B %d, %Y') .  "," . 
        (localtime(${$emailHash{$key}}[1]))->strftime('%B %d, %Y') . "\n");
    }
#}