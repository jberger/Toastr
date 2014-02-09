package Toastr::Plugin::Dhammapada;

use Mojo::Base 'Toastr::Plugin';
use Mojo::Collection 'c';
use Mojo::UserAgent;

has versets => sub { c() };

sub get_versets() {
    my $self = shift;
    my @data = do {
        local $/ = '';
        <DATA>;
    };
    my $verses = $self->versets;
    my @versets = grep {/\n(.*)[\d+]/m} @data;
    my @real = splice( @versets, 4, @versets );
    push @$verses, @real;
}

sub register {
    my ( $self, $irc ) = @_;
    $self->get_versets;    # populate (once the iolooop starts)
    $irc->on(
        toastr_message => sub {
            my ( $irc, $msg ) = @_;
            my $text = $msg->text;
            if ( $text =~ /dhammapada/i ) {
                $irc->emit( print_verset => $msg->chan );
            }
        }
    );
    $irc->on(
        print_verset => sub {
            my ( $irc, $chan ) = @_;
            my $verse = $irc->dhammapada->versets->shuffle->[0];
            $verse=~tr{\n}{ };
            $irc->msg( $chan => $verse );
        }
    );
}

1;

__DATA__
[This document can be acquired from a sub-directory coombspapers via
anonymous FTP and/or COOMBSQUEST gopher on the node COOMBS.ANU.EDU.AU]

The document's ftp filename and the full directory path are given in
the coombspapers top level INDEX file]

[This version: 15 November 1993]
-----------------------------------------------------------------------
THE DHAMMAPADA

An anthology of 423 Buddhist verses embodying ethical and spiritual
precepts arranged by subject.

Translated from Pali by John Richards.

Copyright (c) 1993 John Richards, Pembrokeshire (UK)
Internet - jhr@elidor.demon.co.uk, CompuServe ID - 100113,1250


The Dhammapada - Information

The Dhammapada is an anthology of verses, belonging to the part of the
Theravada Pali Canon of scriptures known as the Khuddaka Nikaya, and
consists of 423 verses.

Something like a quarter of the verses are to be found in other parts of
the Pali Tipitaka, particularly in the other verse parts of the Khuddaka
Nikaya such as the Sutta Nipata and the Thera- and Theri-gatha.

The Dhammapada is probably the most popular book of the Pali Canon, with
the possible exception of the Satipatthana Sutta, or the Sutta on the
Turning of the Wheel of the Law (Dhamma-cakka-ppavattana Sutta). It is
certainly the most frequently translated portion.

There are a number of Mahayana works to which it appears to be closely
related. There are in the Chinese scriptures 4 works resembling the
Dhammapada. The nearest is the Fa Chu Ching, which was translated in AD
223. (translated by Beal), the first part of which seems to be a direct
translation of the Pali Dhammapada. (It is intriguing to wonder how a
Pali work found its way to China in those early years. The Introduction
merely says it was brought from India and was translated as a joint
venture by a Chinese and an Indian.) One small piece of evidence that
the Chinese is a translation from the Pali is found in the verse
corrsponding to the Pali verse 146. The Chinese here reads "remembering
the everlasting burnings", having mistaken the word "sati", (which in
the Pali is the locative case of the present participle of a verb for
"being") for the noun "sati", memory, or recollection. The later part of
the Chinese appears to be an anthology in its own right.

There is also a Dhammapada in the Gandhari language (edited and
translated by Brough), but although it contains at least half of its
verses in common with the Pali Dhammapada, the order and distribution
make it fairly certain that there is no direct link between the two
works.

There is another work in Sanskrit called the Udanavarga, which also has
a large number of verses in common with the Dhammapada, but again seems
to be a completely independent compilation. It is often most instructive
though to compare some of the verses in these different collections.
Sometimes they are effectively identical, but at other times they are
radically different. It would be a rash man, in our present state of
scholarship, who ventured to assert which is the original.

Like most anthologies of verses, the Dhammapada is very uneven. Some
verses are both profound and deeply poetic. Others are awkward, and
little more than a list of technical terms. The overall effect of the
Dhammapada however is undoubtedly of high moral and spiritual
earnestness, and a typically Buddhist gentle persuasiveness. It would be
hard to point to a poetic book of a similar length in world religious
literature of a correspondingly sustained level.
  - John Richards (19.Oct.1993)
-------------------------------------------------------------------------
The Dhammapada
(An Anthology of Verses)

1. The Pairs

Mind precedes its objects. They are mind-governed and mind-made. To
speak or act with a defiled mind is to draw pain after oneself, like a
wheel behind the feet of the animal drawing it. 1

Mind precedes its objects. They are mind-governed and mind-made. To
speak or act with a peaceful mind, is to draw happiness after oneself,
like an inseparable shadow. 2

I have been insulted! I have been hurt! I have been beaten! I have been
robbed! Anger does not cease in those who harbour this sort of thought.
3

I have been insulted! I have been hurt! I have been beaten! I have been
robbed! Anger ceases in those who do not harbour this sort of thought. 4

Occasions of hatred are certainly never settled by hatred. They are
settled by freedom from hatred. This is the eternal law. 5

Others may not understand that we must practice self-control, but
quarrelling dies away in those who understand this fact. 6

The Tempter masters the lazy and irresolute man who dwells on the
attractive side of things, ungoverned  in his senses, and unrestrained
in his food, like the wind overcomes a rotten tree. 7

But the Tempter cannot master a man who dwells on the distasteful side
of things, self- controlled in his senses, moderate in eating, resolute
and full of faith, like the wind cannot move a mountain crag. 8

The man who wears the yellow-dyed robe but is not free from stains
himself, without self- restraint and integrity, is unworthy of the robe.
9

But the man who has freed himself of stains and has found peace of mind
in an upright life, possessing self-restraint and integrity, he is
indeed worthy of the dyed robe. 10

To see the essence in the unessential and to see the essence as
unessential means one can never get to the essence, wandering  as one is
in the road of wrong intentions. 11

But to see the essence in the essential and the unessential as the
unessential it is means one does get to the essence, being on the road
of right intentions. 12

In the same way that rain breaks into a house with a bad roof, desire
breaks into the mind that has not been practising meditation. 13

While in the same way that rain cannot break into a well-roofed house,
desire cannot break into a mind that has been practising meditation
well. 14

Here and beyond he suffers. The wrong-doer suffers both ways. He suffers
and is tormented to see his own depraved behaviour. 15

Here and beyond he is glad. The doer of good is glad both ways. He is
glad and rejoices to see his own good deeds. 16

Here and beyond he is punished. The wrong-doer is punished both ways. He
is punished by the thought, "I have done evil", and is even more
punished when he comes to a bad state. 17

Here and beyond he rejoices. The doer of good rejoices both way. He
rejoices at the thought, "I have done good", and rejoices even more when
he comes to a happy state. 18

Even if he is fond of quoting appropriate texts, the thoughtless man who
does not put them into practice himself is like cowherd counting other
people's cows, not a partner in the Holy Life. 19

Even if he does not quote appropriate texts much, if he follows the
principles of the Teaching by getting rid of greed, hatred and delusion,
deep of insight and with a mind free from attachment, not clinging to
anything in this world or the next - that man is a partner in the Holy
Life. 20

2. Attention

Attention leads to immortality. Carelessness leads to death. Those who
pay attention will not die, while the careless are as good as dead
already. 21

So having clearly understood the value of attention, wise men take
pleasure in it, rejoicing in what the saints have practised. 22

Those who meditate with perseverance, constantly working hard at it, are
the wise who experience Nirvana, the ultimate freedom from chains. 23

