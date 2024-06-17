;# getopts.pl - a command line option analysis package for Perl 4
;# Usage:
;#    do 'getopts.pl';
;#    &Getopts('aBc');     # -a, -B, -c and -ca are valid options
;#    &Getopts('f:');      # -f and -fa are valid, requires an argument
;#    &Getopts('oD:') or die "Usage: $0 -o -D foo";
;#    &Getopts('d:t:') or die "Usage: $0 -d foo -t bar";
;# Set opt_* as a side effect.
;#
;# License:
;# You may use this code in your own programs provided that you do
;# not publish it for sale or profit.  This notice should appear
;# somewhere in the program documentation.
;#
;# Written by Larry Wall <lwall@netlabs.com>

package main;

sub Getopts {
    local($argumentative) = @_;
    local($_,$first,$rest);

    while(@ARGV && ($_ = $ARGV[0]) =~ /^-(.)(.*)/) {
        ($first,$rest) = ($1,$2);
        if (index($argumentative,$first) >= 0) {
            if (index($argumentative,$first . ':') >= 0) {
                shift(@ARGV);
                if ($rest eq '') {
                    die "Option -$first requires an argument" unless @ARGV;
                    $rest = shift(@ARGV);
                }
                eval "\$opt_$first = \$rest;";
            }
            else {
                eval "\$opt_$first = 1";
                if ($rest ne '') {
                    $ARGV[0] = "-$rest";
                }
                else {
                    shift(@ARGV);
                }
            }
        }
        else {
            die "Unknown option: $first";
        }
    }
}

1;
