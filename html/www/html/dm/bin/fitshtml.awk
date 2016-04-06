BEGIN { 
  hdu = 0;
  print "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  print "<HTML>";
  print "<HEAD>";
  print "<TITLE>DM from fits header</TITLE>";
  print "<STYLE TYPE=\"text/CSS\">";
  print "<!--"
  print "DT {font-weight: bold}";
  print "-->"
  print "</STYLE>";
  print "</HEAD>";
  print ""
  print "<BODY>";
  print "<H1>DM from fits header</H1>";
  print "<DL>";
  print "<DT>File Format:</DT>";
  print "<DD>FITS</DD>";
  print "<DT>Name:</DT>";
  print "<DD>foo.fits</DD>";
  print "<DT>Produced by:</DT>";
  print "<DD>bar</DD>";
  print "<DT>Used by:</DT>";
  print "<DD>baz</DD>";
  print "<DT>Size:</DT>";
  print "<DD>qux</DD>";
  print "<DT>Archived?</DT>";
  print "<DD>Yes</DD>";
  print "</DL>";
  print ""
  print "<H2>Description</H2>"
  print "<P>Foo bar baz</P>"
  print ""
}

/^SIMPLE  =/ {
  print "<H2>Primary HDU</H2>";
  print "<PRE>"
  inheader = 1;
  hdu++;
}


/^XTENSION=/ {
  inheader = 1;
  printf("<H2>HDU%d</H2>\n",hdu);
  print "<PRE>"
  hdu++;
}

/^END/ { 
  print "</PRE>"
  inheader = 0
}

inheader == 1 {print $0}

END {
  print "</BODY>"
  print "</HTML>"
}