When a man is resolute and recollected, pure of deed and persevering,
when he is attentive and self-controlled and lives according to the
Teaching, his reputation is bound to grow. 24

By resolution and attention, by discipline and self-control, a clever
man may build himself an island that no flood can overthrow. 25

Foolish, ignorant people indulge in careless lives, whereas a clever man
guards his attention as his most precious possession. 26

Don't indulge in careless behaviour. Don't be the friend of sensual
pleasures. He who meditates attentively attains abundant joy. 27

When a wise man has carefully rid himself of carelessness and climbed
the High Castle of Wisdom, sorrowless he observes sorrowing people, like
a clear-sighted man on a mountain top looking down on the people with
limited vision on the ground below. 28

Careful amidst the careless, amongst the sleeping wide-awake, the
intelligent man leaves them all behind, like a race-horse does a mere
hack. 29

It was by attention that Indra attained the highest place among the
gods. People approve of attention, while carelessness is always
condemned. 30

A bhikkhu taking pleasure in being attentive, and recognising the danger
of carelessness, makes progress like a forest fire, consuming all
obstacles large or small in his way. 31

A bhikkhu taking pleasure in being attentive, and recognising the danger
of carelessness, is incapable of falling away. In fact he is already
close to Nirvana. 32

3. Thoughts

Elusive and unreliable as it is, the wise man straightens out his
restless, agitated mind, like a fletcher crafting an arrow. 33

Trying to break out of the Tempter's control, one's mind writhes to and
fro, like a fish pulled from its watery home onto dry ground. 34

It is good to restrain one's mind, uncontrollable, fast moving, and
following its own desires as it is. A disciplined mind leads to
happiness. 35

A wise man should guard his mind for it is very hard to keep track of,
extremely subtle, and follows its own desires. A guarded mind brings
happiness. 36

The mind goes wandering off far and wide alone. Incorporeal, it dwells
in the cavern of the heart. Those who keep it under control escape from
Mara's bonds. 37

If he is unsettled in mind, does not know the true Teaching, and has
lost his peace of mind, a man's wisdom does not come to fulfilment. 38

With his mind free from the inflow of thoughts and from restlessness, by
abandoning both good and evil, an alert man knows no fear. 39

Seeing your body as no better than an earthen pot, make war on Mara with
the sword of wisdom, and setting up your mind as a fortress, defend what
you have won, remaining free from attachment. 40

Before long this body will be lying on the ground, discarded and
unconscious, like a useless bit of wood. 41

One's own misdirected thought can do one more harm than an enemy or an
ill-wisher. 42

Even your mother, father or any other relative cannot do you as much
good as your own properly directed thought. 43

4. Flowers

Who will master this world and the world of Death with its devas? Who
will gather well taught aphorisms (dhammapadas), like an connoisseur
picking a flower? 44

A disciple will master this world and the world of Death with its devas.
A disciple will gather well taught aphorisms (dhammapadas), like a
connoisseur picking a flower. 45

Seeing the foam-like nature of the body, and awakening to its
mirage-like quality, one can escape the sight of the King of Death,
snapping Mara's flowery bonds. 46

Death carries off a man busy picking flowers with an besotted mind, like
a great flood does a sleeping village. 47

Death, the end-maker, will exercise his will on a man busy picking
flowers with a besotted mind, before he has even found satisfaction. 48

A holy man should behave in the village like a bee which takes its food
from a flower without hurting its appearance or its scent. 49

It is no the shortcomings of others, nor what others have done or not
done that one should think about, but what one has done or not done
oneself. 50

Like a fine flower, beautiful to look at but without scent, fine words
are fruitless in a man who does not act in accordance with them. 51

Like a fine flower, beautiful to look at and scented too, fine words
bear fruit in a man who acts well in accordance with them. 52

Just as one can make a lot of garlands from a heap of flowers, so man,
subject to birth and death as he is, should make himself a lot of good
karma. 53

The scent of flowers cannot travel against the wind, and nor can that of
sandalwood or jasmine, but the fragrance of the good does travel against
the wind, and a good man perfumes the four quarters of the earth. 54

Sandalwood, tagara, lotus, jasmine - the fragrance of virtue is
unrivalled by such kinds of perfume. 55

The perfume of tagara and sandalwood is of little enough power, while
the supreme fragrance, that of the virtuous, reaches even up to the
devas. 56

Perfect of virtue, always acting with recollection, and liberated by
final realisation - Mara does not know the path such people travel. 57

Like a beautiful, fragrant lotus, springing up on a pile of rubbish
thrown out on the highway, so a disciple of the Enlightened One stands
out among rubbish-like and blinded ordinary people by virtue of his
wisdom. 58, 59

5. The Fool

Long is the night for the sleepless. Long is the road for the weary.
Long is samsara (the cycle of continued rebirth) for the foolish, who
have not recognised the true teaching. 60

If on one's way one does not come across one's better or an equal, then
one should press on resolutely alone. There is no companionship with a
fool. 61

"I've got children", "I've got wealth." This is the way a fool brings
suffering on himself. He does not even own himself, so how can he have
children or wealth? 62

A fool who recognises his own ignorance is thereby in fact a wise man,
but a fool who considers himself wise - that is what one really calls a
fool. 63

Even if a fool lived with a wise man all his life, he would still not
recognise the truth, like a wooden spoon cannot recognise the flavour of
the soup. 64

Even if a man of intelligence lives with a wise man only for a moment,
he will immediately recognise the truth, like one's tongue recognises
the flavour of the soup. 65

Stupid fools go through life as their own enemies, doing evil deeds
which have bitter consequences. 66

A deed is not well done if one suffers after doing it, if one bears the
consequences sobbing and with tears streaming down one's face. 67

But a deed is well done if one does not suffer after doing it, if one
experiences the consequences smiling and contented. 68

A fool thinks it like honey so long as the bad deed does not bear fruit,
but when it does bear fruit he experiences suffering. 69

Even if a fool were to take his food month after month off the tip of a
blade of grass, he would still not be worth a fraction of those who have
understood the truth. 70

Like fresh milk a bad deed does not turn at once. It follows a fool
scorching him like a smouldering fire. 71

A fool acquires knowledge only to his own disadvantage. It destroys what
good he has, and turns his brains. 72

One may desire a spurious respect and precedence among one's fellow
monks, and the veneration of outsiders. "Both monks and laity should
think it was my doing. They should accept my authority in all matters
great or small." This is a fool's way of thinking. His self-seeking and
conceit just increase. 73, 74

One way leads to acquisition, the other leads to nirvana. Realising this
a monk, as a disciple of the Buddha, should take no pleasure in the
respect of others, but should devote himself to solitude. 75

6. The Wise Man

Like one pointing out hidden treasure, if one finds a man of
intelligence who can recognise one's faults and take one to task for
them, one should cultivate the company of such a wise man. He who
cultivates a man like that is the better for it, not worse. 76

If a man disciplines, instructs and restrains them from what is not
right, he will be dear to the good, and disliked by the bad. 77

Don't cultivate the company of bad companions. Don't cultivate depraved
men. Cultivate companions of good character. Cultivate superior men. 78

He who drinks in the Truth will live happily with a peaceful mind. A
wise man always delights in the Truth taught by the saints. 79

Navvies channel water, fletchers fashion arrows, and carpenters work on
wood, but the wise disciple themselves. 80

Like a solid rock is not shaken by the wind, so the wise are not moved
by praise or blame. 81

The wise find peace on hearing the truth, like a deep, clear,
undisturbed lake. 82

