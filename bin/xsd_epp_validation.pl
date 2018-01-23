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

foreach ( qw/epp domain host contact/ ) {
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
  } elsif ( $_ && $_ eq 'host' ) {
    foreach (qw/
      host_check host_check_response
      host_info host_info_response
      host_create host_create_response
      host_delete host_delete_response
      host_update host_update_response/
    ) {
      # load the epp xml command / response for every host action and check if all good
      $xml_doc = XML::LibXML->load_xml(location => './xml/host/'. $_ . '.xml');
      try_catch();
    }
  } elsif ( $_ && $_ eq 'contact' ) {
    foreach (qw/
      contact_check contact_check_response
      contact_info contact_info_response
      contact_transfer_query contact_transfer_query_response
      contact_create contact_create_response
      contact_delete contact_delete_response
      contact_transfer_request contact_transfer_request_response
      contact_update contact_update_response/
    ) {
      # load the epp xml command / response for every contact action and check if all good
      $xml_doc = XML::LibXML->load_xml(location => './xml/contact/'. $_ . '.xml');
      try_catch();
    }
  }
  print "##############################\n\n";
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
  # check if epp xml command / response samples valid or invalid from schemas
  say $is_xml_valid ? "\t$_ - Valid" : "\t$_ - Invalid";
}
