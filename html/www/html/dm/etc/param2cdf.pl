#!/usr/local/bin/perl

$global=0;
$pset = 0;
$q = '"';
print 'CDIF,SYNTAX "SYNTAX.1" "01.00.00",ENCODING "ENCODING.1" "01.00.00"
(HEADER
  (USES
    (CHARACTERSET PrintableASCII)
    (TEXTFORMAT Unformatted)
  )
  (SUMMARY
    (ExporterName "Paradigm Plus")
    (ExporterVersion "02.00.00")
    (ExporterDate "1995/6/30")
    (ExporterTime "9:46:44")
  )
)
(META-MODEL
  (CDIFVERSION "01.00.00")
  #|(SCHEMA rumbaugh.pgm)|#
)
(MODEL

';


while(<>){

chop;

if (/^ *$/){ next; }

if (/^# *filename: *(.*)/) {
	$filename = $1;
} elsif (/^# *subsystem: *(.*)/) {
	$subsystem = $1;
} elsif (/^# *filetype: *(.*)/) {
	$filetype = $1;
} elsif (/^# *global params: *(.*)/) {
	$gclassname = $1;
	$global= 1;
print "(Class  $q$gclassname$q
(Name $q$gclassname$q)
(Class $q"."ar"."$gclassname$q)
(Document $q$filetype$q)
(Source $q$subsystem$q)
)\n";

} elsif (/^# *parameter set: *(.*)/) {
	$pclassname = $1;
	$global = 0;
	#if($pset != 0) {
	print "(Class $q$pclassname$q
(Name $q$pclassname$q)
(Class $q"."ar"."$pclassname$q)
(Document $q$filetype$q)
(Source $q$subsystem$q)
)\n";

	 print "(Class.Aggregation.Class $q$gclassname.$pclassname$q $q$gclassname$q $q$pclassname$q)\n"; 
	#}
	$pset++;
} else {
@a = split(" ",$_,2);
$key = $a[0];
$rest = $a[1];
$rest =~ /(.*)(#.*) TYPE:(.*)/;
$iv = $1;
$comment = $2;
$type = $3;

#parse type for [5]

	if($global){
	$cc = $gclassname;
	} else {
	$cc = $pclassname;
	}
	print "(Attribute $q$key$q
(Name $q$key$q)
(Description $q$comment$q)
(Type $q$type$q)
(Initial_Value $q$iv$q)
)\n";

	print "(Class.Attribute $q$cc.$key$q $q$cc$q $q$cc.$key$q)\n";
}

}

print ")\n";