The good renounce everything. The pure don't babble about sensual
desires. Whether touched by pleasure or pain, the wise show no change of
temper. 83

If a man does not seek children, wealth or power either for himself or
for someone else, if he does not seek his own advantage by unprincipled
means, he is a virtuous man, a wise man and a righteous man. 84

Few are those among men who have crossed over to the other shore, while
the rest of mankind runs along the bank. However those who follow the
principles of the well-taught Truth will cross over to the other shore,
out of the dominion of Death, hard though it is to escape. 85, 86

A wise man, abandoning the principle of darkness, should cultivate what
is pure. Leaving home for the homeless life, let him seek his joy in the
solitude which people find so hard to enjoy, and, abandoning sensual
pleasures, let him cleanse himself of inner defilements, looking on
nothing as his own. 87, 88

Those whose minds are thoroughly practices in the factors of
enlightenment, who find delight in freedom from attachment in the
renunciation of clinging, free from the inflow of thoughts, they are
like shining lights, having reached final liberation in the world. 89

7. The Enlightened

Journey over, sorrowless, freed in every way, and with all bonds broken
- for such a man there is no more distress. 90

The recollected go forth to lives of renunciation. They take no pleasure
in a fixed abode. Like wild swans abandoning a pool, they leave one
resting place after another. 91

Those for whom there is no more acquisition, who are fully aware of the
nature of food, whose dwelling place is an empty and imageless release -
the way of such people is hard to follow, like the path of birds through
the sky. 92

He whose inflowing thoughts are dried up, who is unattached to food,
whose dwelling place is an empty and imageless release - the way of such
a person is hard to follow, like the path of birds through the sky. 93

When a man's senses have come to peace, like a horses well broken by the
trainer, when he is rid of conceit and without inflowing thoughts - even
devas envy such a well set man. 94

Like the earth he is not disturbed, like a great pillar he is firmly set
and reliable, like a lake he is free from defilement. There are no more
rebirths for such a well set man. 95

Freed by full realisation and at peace, the mind of such a man is at
peace, and his speech and action peaceful. 96

He has no need for faith who knows the uncreated, who has cut off
rebirth, who has destroyed any opportunity for good or evil, and cast
away all desire. He is indeed the ultimate man. 97

Whether in the village or the forest, whether on high ground or low,
wherever the enlightened live, that is a delightful spot. 98

Delightful for them are the forests where men find no delight. The
desire-free find delight there, for they seek no sensual joys. 99

8. The Thousands

Better than a thousand pointless words is one saying to the point on
hearing which one finds peace. 100

Better than a thousand pointless verses is one stanza on hearing which
one finds peace. 101

Better than reciting a hundred pointless verses is one verse of the
teaching (one dhammapada) on hearing which one finds peace. 102

Though one were to defeat thousands upon thousands of men in battle, if
another were to overcome just one - himself, he is the supreme victor.
103

Victory over oneself is better than that over others. When a man has
conquered himself and always acts with self-control, neither devas,
spirits, Mara or Brahma can reverse the victory of a man like that. 104,
105

Though one were to perform sacrifices by the thousand month after month
for a hundred years, if another were to pay homage to a single inwardly
perfected man for just a moment, that homage is better than the hundred
years of sacrifices. 106

Though one were to tend the sacrificial fire for a hundred years in the
forest, if another were to pay homage to a single inwardly perfected man
for just a moment, that homage is better than the hundred years of
sacrifice. 107

All the sacrifices and offerings a man desiring merit could make in a
year in the world are not worth a quarter of the better merit of homage
to the righteous. 108

Four principal things increase in the man who is respectful and always
honours his elders - length of life, good looks, happiness and health.
109

Though one were to live a hundred years immoral and with a mind
unstilled by meditation, the life of a single day is better if one is
moral and practises meditation. 110

Though one were to live a hundred years without wisdom and with a mind
unstilled by meditation, the life of a single day is better if one is
wise and practises meditation. 111

Though one were to live a hundred years lazy and effortless, the
life of a single day is better if one makes a real effort. 112

Though one were to live a hundred years without seeing the rise and
passing of things, the life of a single day is better if one sees the
rise and passing of things. 113

Though one were to live a hundred years without seeing the deathless
state, the life of a single day is better if one sees the deathless
state. 114

Though one were to live a hundred years without seeing the supreme
truth, the life of a single day is better if one sees the supreme truth.
115

9. Evil

Be urgent in good; hold your thoughts off evil. When one is slack in
doing good the mind delights in evil. 116

If a man has done evil, let him not keep on doing it. Let him not create
an inclination to it. The accumulation of evil means suffering. 117

If a man has done good, let him keep on doing it. Let him create an
inclination to it. The accumulation of good means happiness. 118

An evil man encounters good so long as his evil behaviour does not bear
fruit, but when his evil behaviour bears fruit, then the evil man
encounters the evil consequences. 119

An good man encounters evil so long as his good behaviour does not bear
fruit, but when his good behaviour bears fruit, then the good man
encounters the good consequences. 120

Do not think lightly of evil that not the least consequence will come of
it. A whole waterpot will fill up from dripping drops of water. A fool
fills himself with evil, just a little at a time. 121

Do not think lightly of good that not the least consequence will come of
it. A whole waterpot will fill up from dripping drops of water. A wise
man fills himself with good, just a little at a time. 122

One should avoid evil like a merchant with much goods and only a small
escort avoids a dangerous road, and like a man who loves life avoids
poison. 123

If there is no wound on one's hand, one can handle poison. Poison has no
effect where there is no wound. There is no evil for the non-doer. 124

Whoever does harm to an innocent man, a pure man and a faultless one,
the evil comes back on that fool, like fine dust thrown into the wind.
125

Some are reborn in a human womb, evil-doers go to hell, the good go to
heaven, and those without inflowing thoughts achieve final liberation.
126

Not in the sky, nor in the depths of the sea, nor hiding in the cleft of
the rocks, there is no place on earth where one can take one's stand to
escape from an evil deed. 127

Not in the sky, nor in the depths of the sea, nor hiding in the cleft of
the rocks, there is no place on earth where one can take one's stand to
not be overcome by death. 128

10. Violence

All fear violence, all are afraid of death. Seeing the similarity to
oneself, one should not use violence or have it used. 129

All fear violence, life is dear to all. Seeing the similarity to
oneself, one should not use violence or have it used. 130

He who does violence to creatures seeking happiness like himself does
not find happiness after death. 131

He who does no violence to creatures seeking happiness like himself does
find happiness after death. 132

Don't speak harshly to anyone. If you do people will speak to you in the
same way. Harsh words are painful and their retaliation will hurt you.
133

If you don't disturb yourself, like a broken gong does not vibrate, then
you have achieved nirvana. Irritability no longer exists for you. 134

Like a cowherd driving cows off to the fields, so old age and death take
away the years from the living. 135

Even when he is doing evil, the fool does not realise it. The idiot is
punished by his own deeds, like one is scorched by fire. 136

He who does violence to the peaceful and harmless soon encounters one of
ten things - He may experience cruel pain, disaster, physical injury,
severe illness, or insanity, or else trouble with the authorities, grave
accusation, bereavement, or loss of property, or else destruction of his
house by fire, and on the death of his body the fool goes to hell. 137,
138, 139, 140

Neither naked asceticism, matted hair, dirt, fasting, sleeping on the
ground, dust and mud, nor prolonged sitting on one's heels can purify a
man who is not free of doubts. 141

Even if richly dressed, when a man behaves even-mindedly and is at
peace, restrained and established in the right way, chaste and
renouncing violence to all forms of life, then he is a brahmin, he is a
holy man, he is a bhikkhu (true Buddhist monk). 142

