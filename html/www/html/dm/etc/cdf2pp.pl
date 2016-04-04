#!/usr/local/bin/perl
open(out,">/usrdevel/s1/dm/pgm/genst.scr");
$q = '"';
$xcur = 1250;
$ycur = 150;
$level = 0;
$assoccnt=0;
$aggcnt=0;
$attrcnt=0;
$clcount=0;
while(<>) {
  chop;

  if ( /^ *\(/ ) {
	$level++;
	}
	

	print "$level x$_\n";
  if (/\((.*) "(.*)"/) {
	$key = $1;
	$val = $2;


	if ( $key =~ /(.*) "(.*)" "(.*)"/ ) {

	$triplekey = $1;

	$val1 = $2;


	if ( $triplekey =~ /Class.Association/ ) {
	#print "Class.Association: $val1 \n";
	@c = split(/\./,$val1,2);
	$c0 = $c[0];
	$c1 = $c[1];
	$assoc0[$assoccnt] = $c0;
	$assoc1[$assoccnt++] =  $c1;
	}


	if ( $triplekey =~ /Class.Attribute/ ) {
	#print "Class.Attribute:  $val1 \n";
	@c = split(/\./,$val1,2);
	#print "c0 $c[0] c1 $c[1] val1 $val1\n";
	$c0 = $c[0];
	$c1 = $c[1];
	$attr0[$attrcnt] = $c0;
	$attr1[$attrcnt++] = $c1;
	}


	if ( $triplekey =~ /Class.Aggregation/ ) {
	#print "Class.Aggregation $val1 \n";
	@c = split(/\./,$val1,2);
	$c0 = $c[0];
	$c1 = $c[1];
	$agg0[$aggcnt] =  $c0;
	$agg1[$aggcnt++] =  $c1;
	}


	} else {

	if ( $level == 2 && $key =~ /Class/ ) {
	#print "Class $val\n";
	$cl[$clcnt++] = $val;
	}
	

	}

	}

  if( /\)$/ ) {
	$level--;
  }

}

for($i=0;$i<$aggcnt;$i++){
	$cur = $agg0[$i];
	$other = $agg1[$i];
	print "curr $cur other $other\n";
	if ($x{$cur} eq "" ) {
		$x{$cur} = $xcur;
		$y{$cur} = $ycur;
		$x{$other} = $xcur;
		$y{$other} = $ycur + 600;
		$xcur += 600;
		
	} else {
		$x{$other} = $xcur;
		$y{$other} = $ycur + 600;
		$xcur += 600;
	}
		
}

for($i=0;$i<$clcnt;$i++){
	$cur = $cl[$i];
	$xo = $x{$cur};
	$yo = $y{$cur};
print out "diagram.DrawObject $q"."Class"."$q, $xo, $yo, $q$cur$q\n";
}

for($i=0;$i<$aggcnt;$i++){
	$cur = $agg0[$i];
	$xo = $x{$cur} + 50;
	$yo = $y{$cur} + 10;
	$cur = $agg1[$i];
	$xi = $x{$cur} + 50;
	$yi = $y{$cur};
print out "diagram.DrawLink $q"."Aggregation"."$q, 2, $xo, $yo, $xi, $yi, $q$q\n";
}

for($i=0;$i<$assoccnt;$i++){
	$cur = $assoc0[$i];
	$xo = $x{$cur};
	$yo = $y{$cur};
	$cur = $assoc1[$i];
	$xi = $x{$cur};
	$yi = $y{$cur};
print out "diagram.DrawLink $q"."Association"."$q, 2, $xo, $yo, $xi, $yi, $q$q\n";
}

for($i=0;$i<$attrcnt;$i++){
	$cur = $attr0[$i];
	$cur2 = $attr1[$i];
	$xo = $x{$cur} + $i;
	$yo = $y{$cur} + $i;
print out "diagram.DrawObject $q"."Attribute"."$q, $xo, $yo, $q$cur2$q\n";
}

close(out);
