use strict;
use warnings; no warnings 'uninitialized';
use Scalar::Util qw(looks_like_number);

my @mask = ("status", "down", "done", "have", "id", "name");
my $fmt = "%+4s %+5s %+10s %-8s %+5s %+5s %+5s %+8s %s";
my @colnames;
my %df;
my %df_fmt;
while (<>) {
	my @data = split;
	if ($. == 1) {
		@colnames = map { lc } @data;
		@df_fmt{@colnames} = split(/ /, $fmt);
	} elsif (eof) {
		$data[1] = $data[1] . ' ' . join(' ', splice @data, 2, 1);
		@data = (("") x 2, @data[1..2], (""), @data[3..4], ("") x 3);
	} else {
		if (looks_like_number($data[2])) {
			$data[2] = $data[2] . ' ' . join(' ', splice @data, 3, 1);
		}
		if (looks_like_number($data[3])) {
			$data[3] = $data[3] . ' ' . join(' ', splice @data, 4, 1);
		}
		if ($data[7] eq 'Downloads') {
			$data[7] = 'Downl';
		}
		$data[8] = $data[8] . ' ' . join(' ', splice @data, 9);
	}
	@df{@colnames} = @data;
	printf join(' ', @df_fmt{@mask}) . "\n", @df{@mask};
}