Where is that man in the world who is so restrained by shame that he
avoids laziness like a thoroughbred horse avoids the whip? 143

Like a thoroughbred horse touched by the whip, be strenuous and
determined. Then you will be able to rid yourself of this great
suffering by means of faith, morality, energetic behaviour, stillness of
mind and reflection on the teaching, after you have become full of
wisdom, good habits and recollection. 144

Navvies channel water, fletchers fashion arrows, and carpenters work on
wood, but the good disciple themselves. 145

11. Old Age

What is this laughter, what is this delight, forever burning (with
desires) as you are? Enveloped in darkness as you are, will you not look
for a lamp? 146

Look at the decorated puppet, a mass of wounds and of composite parts,
full of disease and always in need of attention. It has no enduring
stability. 147

This body is worn out with age, a nest of diseases and falling apart.
The mass of corruption disintegrates, and death is the end of life. 148

When these grey bones are cast aside like gourds in autumn, what
pleasure will there be in looking at them? 149

It is a city built of bones, and daubed with flesh and blood, in which
old age and death, pride and hypocrisy are the inhabitants. 150

Even kings' splendid carriages wear out, and the body is certain bound
to grow old, but the Truth found by the saints is not subject to aging.
That is what the saints themselves proclaim. 151

An ignorant man ages like an ox. His flesh may increase, but not his
understanding. 152

I have passed in ignorance through a cycle of many rebirths, seeking the
builder of the house. Continuous rebirth is a painful thing. But now,
housebuilder, I have found you out. You will not build me a house again.
All your rafters are broken, your ridge-pole shattered. My mind is free
from active thought, and has made an end of craving. 153, 154

Those who have not lived the holy life, and have not acquired wealth in
their youth, grow old like withered cranes beside a fishless pool. 155

Those who have not lived the holy life, and have not acquired wealth in
their youth, lie like spent arrows, grieving for times past. 156

12. Self

Knowing that one is dear to oneself, one should guard oneself well. For
one out of the three watches of the night a wise man should keep watch.
157

First he should establish himself in what is right. Then if he teaches
others, the wise man will not be corrupted. 158

If one would only apply to oneself what one teaches others, when one was
well disciplined oneself one could train others. It is oneself who is
hard to train. 159

One is one's own guardian. What other guardian could one have? With
oneself well disciplined one obtains a rare guardian indeed. 160

The evil he has done himself and which had its origin and being in
himself breaks a fool, like a diamond breaks a precious stone. 161

A man of great immorality is like a creeper, suffocating the tree it is
on. He does to himself just what an enemy would wish him. 162

Things which are wrong and to one's own disadvantage are easily enough
done, while what is both good and advantageous is extremely hard to do.
163

The fool, who out of attachment to a wrong view speaks ill of the
religion of the enlightened and noble ones who live according to truth,
brings forth fruit to his own downfall, like the offspring of the
bamboo. 164

By oneself one does evil. By oneself one is defiled. By oneself one
abstains from evil. By oneself one is purified. Purity and impurity are
personal matters. No one can purify someone else. 165

One should not neglect one's own welfare for that of someone else,
however great. When one has understood what one's own welfare really
consists of, one should apply oneself to that welfare. 166

13. The World

Don't practice an ignoble way of life, don't indulge in a careless
attitude. Don't follow a wrong view, and don't be attached to the world.
167

Wake up and don't be careless, but lead a life of well-doing. He who
follows righteousness lives happily in this world and the next. 168

Lead a life of righteousness, and not a life of wrong-doing. He who
follows righteousness lives happily in this world and the next. 169

Look on the world as a bubble, look on it as a mirage. The King of Death
never finds him who views the world like that. 170

Come, look at the world as a gilded royal carriage, in which fools get
bogged down, while men of understanding have no attachment to it. 171

Even if previously careless, when a man later stops being careless, he
illuminates the world, like the moon breaking away from a cloud. 172

When a man's bad deeds are covered over by good ones, he illuminates the
world, like the moon breaking away from a cloud. 173

Blinded indeed is this world. Few are those who see the truth. Like a
bird breaking out of the net, few are those who go to heaven. 174

Wild swans take the path of the sun. Men with powers travel through
space, but the wise step right out of the world, by conquering Mara and
his host. 175

When a man has already violated one rule, when he is a liar and rejects
the idea of a future world, there is no evil he is not capable of. 176

Miserly people certainly do not go to heaven. Fools for sure do not
praise generosity, but the wise man who takes pleasure in giving is
thereby happy hereafter. 177

Better than being sole king of the whole earth, better than going to
heaven or sovereignty over the whole universe is the fruit of becoming a
stream-winner. 178

14. Buddhas

He whose victory is not relost, and whose victory no-one in the world
can take away, that Buddha, whose home is in the infinite, pathless as
he is, by what path will you lead him? 179

He who has no entrapping, clinging desire to lead him in any direction,
that Buddha, whose home is in the infinite, pathless as he is, by what
path will you lead him? 180

Those wise men, who are much given to meditation and find pleasure in
the peace of a spiritual way of life, even the devas envy them perfect
Buddhas and recollected as they are. 181

A human birth is hard to achieve. Difficult is the life of mortals. To
hear the true teaching is difficult, and the achievement of Buddhahood
is difficult. 182

To abstain from all evil, the practice of good, and the thorough
purification of one's mind - this is the teaching of the Buddhas. 183

Long-suffering patience is the supreme ascetic practice. Nirvana is
supreme, say the Buddhas. He is certainly not an ascetic who hurts
others, and nor is he a man of religion who causes suffering to others.
184

Not to speak harshly and not to harm others, self restraint in
accordance with the rules of the Order, moderation in food, a secluded
dwelling, and the cultivation of the higher levels of consciousness -
this is the teaching of the Buddhas. 185

There is no satisfying the senses, not even with a shower of money. "The
senses are of slight pleasure and really suffering." When a wise man has
realised this, he takes no pleasure, as a disciple of the Buddhas, even
in the pleasures of heaven. Instead he takes pleasure in the elimination
of craving. 186, 187

Driven by fear, men take to many a refuge, in mountains, forests, parks,
sacred groves and shrines, but these are not a secure kind of refuge. By
taking to this sort of refuge one is not released from suffering. He who
has gone to Buddha, Dhamma and Sangha for refuge, though, and who with
true wisdom understands the Four Noble Truths of Suffering, the Origin
of Suffering, the End of Suffering and the Noble Eightfold Path, leading
to the Elimination of Suffering, this is a secure refuge, this is the
ultimate refuge; by taking to this refuge one is indeed released from
all suffering. 188, 189, 190, 191, 192

A truly thoroughbred man (a Buddha) is hard to find. He is not born
anywhere, but where that seer is born, the people prosper. 193

Happy is the attainment of Buddhahood, happy the teaching of the true
Teaching, happy is the concord of the Sangha, happy the training of
those in concord. 194

When a man venerates those worthy of veneration, be they Buddhas or
their disciples, who have transcended all obstacles and passed beyond
sorrow and tears - venerating such as these, whose passions are
extinguished and for whom there is no further source for fear, no one
can calculate how great his merit is. 195, 196

15. Happiness

Happy indeed we live who are free from hatred among those who still
hate. In the midst of hate-filled men, we live free from hatred. 197

Happy indeed we live who are free from disease among those still
diseased. In the midst of diseased men, we live free from disease. 198

Happy indeed we live who are free from worry among those who are still
worried. In the midst of worried men, we live free from worry. 199

