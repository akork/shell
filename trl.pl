use strict;
use warnings; no warnings 'uninitialized';

my @idx = (7,   1,   5,   2,   0,   8);
my $fmt = "%+7s %+5s %-6s %+8s %+4s %s\n";
while (<>) {
	my @data = split;
	if ($. == 1) {
		@data = (@data[0..1], (""), @data[2..$#data]);
	}
	if (eof) {
		@data = (("") x 2, @data[1..2], (""), @data[3..4], ("") x 3);
	}
	$data[9] = $data[9] . ' ' . join(' ', splice @data, 10);
	$data[2] = $data[2] . ' ' . join(' ', splice @data, 3, 1);
	printf $fmt, @data[@idx];
}
