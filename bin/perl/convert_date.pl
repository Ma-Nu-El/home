# #!/usr/bin/env perl

use strict;
use warnings;

# Function to convert date format
sub convert_date_format {
    my ($input_date) = @_;

    # Pattern to match 'dd/mm/yyyy' and capture day, month, year
    if ($input_date =~ /(\d{2})\/(\d{2})\/(\d{4})/) {
        return "$3-$2-$1"; # Rearrange to 'yyyy-mm-dd'
    } else {
        return "Invalid date format";
    }
}

# Check if a date argument is provided
if (@ARGV != 1) {
    die "Usage: scriptname.pl dd/mm/yyyy\n";
}

my $input_date = $ARGV[0];
print convert_date_format($input_date), "\n";