Happy indeed we live who have nothing of our own. We shall feed on joy,
just like the radiant devas. 200

A victor only breeds hatred, while a defeated man lives in misery, but a
man at peace within lives happily, abandoning up ideas of victory and
defeat. 201

There is no fire like desire. There is no weakness like anger. There is
no suffering like the khandhas. There is no happiness greater than
peace. 202

Hunger is the supreme disease. Mental activity is the supreme suffering.
When one has grasped this as it really is, nirvana is the supreme
happiness. 203

Health is the supreme possession. Contentment is the supreme wealth. A
trustworthy friend is the supreme relation. Nirvana is the supreme
happiness. 204

After enjoying the taste of solitude and the taste of peace, one is
freed from distress and evil, as one enjoys the taste of spiritual joy.
205

It is good to meet with the saints. Living with them is always sweet. By
not meeting fools one can be happy all the time. 206

A man who keeps company with a fool, will suffer for it a long time. It
is always painful to live with fools, like with an enemy, but a wise man
is good to live with, like meeting up with relatives. 207

Therefore, if he is a man of understanding and penetration, learned and
habitually moral, devout and noble, one should cultivate the company of
that just and wise man, in the same way as the moon keeps to a path
among the stars. 208

16. Preference

He who applies himself to what is not really an appropriate subject for
application, and fails to apply himself to what is, missing the real
purpose to grasp after what appeals to him, may well envy the man who
does apply himself. 209

Never have anything to do with likes and dislikes. The absence of what
one likes is painful, as is the presence of what one dislikes. 210

Therefore don't take a liking to anything. To lose what one likes is
hard, but there are no bonds for those who have no likes and dislikes.
211

From preference arises sorrow, from preference arises fear, but he who
is freed from preference has no sorrow and certainly no fear. 212

From affection arises sorrow, from affection arises fear, but he who is
freed from affection has no sorrow and certainly no fear. 213

From pleasure arises sorrow, from pleasure arises fear, but he who is
freed from pleasure has no sorrow and certainly no fear. 214

From sensuality arises sorrow, from sensuality arises fear, but he who
is freed from sensuality has no sorrow and certainly no fear. 215

From craving arises sorrow, from craving arises fear, but he who is
freed from craving has no sorrow and certainly no fear. 216

Well may people hold dear the man who is endowed with morality and
insight, who is well established in righteousness, a seer of the truth,
and applying himself to his own business. 217

He whose longing has been aroused for the indescribable, whose mind has
been quickened by it, and whose thought is not attached to sensuality is
truly called one who is bound upstream. 218

When a man who has been away a long time at last comes home safely from
far away, his family, friends and acquaintances rejoice to see him back.
In the same way, when a man who has done good goes from this world to
the next, his good deeds receive him like relations welcoming a loved
one back again. 219, 220

17. Anger

Abandon anger, give up pride, and overcome all fetters. Suffering does
nor befall him who is without attachment to names and forms, and
possesses nothing of his own. 221

When a man governs his rising anger like a chariot going out of control,
that is what I call a charioteer. The rest are just holding the reins.
222

Overcome anger with freedom from anger. Overcome evil with good.
Overcome meanness with generosity, and overcome a liar with
truthfulness. 223

Speak the truth, don't get angry, and always give, even if only a
little, when you are asked. By these three principles you can come into
the company of the devas. 224

Those sages who do harm to no-one, and who are always physically
restrained, go to the everlasting abode, reaching which they will face
no more suffering. 225

Inflowing thoughts come to an end in those who are ever alert of mind,
training themselves night and day, and ever intent on nirvana. 226

It was so of old, Atula. It is not just so today. They criticise him who
sits in silence, they criticise him who talks a lot. They even criticise
him who speaks in moderation. There is not a man in the world who is not
criticised. 227

There never has been, there never will be, and there is not now any man
exclusively criticised or exclusively praised. 228

If a wise man of unblemished behaviour and endowed with wisdom, morality
and stillness of mind, is praised by the discriminating after day in day
out acquaintance with him, like a pure gold coin, then who is fit to
find fault with him? Even the King of the devas praises him. 229, 230

Guard against physical unruliness. Be restrained in body. Abandoning
physical wrong doing, lead a life of physical well doing. 231

Guard against mental unruliness. Be restrained in mind. Abandoning
mental wrong doing, lead a life of mental well doing. 232

Guard against verbal unruliness. Be restrained in speech. Abandoning
verbal wrong doing, lead a life of verbal well doing. 233

The wise who are restrained in body, speech and mind - such are the well
and truly restrained. 234

18. Faults

You are now like a withered leaf. Death's messengers themselves are in
your presence. You are standing in the jaws of your departure, and
provisions for the road you have none. 235

In such a case, build yourself an island. Make the effort quickly and
become a wise man. Cleansed of your faults and now without blemish, you
will go to the heavenly land of the saints. 236

You are now at your life's conclusion. You are in the presence of the
King of Death. There is no stopping off place on the way, and provisions
for the road you have none. 237

In such a case, build yourself an island. Make the effort quickly and
become a wise man. Cleansed of your faults and now without blemish, you
will come no more to birth and aging. 238

Little by little, moment by moment, a wise man should cleanse himself of
blemishes, like a smith purifying silver. 239

Just as the rust which develops on iron, derives from it but then
proceeds to eat it away, so a person of unrestrained behaviour is drawn
to hell by his own actions. 240

Lack of repetition is the blight of scriptures. Lack of repairs is the
blight of buildings. The blight of beauty is laziness, and carelessness
is the blight of a guard. 241

The blight of a woman is misconduct. The blight of a giver is meanness.
Bad mental states are indeed blights in this world and the next. 242

But the supreme blight, ignorance, is the blight of blights. Destroying
this blight, be free of blights, bhikkhus. 243

Life is easy enough for the shameless, the crow-hero type of man,
offensive, swaggering, impudent and depraved. But it is hard for the man
of conscience, always striving after purity, alert, reserved, pure of
behaviour and discerning. 244, 245

When a man takes life, tells lies, takes what he is not entitled to in
the world, resorts to other men's wives and indulges in drinking wine
and spirits - such a man is digging up his own roots here and now in
this world. 246, 247

So understand this, my man - Unrestrained men are evil. Don't let greed
and wrong doing subject you to lasting suffering. 248

People give according to their faith, or as they feel well disposed. If
one is put out for that reason with other people's food and drink, then
one will not achieve stillness of mind in meditation, day or night. But
he who has destroyed that sort of reaction, has rooted it out and done
away with it - he will achieve stillness of mind in meditation, day and
night. 249, 250

There is no fire like desire. There is no hold like anger. There is no
net like ignorance. There is no river like craving. 251

Other people's faults are easily seen. One can winnow out other people's
faults like chaff. One hides one's own faults though, like a dishonest
gambler hides an unlucky throw. 252

When one notices the mistakes of others and is always finding fault with
them, the inflow of one's thoughts just increases and one is a long way
from the cessation of this influx. 253

Just as there is no path in the sky, there is no man of religion
outside. Other people take pleasure in multiplicity, but the Buddhas are
free from it. 254

Just as there is no path in the sky, there is no man of religion
outside. There are no lasting functions of the mind, but there is no
oscillation of mind for the Buddhas. 255

19. The Righteous

One is not righteous if one decides a case without due consideration,
but the wise man who takes into account both for and against, and comes
to his decision about others with due consideration - such a man of
discrimination who keeps to the truth, he is to be called righteous.
256, 257

One is not a learned man by virtue of much speaking. He who is patient,
without anger and fearless, he is to be called learned. 258

