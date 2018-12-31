#!/usr/bin/perl
#
# $ Copyright Cypress Semiconductor $
#
#use strict 'vars';


our $wget = "tools/common/Win32/wget";
our $md5sum = "tools/common/Win32/md5sum";
our $bzip2 = "tools/common/Win32/bzip2";
our $tar = "tools/common/Win32/tar";

sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//;       return $s };
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub fetch_component_list {
    my $url       = shift;

    my @lines = `$wget --no-cache -qO- $url`;

    # check return code
    if ( $? != 0 ) { die "Could not download WICED component list from $url" }
    return join( "", @lines );
}


sub copy_in_component
{
    my $component = shift;
    my $manufacturer = shift;
    my $description = shift;
    my $component_url = shift;
    my $component_md5val = shift;



    print "Downloading $component\n";

#    my $junk = `mkdir -p build/downloads/$component/`;
    #my $dir = "build/downloads/$component/";
    #$dir =~ s/\//\\/sgi;
    #print "if not exist $dir mkdir $dir\n";
    #my $junk = `if not exist $dir mkdir $dir`;
    mkdir "build";
    mkdir "build/downloads";
    mkdir "build/downloads/$component";

    # Download the component zip
    #print "command : $wget -O build/downloads/$component.tar.bz2 $component_url\n";
    my @comp_output = `$wget --no-cache -O build/downloads/$component.tar.bz2 $component_url`;

    if ( $? != 0 ) { die "Could not download file for component $component from $component_url" }

    my @md5_output_array = `$md5sum build/downloads/$component.tar.bz2`;

    if ( $? != 0 ) { die "Could not calculate MD5 sum of file for component $component" }

    my $md5_output = join( "", @md5_output_array );
    $md5_output =~ s/^([0123456789abcdef]+) .*$/$1/sgi;
    if ( $md5_output ne $component_md5val )
    {
        die "Zip file corrupted for component $component - MD5 sum does not match!";
    }

    #print "\ncommand: $bzip2 -d -f build/downloads/$component.tar.bz2\n";
    my @unzip_output = `$bzip2 -d -f build/downloads/$component.tar.bz2`;

    if ( $? != 0 ) { die "Could not extract the bzip2 file for component $component ( build/downloads/$component.tar.bz2 ) $?" . join( "", @unzip_output ) }

    #print "\ncommand2 : $tar -xvf build/downloads/$component.tar -C build/downloads/$component/\n";
    my @untar_output = `$tar -xvf build/downloads/$component.tar`;

    if ( $? != 0 ) { die "Could not untar the zip file for component $component ( build/downloads/$component.tar.bz2 )" }


    open( my $fh, ">>", "tools/makefiles/downloaded_components.mk" ) or die "Could not open tools/makefiles/downloaded_components.mk";
    print $fh "\nDOWNLOADED_COMPONENTS   += $component\n";
    print $fh "${component}_MANUFACTURER := $manufacturer\n";
    print $fh "${component}_DESCRIPTION  := $description\n";
    print $fh "${component}_URL          := $component_url\n";
    close( $fh );

#    $wget
}




sub usage
{
    print "Usage:\n";
    print "        ./fetch_component.pl <component> <sdk_version> <url>       (Finds a matching component)\n";
    print "        ./fetch_component.pl *           <sdk_version> <url>       (Lists all available component names)\n\n";
    exit;
}

if (! $ARGV[2] )
{
    usage();
}

my $component = $ARGV[0];
my $sdk_version = $ARGV[1];
my $url = $ARGV[2];

my $component_list = fetch_component_list( $url );


$component_list =~ s/^\#.*$//mgi;
#print "DATA : $component_list\n";

my @available_components;

# Component Name, SDK Version, Manufacturer, Description, URL
while ( $component_list =~ m/^\s*(.*)\s*,\s*(.*)\s*,\s*(.*)\s*,\s*(.*)\s*,\s*(.*),\s*(.*)\s*$/mg )
{
    #print "MATCH : $1\n";
    if ( ( $component ne "*" ) && ( $component eq trim( $1 ) ) && ( $sdk_version eq trim( $2 ) ) )
    {
        my $manufacturer = trim( $3 );
        my $description = trim( $4 );
        my $url = trim( $5 );
        my $md5val = trim( $6 );

        print "Found matching component $component from manufacturer $manufacturer\n\n";

        copy_in_component( $component, $manufacturer, $description, $url, $md5val );

        exit(0);

    }
    if ( $sdk_version eq $2 )
    {
        push @available_components, $1;
    }
}

if ( $component eq "*" )
{
    foreach $tmp_component ( @available_components )
    {
        print "\t$tmp_component\n";
    }
    exit(0);
}

print "Unable to find $component in list of components.\n\n";
if ( scalar( @available_components ) == 0 )
{
    print "None available for this SDK version ($sdk_version)\n"
}
else
{
    print "Available downloadable components for your SDK version:\n";
    foreach $tmp_component ( @available_components )
    {
        print "\t$tmp_component\n";
    }
}

exit(-1);

