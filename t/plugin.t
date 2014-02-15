use Mojo::Base -strict;
use Test::More;

use Mojo::Collection 'c';

use Toastr;
my $t = Toastr->new;

my $died = 0;
local $SIG{__DIE__} = sub { $died++ };

my $p = $t->plugin('Toast');
is $died, 0, 'Loaded correctly';
isa_ok $p, 'Toastr::Plugin::Toast';

my $new_p = $t->load_plugin( 'Toast' => { toast_images => c('test') } );
is $died, 0, 'Reloaded correctly';
isa_ok $new_p, 'Toastr::Plugin::Toast';
isnt $new_p, $p, 'New instance created';
is $new_p->toast_images->[0], 'test', 'Constructor args passed forward correctly';

eval { $t->plugin('DozNotExizt') };

ok $died, 'Died on bad plugin';

done_testing;