One is not a bearer of the teaching by virtue of much speaking, but he
who, even if he has only studied a little, has experienced the truth in
person, he is indeed a bearer of the teaching, who has not forgotten the
teaching. 259

One is not an elder by virtue of having white hair. One is just advanced
in years, and called "grown old in vain". He in whom there is
truthfulness, non violence, restraint and self control, however - that
wise and faultless sage is to be called an elder. 260, 261

It is not just by fine speech or by flower-like beauty that one is
admirable, if one is envious, mean and deceitful, but when that sort of
behaviour has been eliminated, rooted out and destroyed, that faultless
sage is said to be admirable. 262, 263

A shaven head does not make one a man of religion, if one is irreligious
and untruthful. How could a man full of desires and greed be a man of
religion? But when a man has put aside all evil deeds, both great and
small, by that putting away of evil deeds he is indeed called a man of
religion. 264, 265

One is not a bhikkhu by virtue of taking alms from others. By taking up
any old teaching, one is not a bhikkhu on that account. But he who has
here and now ejected both good and evil, and in leading the holy life
lives in accordance with reason - he is indeed called a bhikkhu. 266,
267

Silence does not make a sage if he is stupid and ignorant, but when a
man avoids evil as if he were choosing something of value on the scales
- he is a sage. That indeed makes him a sage. He who discriminates in
both worlds is for that reason called a sage. 268, 269

One is not noble if one harms other living creatures. It is by non
violence to all forms of life that one is called noble. 270

It is not just by means of morality and religious observances, not by
great learning nor by attainments in meditation, nor by living alone,
nor by thinking,"I am enjoying a spiritual happiness which ordinary
people do not know" that a bhikkhu achieves peace if he has not achieved
the elimination of inflowing thoughts. 271, 272

20. The Way

Of paths the Eightfold one is best, and of truths the Fourfold.
Dispassion is the best of mental states, and of human beings the best is
the seer. 273

This indeed is the Way - there is no other - for the  purification of
one's vision. Follow this way. It leads to Mara's confusion. 274

Following this Path you will put an end to suffering. I have taught you
the Way after realising the removal of the arrow myself. 275

Making the effort is your affair. The Buddhas have pointed out the Way.
Those who are on the way and practising meditation will be freed from
Mara's bonds. 276

All processes are impermanent. When one sees this with understanding,
then one is disillusioned with the things of suffering. This is the Path
of Purification. 277

All processes are painful. When one sees this with understanding, then
one is disillusioned with the things of suffering. This is the Path of
Purification. 278

All processes are out of my control. When one sees this with
understanding, then one is disillusioned with the things of suffering.
This is the Path of Purification. 279

Since he will not exert himself at the time for exertion, and although
young and strong is full of indolence and irresolution and idleness, the
lazy man is incapable of recognising the way of wisdom. 280

Be guarded in speech, restrained of mind and not doing anything wrong
physically. Perfect these three forms of action, and fulfil the way
taught by the sages. 281

From meditation springs wisdom. From lack of meditation, loss of wisdom.
Recognising these alternative roads of progress and decline, one should
so direct oneself so that one's wisdom will increase. 282

Cut down the forest, not just a tree. Out of the forest of desire
springs danger. By cutting down both the forest of desire and the
brushwood of longing, be rid of the forest (pun on the word "nirvana"),
bhikkhus. 283

So long as the least desire of a man for women has not been eradicated,
he is fettered in mind, like a sucking calf to its mother. 284

Pluck out your desire, like one does an autumn lotus with one's hand.
Devote yourself to the path of peace, the nirvana proclaimed by the
Blessed One. 285

"Here I will spend the rainy season, and here the hot season." This is
the way a fool thinks. It does not occur to him what may happen in
between. 286

Death comes and snatches away the man infatuated with children and
livestock, while his mind is still full of desire, like a great flood
sweeping away a sleeping village. 287

There are no children to take refuge in them, no father or any other
relative. When a man is seized by that terminator, Death, there is no
taking refuge in family. 288

When he has seen the implications of this, a wise man, restrained by
morality, should quickly develop the path leading to nirvana. 289

21. Miscellaneous

If he sees that by sacrificing a slight happiness he can obtain a
greater happiness, then a wise man should sacrifice the lesser happiness
with a view to the greater happiness. 290

He who seeks his own happiness by inflicting suffering on others, does
not reach freedom from hatred, caught as he is in the toils of hatred.
291

What IS their affair is put aside. What is NOT their affair gets done.
The inflow of thoughts in such brazen and careless people just goes on
increasing. They whose recollection of the body is always well
established, however, have nothing to do with what is not their affair,
always persevering in what IS their affair. The inflow of thoughts in
such recollected and aware people simply dies away. 292, 293

After killing mother (desire), father ("I am" conceit) and two warrior
kings, and destroying the kingdom along with its subjects, the brahmin
goes on his way unperturbed. 294

After killing mother, father and two priestly kings, and killed a tiger
as his fifth victim, the brahmin goes on his way unperturbed. 295

A good awakening have ever Gotama's disciples, whose recollection is
always established, day and night on the Buddha. 296

A good awakening have ever Gotama's disciples, whose recollection is
always established, day and night on the Teaching. 297

A good awakening have ever Gotama's disciples, whose recollection is
always established, day and night on the Order. 298

A good awakening have ever Gotama's disciples, whose recollection is
always established, day and night on the body. 299

A good awakening have ever Gotama's disciples, whose minds are always
rejoicing in non violence. 300

A good awakening have ever Gotama's disciples, whose minds are always
rejoicing in the practice of meditation. 301

It is hard to take up a life of renunciation, and difficult to find
satisfaction in it, but it is also difficult to live in bad households,
and painful to live with people unlike oneself, when one is forever
tangled in suffering and restless. Therefore don't always be restless,
and don't let yourself be tangled in suffering. 302

When a man has faith, is endowed with virtue, and possessed of fame and
wealth, wherever he lives he will be honoured. 303

The good are conspicuous a long way off, like a Himalayan peak, while
the bad are just not noticed, like arrows shot into the dark. 304

Living alone, sleeping alone, travelling alone, and resolute, alone and
self disciplined, should take pleasure in living in the forest. 305

22. Hell

He who speaks untruth goes to hell, as does he who, having done
something, says, "I didn't do it." Men of ignoble behaviour, they both
end up the same in the next world. 306

Many of those dressed in the yellow robe are evil and unrestrained, and
the evil end up in hell because of their evil deeds. 307

It is better to swallow a red-hot, flaming iron ball than for an
unrestrained and immoral person to eat the alms food of the land. 308

The thoughtless man who consorts with another man's wife encounters four
things - accumulation of demerit, disturbed sleep, thirdly disgrace, and
hell fourth. 309

Accumulation of demerit, a bad rebirth and the slight pleasure of a
frightened man and a frightened woman - while the authorities impose a
severe penalty too. Therefore a man should not consort with another
man's wife. 310

In the same way that a wrongly handled blade of grass will cut one's
hand, so a badly fulfilled life in religion will drag one down to hell.
311

Lax behaviour, broken observances and dubious chastity - these are of no
great benefit. 312

If it ought to be done, then do it; apply yourself to it strenuously. A
lax man of religion just spreads even more dust. 313

A bad action is best left undone. One is punished later for a bad
action. But a good deed is best done, for which one will not be punished
for doing it. 314

Guard yourself like a frontier town, guarded inside and out. Don't let a
moment slip you by. Those who have missed their opportunity grieve for
it when they end up in hell. 315

Ashamed of what is not a matter for shame, and not ashamed of what is,
by holding to wrong views people go to a bad rebirth. 316

