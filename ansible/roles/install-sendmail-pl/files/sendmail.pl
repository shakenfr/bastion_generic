#!/usr/bin/perl -w
use strict;
use Net::SMTP;
use Getopt::Long;
use Net::Domain qw(hostfqdn);

my $_o_subject;
my $_o_from="cpaas_jenkins.portal\@orange.com";
my @_o_to;
my $_o_smarthost=$ENV{MAILHOST};
my $_o_help;
#
### Read command line options
my $result = GetOptions("subject|s=s" => \$_o_subject,
  "from|f=s" => \$_o_from,
    "to|t=s" => \@_o_to,
      "smarthost|D=s" => \$_o_smarthost,
        "help|h" => \$_o_help);
        $result or die &usage();
        $_o_help && die &usage();
        die "(EE) No smarthost specified used -D option\n" unless $_o_smarthost;

        ## Handle recipient list
        push @_o_to,@ARGV;
        @ARGV=();
        die "(EE) You should have at least one recipient\n" if (0 eq @_o_to);

        ## Create connection to the SMTP server
        my $smtp = Net::SMTP->new($_o_smarthost)
         or die "(EE) Could not create SMTP connection\n";
         my $host=hostfqdn;
         $smtp->mail(($_o_from)?$_o_from:$ENV{USER}."@".$host);
         ## Prepare mail recipients
         my @goodrecips=$smtp->recipient(@_o_to,
          { SkipBad => 1 });

          ## Mail data part
          $smtp->data();

          # Send To: headers
          foreach my $to (@_o_to) {
           $smtp->datasend("To: $to\n");
           }

           # Send Subject: header
           $_o_subject && $smtp->datasend("Subject: $_o_subject\n");

           # Message body
           $smtp->datasend("\n");
           my $line;
           while (<>) {
            $smtp->datasend($_);
            }

            # End data part
            $smtp->dataend();

            # Close SMTP connection
            $smtp->quit();

            sub usage () {
             my $usage="
             Usage: mail.pl [OPTIONS] [RECIPIENTS]
             Expects you to write mail on STDIN until you type Ctrl-D or as a pipe, and will
             send the mail via the specified mailhost.
             Example: echo 'Test mail' | ./mail.pl -D mailhost
               -s 'Test mail' toto\@mail.co

               Oprions:
                  -s, --subject Subject of the mail
                     -f, --from  Mail Sender
                        -t, --to  Mail recipient (can be invoked several times)
                           -D, --smarthost SMTP server name or IP address of the mailhost. This can
                              also be specified as environment variable MAILHOST
                                 -h, --help  Writes this help message
                                 ";
                                  return $usage;
                                  }


