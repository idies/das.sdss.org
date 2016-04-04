#!/usr/bin/perl
#
# parseDm.pl
#
# Created by Sebastian Jester 2002/12/09
#
# Parse data model html file (in fact a dump of a fits header) into table with filename,fieldname, unit etc.
#

# setup DM before calling this

$type = $ARGV[0] or die("Please specify a file type\n");
$outfile = $ARGV[1] or die("Please specify an output file\n");
$create = $ARGV[2] or die("Please specify either -create or -append\n");
$dm_dir = $ENV{'DM_DIR'} or die("Could not read environment variable DM_DIR\nPlease setup dm\n") ;
$dmfile = $dm_dir . '/flatFiles/' . $type . '.html';

print "Reading $dmfile\n";
open(DM,"<$dmfile") or die("Can't read from $dmfile\n");
@dmlines = <DM>;
close(DM);
chomp(@dmlines);
if ($create eq '-create') {
    open(OUT,">$outfile");
} elsif ($create eq '-append') {
    open(OUT,">>$outfile");
} else {
    die ("Please specify either -create or -append\n");
}

$ignorevars = '(SIMPLE|BITPIX|NAXIS|EXTEND|PCOUNT|GCOUNT)';

$ii = 0;
$iExtension = 0;
$nheaderfields[0] = 0;
$ncols_hdr[0] = 0;
$ntype[0] = 0;
foreach $line (@dmlines) {
    study($line);
    if ($line =~ /=/)  {
	@parts = split(/=/,$line);
	$variable = $parts[0];
	$slashpos = index($parts[1],"/");
	$value = substr($parts[1],0,$slashpos);
	$comment = substr($parts[1],$slashpos+1);
	$comment =~ s'(^\s*|\s*$)'';#'
	if (@parts < 2) {
	    die("I choked on '$line' because there's not enough to do");
	}
	if ($variable =~ /$ignorevars/) {
	    next;
	}
	# find next extension
	if ($variable =~ /^XTENSION/ && $value =~ /'BINTABLE'/) {
	    $iExtension += 1;
	    $ntype[$iExtension] = 0;
	    $nunit[$iExtension] = 0;
	    $ncols_hdr[$iExtension] = 0;
	    $nheaderfields[$iExtension] = 0;
	    print "Extension $iExtension\n";
	}
	# Find column names etc.
	if ($variable =~ /^(TTYPE|TUNIT)[0-9]+/) {
	    $colnum = substr($variable,5);
	    print "Column number $colnum: ";
	    $entry_type = substr($variable,1,4);
	    @entries = split(/\'/,$value);
	    $entry = $entries[1];
	    $entry =~ s'\s*$'';
	    $comment =~ s'\s*$'';
	    $value =~ s'\s*$'';
	    print "Found $entry_type $entry\n";
	    if ($entry_type eq "TYPE") {
		$colname[$iExtension][$colnum] = $entry;
		$coldesc[$iExtension][$colnum] = $comment;
		$ntype[$iExtension] += 1;
		$lastcol[$iExtension] = $colnum;
	    } elsif ($entry_type eq "UNIT") {
		$unit[$iExtension][$colnum] = $entry;
		$nunit[$iExtension] += 1;
		$lastcol[$iExtension] = $colnum;
	    }
	} elsif ($variable =~ /TFIELDS/) {
	    $ncols_hdr[$iExtension] = $value;
	}
	if ($variable =~ /^[A-Z]/) {
	    if ($variable =~ /(^COMMENT|^TFORM|^TTYPE|^TUNIT|^TSCAL|^T(ZERO|FIELDS)|^TDIM|^XTENSION)/) {
		next;
	    } else {
		# it's a header field
		$hdrfield[$iExtension][$nheaderfields[$iExtension]] = "HDR:$variable";
		@commentfields = split(/[\[\]]/,$comment);
		$hdrdesc[$iExtension][$nheaderfields[$iExtension]] = $commentfields[0];
		$hdrunit[$iExtension][$nheaderfields[$iExtension]] = $commentfields[1];
		$nheaderfields[$iExtension] += 1;
		print "Found: HDR:$variable $commentfields[0] ($commentfields[1])\n"
		}
	}
	$ii += 1;
    }
}
$n_ext = $iExtension;
if ($create eq '-create') {
    print(OUT "FlatFile,HDU,NameInFlatFile,UnitInFlatfile,DescriptionInFlatfile\n");
}
for ($ext = 0; $ext <= $n_ext; $ext += 1) {
    print "# HDUs: $n_ext  # column names: $ntype[$ext] # unit fields: $nunit[$ext] last col. read: $lastcol[$ext] TFIELDS: $ncols_hdr[$ext]\n";
	for ($hfield = 0; $hfield < $nheaderfields[$ext]; $hfield += 1) {
	    print(OUT "\"$type\",\"$ext\",\"$hdrfield[$ext][$hfield]\",\"$hdrunit[$ext][$hfield]\",\"$hdrdesc[$ext][$hfield]\"\n");
	}
	for ($col = 1; $col<=$ntype[$ext]; $col += 1) {
	    print(OUT "\"$type\",\"$ext\",\"$colname[$ext][$col]\",\"$unit[$ext][$col]\",\"$coldesc[$ext][$col]\"\n");
	}
}
close(OUT);