Seeing danger where there is no danger, and not seeing danger where
there is, by holding to wrong views people go to a bad rebirth. 317

Seeing a fault in what is not a fault, and not seeing a fault in what
is, by holding to wrong views people go to a bad rebirth. 318

Recognising a fault as a fault, and what is not a fault as not one, by
holding to right views people go to a good rebirth. 319

23. The Elephant

I will bear criticism like an elephant in battle bears an arrow from a
bow. Most people are bad behaviour. 320

One can take a trained elephant even into a crowd. The king himself will
ride a trained elephant. He who is disciplined is the best of men, since
he can bear criticism. 321

Trained mules are excellent, and so are thoroughbred horses from the
Sindh, and so are great battle elephants, but more excellent than them
all is a disciplined man. 322

There is no reaching the unattainable with mounts like these, but with
himself well under control a disciplined man can get there. 323

Dhammapalo, the elephant, is hard to control in rut. Even when tied up,
he refuses his food. The great tusker is thinking of the elephant
forest. 324

When a man is a lie-abed and over-eats, a lazy person who wallows in
sleep like a great over-fed hog, a fool like that will be reborn time
after time. 325

My mind used formerly to go off wandering wherever it felt like,
following its own inclination, but today I shall control it carefully,
like a mahout does a rutting elephant. 326

Take pleasure in being careful. Guard your mind well. Extricate yourself
from the mire, like a great tusker sunk in the mud. 327

If you find an intelligent companion, a wise and well-behaved person
going the same way as yourself, then go along with him, overcoming all
dangers, pleased at heart and mindful. 328

But if you do not find an intelligent companion, a wise and well-behaved
person going the same way as yourself, then go on your way alone, like a
king abandoning a conquered kingdom, or like a great elephant in the
deep forest. 329

It is better to travel alone. There is no companionship with a fool. Go
on your way alone and commit no evil, without cares like a great
elephant in the deep forest. 330

It is good to have companions when occasion arises, and it is good to be
contented with whatever comes. Merit is good at the close of life, and
the elimination of all suffering is good. 331

Good is filial devotion to one's mother in the world, and devotion to
one's father is good. It is good to be a sanyasi in the world and to be
a brahmin too. 332

Good is good behaviour up to old age, good is firmly established faith,
good is the acquisition of understanding, and abstention from evil is
good. 333

24. Craving

The desire of a thoughtlessly living man grows like a creeper. He drifts
from one life to another like a monkey looking for fruit in the forest.
334

When one is overcome by this wretched, clinging desire in the world,
one's sorrows increase like grass growing up after a lot of rain. 335

But when one masters this wretched desire, which is so hard to overcome,
then one's sorrows just drop off, like a drop of water off a lotus. 336

This is what I say to you - Good luck be with you, gathered here. Dig up
the root of craving, as one does a weed for its fragrant root. Don't let
Mara destroy you again and again, like a stream does its reeds. 337

In the same way that even a felled tree will grow again if its root is
strong and undamaged, so if latent desire has not been rooted out, then
suffering shoots up again and again. 338

When the thirty six pleasure-bound streams of craving are strong in a
man, then numerous desire-based thoughts pull the deluded man along. 339

The streams (of craving) flow everywhere, and the creeper hoots up and
establishes itself, so when you see the creeper shooting up, cut away
its root with your understanding. 340

The recollection and attraction of pleasures occur to a man, and those
who are attached to the agreeable and seeking enjoyment, they are the
people subject to birth and aging. 341

People beset by desire run here and there, like a snared rabbit, and
those trapped in the bonds of attachments keep returning for a long time
to suffering. 342

People beset by desire run here and there, like a snared rabbit, so one
should get rid of one's craving if it is freedom from desire that one
wants. 343

When a man out of the forest of desire is drawn back into the forest,
then free from the forest as he is, he runs back into it. Look at him -
free, he is running back to chains. 344

The wise say that it is not an iron, wooden or fibre fetter which is a
strong one, but the besotted hankering after trinkets, children and
wives, that, say the wise, is the strong fetter. It drags one down, and
loose as it feels, it is hard to break. Breaking this fetter, people
renounce the world, free from longing and abandoning sensuality. 345,
346

Those on fire with desire follow the stream of their desires, like a
spider follows the strands of its self-made web. Breaking the bond, the
wise walk on free from longing, and leaving all suffering behind. 347

Let go the past, let go the future, and let go what is in between,
transcending the things of time. With your mind free in every direction,
you will not return to birth and aging. 348

When a man is stimulated by his own thoughts, full of desire and
dwelling on what is attractive, his craving increases even more. He is
making the fetter even stronger. But he who takes pleasure in stilling
his thoughts, practising the contemplation of what is repulsive, and
remaining recollected, now he will make an end of craving, he will snap
the bonds of Mara. His aim is accomplished, he is without fear, rid of
craving and without stain. He has removed the arrows of changing
existence. This is his last body. 349, 350, 351

Rid of craving and without clinging, an expert in the study of texts,
and understanding the right sequence of the words, he may indeed be
called "In his last body", "Great in wisdom" and a "Great man". 352

All-conquering and all-knowing am I. Amidst all states of mind,
unaffected am I. By abandoning everything, I am liberated by the
cessation of desire. Having achieved Realisation by myself, who should I
point to as my teacher? 353

The gift of the Truth beats all other gifts. The flavour of the Truth
beats all other tastes. The joy of the Truth beats all other joys, and
the cessation of desire conquers all suffering. 354

Riches destroy a fool, but not those who are seeking the other shore.
The fool destroys himself by his craving for riches, as he destroys
others too. 355

Weeds are the blight of fields. Desire is the blight of mankind.
Consequently offerings to those free from desire are of great fruit. 356

Weeds are the blight of fields. Anger is the blight of mankind.
Consequently offerings to those free from anger are of great fruit. 357

Weeds are the blight of fields. Delusion is the blight of mankind.
Consequently offerings to those free from delusion are of great fruit.
358

Weeds are the blight of fields. Self-seeking is the blight of mankind.
Consequently offerings to those free from self-seeking are of great
fruit. 359

25. The bhikkhu

Restraint of the eyes is good. So is restraint of the ears. Restraint of
the nose is good, and so is restraint of the palate. 360

Restraint of the body is good. So is restraint of speech. Restraint of
mind is good, and so is restraint in everything. The bhikkhu who is
restrained in everything, is freed from all suffering. 361

Restrained of hand, restrained of foot, restrained of speech and
restrained in his highest faculty, with his joy turned inwards, his mind
still, alone and contented - that is what they call a bhikkhu. 362

When a bhikkhu is restrained of tongue, quotes wise sayings, and is
peaceful, expounding both letter and spirit - his speech is good to
hear. 363

With joy in the Teaching, delighting in the Teaching, and pondering over
the Teaching, the bhikkhu who remembers the Teaching does not fall away
from the Teaching. 364

One should not underestimate what one has got, and one should not live
envying others. A bhikkhu who envies others does not achieve stillness
of mind in meditation. 365

Even if he has only received a little, if a bhikkhu does not look down
on what he has received, even the devas praise him, pure of life and
determined as he is. 366

When a man is without self-identification with any object or idea, and
does not grieve for what does not exist - that is what is called a
bhikkhu. 367

The bhikkhu who lives full of goodwill, with faith in the religion of
the Buddha - he will reach the place of peace, the satisfaction of
stilling the functions of the mind. 368

Empty the boat, bhikkhu. Empty it will sail lightly for you. When you
have cut away desire and aversion, you will come to nirvana as a result.
369

