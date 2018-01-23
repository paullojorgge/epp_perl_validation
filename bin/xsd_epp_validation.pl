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

foreach ( qw/epp domain contact host/ ) {
  print "\n##############################\n";
  print "### Object: " . uc($_) . "\n";
  print "##############################\n";
  # load the schemas for each object. they are located under: xml/schemas
  $xsd_doc = XML::LibXML::Schema->new(location => './xml/schemas/'. $_. '.xsd');
  if ( $_ && $_ eq 'epp' ) {
    foreach (qw/
      hello greeting login login_response logout logout_response
      poll_req poll_ack poll_ack_response
      poll_ack_response2 poll_ack_response3/
    ) {
      # load the epp xml command / response for every epp action and check if all good
      $xml_doc = XML::LibXML->load_xml(location => './xml/epp/'. $_ . '.xml');
      try_catch();
    }
  } elsif ( $_ && $_ eq 'domain' ) {
    foreach (qw/
      domain_check domain_check_response
      domain_info domain_info_with_auth domain_info_response domain_info_response2
      domain_transfer_query domain_transfer_query_response
      domain_create domain_create_response
      domain_delete domain_delete_response
      domain_renew domain_renew_response
      domain_transfer_request domain_transfer_request_response
      domain_update domain_update_response/
    ) {
      # load the epp xml command / response for every domain action and check if all good
      $xml_doc = XML::LibXML->load_xml(location => './xml/domain/'. $_ . '.xml');
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
