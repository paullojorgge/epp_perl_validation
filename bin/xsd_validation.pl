#!/usr/bin/perl

use strict;
use warnings;

use XML::LibXML;
use Try::Tiny qw(try catch);
use experimental qw(say);

my $xml_doc = XML::LibXML->load_xml(location => './xml/domain/domain_check_command.xml');
my $xsd_doc = XML::LibXML::Schema->new(location => './xml/schemas/domain.xsd');

my $is_xml_valid = try {
    not $xsd_doc->validate($xml_doc);
}
catch {
    say '==> ' . $_;
    return 0;
};

say $is_xml_valid ? 'Valid' : 'Invalid';
