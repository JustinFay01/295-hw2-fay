use strict;
use warnings;

if(@ARGV == 1){ 
# file name check
unless (-e $ARGV[0]){
    print("File not found!\n");
    exit -1;
  }

# Open refs HEAD to view the current branch
# Chomp refs HEAD file
open(my $br, ".git/HEAD");
my $branch  = <$br>;
$branch = substr($branch, 16); #get current branch

# Open refs head of branch we just found
open(my $fh, ".git/refs/heads/" . $branch) or die "Couldn't open file file.txt, $!";
my $SHA = <$fh>; # Obtained the most recent commit on this branch

# git cat-file -p the commit inside the correct branch
chomp(my @commitFiles = `git cat-file -p $SHA`);
my @firstLine = split(" ", $commitFiles[0]);
my $treeSHA = $firstLine[1]; # Got tree sha

my @authorLines = split(" ", $commitFiles[2]);
my $author = join(" ", $authorLines[1], $authorLines[2], $authorLines[3]);
$author =~ tr/[<>]//d; # remove <> from string
# got the author

my $blobLine;
chomp(my @files = `git cat-file -p $treeSHA`);
# find the file that matches the input, using string matching =~
foreach (@files){
    if($_ =~ /$ARGV[0]/){ $blobLine = $_ } # match to file input
}

# git cat-file -p the blob associated with the file
my @blobList = split(" ", $blobLine);
my $blob;
if($#blobList > 2) { $blob = $blobList[2]; }  #Location of blob SHA

#Final print format
print("Author: " . $author . "\n\nSHA-1 for " . $ARGV[0] . ": " . $SHA . "\n" . 
      `git cat-file -p $blob` . "\n");
} else {
    print("Incorrect Command. Need (only) one input.\n");
    exit -1;
}