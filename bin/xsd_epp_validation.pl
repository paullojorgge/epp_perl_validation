#!/usr/bin/perl

use strict;
use warnings;

use XML::LibXML;
use Try::Tiny qw(try catch);
use experimental qw(say);

# var declaration
my $xml_doc;
my $xsd_doc;
my $is_xml_valid;

# foreach ( qw/epp domain contact host/ ) {
foreach ( qw/epp/ ) {
  print "\n##############################\n";
  print "###Object: " . uc($_) . "\n";
  print "##############################\n";
  $xsd_doc = XML::LibXML::Schema->new(location => './xml/schemas/'. $_. '.xsd');
  if ($_ eq 'epp') {
    foreach (qw/
      hello greeting login login_response logout logout_response
      poll_req poll_req_response poll_ack poll_ack_response
      poll_ack_response2 poll_ack_response3/
    ) {
      $xml_doc = XML::LibXML->load_xml(location => './xml/epp/'. $_ . '.xml');
      try_catch();
    }
  }
  print "##############################\n";
}

# try / catch funtion
sub try_catch {
  $is_xml_valid = try {
    not $xsd_doc->validate($xml_doc);
  }
  catch {
    say '==> ' . $_;
    return 0;
  };

  say $is_xml_valid ? "\t$_ - Valid" : "\t$_ - Invalid";
}
