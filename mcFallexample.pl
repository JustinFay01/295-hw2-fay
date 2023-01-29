chomp (my @objects = `find .git/objects/2d53 -type f`);
for my $file (@objects) {
  my @paths = split /\//, $file;
  my $folder = $paths[-2];
  my $file = $paths[-1];

  next if $folder =~ /^info/ || $folder =~/^pack/;

if($folder eq substr($ARGV[0], 0, 2)){
    my $sha = "$folder$file";
    chomp (my $type = `git cat-file -t $sha`);
    if($type eq "tree"){
        print "$sha: $type\n";
    }   
    
}
}