Cut away the five (lower fetters), abandon the five (remaining fetters),
and then develop the five (faculties). The bhikkhu who has transcended
the five fetters is said to be "crossed over the flood". 370

Meditate, bhikkhu, don't be careless, don't let your mind take pleasure
in the senses. Don't have to swallow the iron ball for being careless.
Don't have to cry out, "This is terrible" as you burn. 371

There is no meditation without wisdom, and there is no wisdom without
meditation. When a man has both meditation and wisdom, he is indeed
close to nirvana. 372

When he has gone off to a lonely building, the bhikkhu whose mind is at
peace experiences a more than human joy, when he recognises the supreme
Truth. 373

Whenever he meditates on the rise and fall of the constituent elements
of existence, he experiences joy and rapture. It is immortality for men
of discrimination. 374

Therefore in this religion, this is what comes first for a wise bhikkhu
- guarding of the senses, contentment, and discipline in accordance with
the rules of the Order. He should cultivate friends of good character,
of pure behaviour and resolute. He should be friendly in his manner, and
well-behaved. As a result he will experience great joy, and put an end
to suffering. 375, 376

In the same way that the jasmine drops its withered flowers, you too
should discard desire and aversion, bhikkhus. 377

Peaceful of body, peaceful of speech and with his mind thoroughly
stilled, the bhikkhu who has rid himself of attachment to the world - is
called "at peace". 378

You should encourage yourself, yourself. You should restrain yourself,
yourself. When you are self-protected like that, you will live happily
as a bhikkhu. 379

One is one's own guard. What other guard could one have? One is one's
own destiny. Therefore one should train oneself, like a merchant does a
thoroughbred horse. 380

The bhikkhu who experiences great joy, and has faith in the religion of
the Buddha, will attain the place of peace, the satisfaction of stilling
the functions of the mind. 381

When a bhikkhu applies himself when still young to the religion of the
Buddha, he illuminates the world, like the moon breaking breaking away
from a cloud. 382

26. The brahmin

Cut the stream and go across, abandon sensuality, brahmin. When you have
achieved the stilling of the activities of the mind, you will know the
unconditioned, brahmin. 383

When a brahmin has crossed beyond duality, then all the fetters of such
a seer come to an end. 384

When a man knows no this shore, other shore, or both - such a one, free
from anxiety, liberated, that is what I call a brahmin. 385

Meditating, free from stain, settled in mind, with job accomplished,
without inflowing thoughts, and having achieved the supreme purpose -
that is what I call a brahmin. 386

By day it is the sun which shines, at night the moon shines forth. A
warrior shines in his armour, and a brahmin shines in meditation. But at
all times, by day and by night, the Buddha shines in his glory. 387

A brahmin is called so by breaking with evil deeds. It is by pious
behaviour that a man is called a man of religion, and by casting out
blemishes one is called one gone forth. 388

One should not strike a brahmin, and nor should a brahmin lose his
temper. Shame on him who strikes a brahmin, and shame on him who loses
his temper because of it. 389

Nothing is better in a brahmin than this - that he restrains his mind
from pleasurable things. Suffering disappears for him to the same extent
that he gets rid of thoughts of harming anyone. 390

He who does no wrong with body, speech or mind, but is restrained in all
three spheres - that is what I call a brahmin. 391

One should reverently pay homage to the man from whom one has learned
the Truth, taught by the True Buddha, like a brahmin does to the
sacrificial fire. 392

One is not a brahmin by virtue of matted hair, lineage or caste. When a
man possesses both Truth and truthfulness, then he is pure, then he is a
brahmin. 393

What use is your matted hair, you fool? What use is your antelope skin?
You are tangled inside, and you are just making the outside pretty. 394

The man who wears robes made from rags off the dust heap, who is gaunt,
with his sinews standing out all over his body, alone meditating in the
forest - that is what I call a brahmin. 395

I do not call him a brahmin who is so by natural birth from his mother.
He is just a supercilious person if he still has possessions of his own.
He who owns nothing of his own, and is without attachment - that is what
I call a brahmin. 396

He who, having cut off all fetters, does not get himself upset, but is
beyond bonds - that liberated man is what I call a brahmin. 397

He who has cut off both bond and strap, halter as well as bridle, who
has removed the barrier, himself a Buddha - that is what I call a
brahmin.  398

He who endures undisturbed criticism, ill-treatment and bonds, strong in
patience, and that strength his power - that is what I call a brahmin.
399

Without anger, devout, upright, free from craving, disciplined and in
his last body - that is what I call a brahmin. 400

Like water on a lotus leaf, like a mustard seed on the point of an pin,
he who is not stuck to the senses - that is what I call a brahmin. 401

He who has experienced the end of his suffering here in this life, who
has set down the burden, freed! - that is what I call a brahmin. 402

The sage of profound wisdom, the expert in the right and wrong road, he
who has achieved the supreme purpose - that is what I call a brahmin.
403

Not intimate with laity or monks, wandering about with no abode, and few
needs - that is what I call a brahmin. 404

Abandoning violence to all living creatures moving or still, he who
neither kills or causes killing - that is what I call a brahmin. 405

Unagitated amongst the agitated, at peace among the violent, without
clinging among those who cling - that is what I call a brahmin. 406

He from whom desire and aversion, conceit and hypocrisy have fallen
away, like a mustard seed on the point of a pin - that is what I call a
brahmin. 407

He who utters only gentle, instructive and truthful speech, criticising
no-one - that is what I call a brahmin. 408

He who takes nothing in the world that has not been given him, long or
short, big or small, attractive or that is what I call a brahmin. 409

He who has no desires in this world or the next, without longings,
freed! - that is what I call a brahmin. 410

He who has no attachments and has been freed from uncertainty by
realisation, who has plunged into the deathless - that is what I call a
brahmin. 411

He who has even here and now transcended the fetter of both good and
evil, who is sorrowless, faultless and pure - that is what I call a
brahmin. 412

The man who is stainless, pure, clear and free from impurities like the
moon, the search for pleasure extinguished - that is what I call a
brahmin. 413

He who has transcended the treacherous mire of samsara and ignorance,
who has crossed over, reached the other shore, meditating, motionless of
mind, free from uncertainty, and who is at peace by not clinging to
anything - that is what I call a brahmin. 414

He who by here and now abandoning sensuality, has gone forth a homeless
wanderer, the search for pleasure extinguished - that is what I call a
brahmin. 415

He who by here and now abandoning craving, has gone forth a homeless
wanderer, the search for pleasure extinguished - that is what I call a
brahmin. 416

He who has abandoned human bonds, and transcended those of heaven,
liberated from all bonds - that is what I call a brahmin. 417

He who has abandoned pleasure and displeasure, is cooled off and without
further fuel, the hero who has conquered all worlds - that is what I
call a brahmin. 418

He who has seen the passing away and rebirth of all beings, free of
clinging, blessed, awakened - that is what I call a brahmin. 419

He whose path devas, spirits and men cannot know, whose inflowing
thoughts are ended, a saint - that is what I call a brahmin. 420

He who has nothing of his own, before, after or in between,
possessionless and without attachment - that is what I call a brahmin.
421

Bull-like, noble, a hero, a great sage, and a conqueror, he who is
motionless of mind, washed clean and awakened - that is what I call a
brahmin. 422

He who has known his former lives and can see heaven and hell
themselves, while he has attained the extinction of rebirth, a seer,
master of transcendent knowledge, and master of all masteries - that is
what I call a brahmin. 423

The End. (Translation by John Richards)
-----------------------------------------------------------------------
end of file


