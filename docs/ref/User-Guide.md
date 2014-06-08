

# Getting Started

## Installing the Suite

The Music Suite depends on the [Haskell platform][HaskellPlatform].

While not strictly required, [Lilypond][Lilypond] is highly recommended as it allow you to
preview musical scores. See [Import and Export](#import-and-export) for other formats.

To install the suite, simply install the Haskell platform, and then run:

    cabal install music-suite


## Writing music

This chapter will cover how to use the Music Suite to generate music. Later on we will cover how to *import* and *transform* music.

One of the main points of the Music Suite is to avoid committing to a *single*, closed music representation. Instead it provides a set of types and type constructors that can be used to construct an arbitrary representation of music. 

Usually you will not want to invent a new representation from scratch, but rather start with a standard representation and customize it when needed. The default representation is defined in the `Music.Prelude.Basic` module, which is implicitly imported in all the examples below. See [Customizing the Music Representation](#customizing-music-representation) for other examples.


### With music files

A piece of music is described by a *expressions* such as this one:

```haskell
c |> d |> e

```

The simplest way to render this expression is to save it in a file named
`foo.music` (or similar) and convert it using `music2pdf foo.music`. This
should render a file called `foo.pdf` containing the following:

<div class='haskell-music-listen'><a href='e812b3370beb65f.mid'>[listen]</a></div>

![](e812b3370beb65fx.png)

There are several programs for converting music expressions:

* `music2midi`
* `music2musicxml`
* `music2ly`
* `music2pdf`
* `music2svg`
* `music2png`

### With Haskell files

Alternatively, you can create a file called `test.hs` (or similar) with the following structure:

```haskell
import Music.Prelude.Basic

main = defaultMain music
music = c |> d |> e

```

Then either execute it using:

    $ runhaskell test.hs
    
or compile and run it with

    $ ghc --make test
    $ ./test

In this case the resulting program will generate and open a file called
`test.pdf` containing the output seen above.

Music files and Haskell files using `defaultMain` are equivalent in every aspect. In fact, the `music2...` programs are simple utilities that substitutes a single expression into a Haskell module such as the one above and executes the resulting main function.

## Time and duration

A single note can be entered by its name. This will render a note in the middle octave with a duration of one. Note that note values and durations correspond exactly, a duration of `1` is a whole note, a duration of `1/2` is a half note, and so on.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='344658b06e772a3e.mid'>[listen]</a></div>

![](344658b06e772a3ex.png)

```haskell
c

```

</div>

To change the duration of a note, use [`stretch`][stretch] or [`compress`][compress]. Note that:
    
```haskell
compress x = stretch (1/x)

```

for all values of *x*.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='17acdbdbe31e8366.mid'>[listen]</a></div>

![](17acdbdbe31e8366x.png)

```haskell
stretch (1/2) c

```

</div>

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='c206dd98257abc9.mid'>[listen]</a></div>

![](c206dd98257abc9x.png)

```haskell
stretch 2 c         

```

</div>

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='47c74d92daacf31f.mid'>[listen]</a></div>

![](47c74d92daacf31fx.png)

```haskell
stretch (4+1/2) c

```

</div>

TODO delay

Offset and duration is not limited to simple numbers. Here are some more complex examples:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='7989d1133a0ecb36.mid'>[listen]</a></div>

![](7989d1133a0ecb36x.png)

```haskell
c^*(9/8) |> d^*(7/8)

```

</div>

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='4247fd44e823a93f.mid'>[listen]</a></div>

![](4247fd44e823a93fx.png)

```haskell
stretch (2/3) (scat [c,d,e]) |> f^*2

```

</div>

As you can see, note values, tuplets and ties are added automatically

The `^*` and `^/` operators can be used as shorthands for `delay` and `compress`.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='6e082ce15a9e3be5.mid'>[listen]</a></div>

![](6e082ce15a9e3be5x.png)

```haskell
(c |> d |> e |> c |> d^*2 |> d^*2)^/16

```

</div>


Allthough the actual types are more general, you can think of `c` as an expression
of type `Score Note`, and the transformations as functions `Score Note -> Score Note`.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='2f3b5be629552536.mid'>[listen]</a></div>

![](2f3b5be629552536x.png)

```haskell
up _P8 . compress 2 . delay 3 $ c

```

</div>


## Composition

Music expressions can be composed [`<>`][<>]:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='2417d7f318b299ee.mid'>[listen]</a></div>

![](2417d7f318b299eex.png)

```haskell
c <> e <> g

```

</div>

TODO fundamentally, `<>` is the only way to compose music...

Or in sequence using [`|>`][|>]:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='e812b3370beb65f.mid'>[listen]</a></div>

![](e812b3370beb65fx.png)

```haskell
c |> d |> e

```

</div>

Or partwise using [`</>`][</>]:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='59dcbb2937c2906c.mid'>[listen]</a></div>

![](59dcbb2937c2906cx.png)

```haskell
c </> e </> g

```

</div>

Here is a more complex example:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='28c98e09d9084e17.mid'>[listen]</a></div>

![](28c98e09d9084e17x.png)

```haskell
let            
    scale = scat [c,d,e,f,g,a,g,f]^/8
    triad a = a <> up _M3 a <> up _P5 a
in up _P8 scale </> (triad c)^/2 |> (triad g_)^/2

```

</div>

As a shorthand for `x |> y |> z ..`, we can write [`scat`][scat] `[x, y, z]` (short for *sequential concatenation*).

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='8dcc23c8a43be98.mid'>[listen]</a></div>

![](8dcc23c8a43be98x.png)

```haskell
scat [c,e..g]^/4

```

</div>

For `x <> y <> z ..`, we can write [`pcat`][pcat] `[x, y, z]` (short for *parallel concatenation*).

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='1a42f3fa65506151.mid'>[listen]</a></div>

![](1a42f3fa65506151x.png)

```haskell
pcat [c,e..g]^/2

```

</div>

Actually, [`scat`][scat] and [`pcat`][pcat] used to be called `melody` and `chord` back in the days, but
I figured out that these are names that you actually want to use in your own code.

## Pitch

### Pitch names

To facilitate the use of non-standard pitch, the standard pitch names are provided as overloaded values, referred to as *pitch literals*. 

To understand how this works, think about the type of numeric literal. The values $0, 1, 2$ etc. have type `Num a => a`, similarly, the pitch literals $c, d, e, f ...$ have type [`IsPitch`][IsPitch] `a => a`.

For Western-style pitch types, the standard pitch names can be used:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='6cfe439b3533d41a.mid'>[listen]</a></div>

![](6cfe439b3533d41ax.png)

```haskell
scat [c, d, e, f, g, a, b]

```

</div>

Pitch names in other languages work as well, for example `ut, do, re, mi, fa, so, la, ti, si`. 

<!--
German names (using `h` and `b` instead of `b` and `bb`) can be approximated as follows:

```haskell
import Music.Preludes.Basic hiding (b)
import qualified Music.Pitch.Literal as P

h = P.b
b = P.bb

```
-->


You can change octave using `octavesUp` and `octavesDown`:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='5ee112ca5880e24a.mid'>[listen]</a></div>

![](5ee112ca5880e24ax.png)

```haskell
octavesUp 4 c
    </>
octavesUp (-1) c
    </>
octavesDown 2 c

```

</div>

There is also a shorthand for other octaves:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='762a2558558e6d28.mid'>[listen]</a></div>

![](762a2558558e6d28x.png)

```haskell
c__ |> c_ |> c |> c' |> c''

```

</div>

Sharps and flats can be added by the functions [`sharp`][sharp] and [`flat`][flat], which are written 
*postfix* thanks to some overloading magic.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='7d4cbd690475a6c8.mid'>[listen]</a></div>

![](7d4cbd690475a6c8x.png)

```haskell
c sharp |> d |> e flat

```

</div>

You can also use the ordinary (prefix) versions `sharpen` and `flatten`.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='1101f1aee219368e.mid'>[listen]</a></div>

![](1101f1aee219368ex.png)

```haskell
sharpen c 
    </> 
(sharpen . sharpen) c

```

</div>

As you might expect, there is also a shorthand for sharp and flat notes:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='2fb5ed23f747e89c.mid'>[listen]</a></div>

![](2fb5ed23f747e89cx.png)

```haskell
(cs |> ds |> es)    -- sharp
    </>
(cb |> db |> eb)    -- flat

```

</div>

Here is an overview of all pitch notations:

```haskell
sharpen c             == c sharp       == cs
flatten d             == d flat        == db
(sharpen . sharpen) c == c doubleSharp == css
(flatten . flatten) d == d doubleFlat  == dss

```

Note that `cs == db` may or may not hold depending on which pitch representation you use.

### Interval names

Interval names are overloaded in a manner similar to pitches, and are consequently referred to as *interval literals*. The corresponding class is called [`IsInterval`][IsInterval].

Here and elsewhere in the Music Suite, the convention is to follow standard theoretical
notation, so *minor* and *diminished* intervals are written in lower-case, while *major*
and *perfect* intervals are written in upper-case. Unfortunately, Haskell does not support
overloaded upper-case values, so we have to adopt an underscore prefix:

```haskell
minor third      == m3
major third      == _M3
perfect fifth    == _P5
diminished fifth == d5
minor ninth      == m9

```

Similar to [`sharpen`][sharpen] and [`flatten`][flatten], the [`augment`][augment] and [`diminish`][diminish] functions can be used
to alter the size of an interval. For example:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='4e73fcf2abbd4476.mid'>[listen]</a></div>

![](4e73fcf2abbd4476x.png)

```haskell
let
    intervals = [diminish _P5, (diminish . diminish) _P5]
in scat $ fmap (`up` c) intervals

```

</div>

You can add pitches and intervals using the [`.-.`][.-.] and [`.+^`][.+^] operators. To memorize these
operators, think of pitches and points `.` and intervals as vectors `^`.



### Qualified pitch and interval names

There is nothing special about the pitch and interval literals, they are simply values exported by the `Music.Pitch.Literal` module. While this module is reexported by the standard music preludes, you can also import it qualified if you want to avoid bringing the single-letter pitch names into scope.

```haskell
Pitch.c |> Pitch.d .+^ Interval.m3

```

TODO overloading, explain why the following works:

```haskell
return (c::Note) == (c::Score Note)

```

## Dynamics

Dynamic values are overloaded in the same way as pitches. The dynamic literals are defined in `Music.Dynamics.Literal` and have type `IsDynamics a => a`.

An overview of the dynamic values:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='30d94bf3a5798872.mid'>[listen]</a></div>

![](30d94bf3a5798872x.png)

```haskell
scat $ zipWith level [fff,ff,_f,mf,mp,_p,pp,ppp] [c..]

```

</div>

TODO other ways of applying level

## Articulation

Some basic articulation functions are [`legato`][legato], [`staccato`][staccato], [`portato`][portato], [`tenuto`][tenuto], [`separated`][separated], [`staccatissimo`][staccatissimo]:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='562059c2a485ae04.mid'>[listen]</a></div>

![](562059c2a485ae04x.png)

```haskell
legato (scat [c..g]^/8)
    </>
staccato (scat [c..g]^/8)
    </>
portato (scat [c..g]^/8)
    </>
tenuto (scat [c..g]^/8)
    </>
separated (scat [c..g]^/8)
    </>
staccatissimo (scat [c..g]^/8)

```

</div>

[`accent`][accent]
[`marcato`][marcato]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='7505c58579d6f2eb.mid'>[listen]</a></div>

![](7505c58579d6f2ebx.png)

```haskell
accent (scat [c..g]^/8)
    </>
marcato (scat [c..g]^/8)

```

</div>

[`accentLast`][accentLast]
[`accentAll`][accentAll]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='222067bf4985543d.mid'>[listen]</a></div>

![](222067bf4985543dx.png)

```haskell
accentLast (scat [c..g]^/8)
    </>
accentAll (scat [c..g]^/8)

```

</div>

Applying articulations over multiple parts:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='6d6121cf5a1057ff.mid'>[listen]</a></div>

![](6d6121cf5a1057ffx.png)

```haskell
let
    p1 = scat [c..c']^/4
    p2 = delay (1/4) $ scat [c..c']^/4
    p3 = delay (3/4) $ scat [c..c']^/4
in (accent . legato) (p1 </> p2 </> p3)

```

</div>

## Parts

[`Division`][Division]

[`Subpart`][Subpart]

[`Part`][Part]

[`Instrument`][Instrument]

[`Solo`][Solo]


## Space

TODO

## Tremolo

[`tremolo`][tremolo]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='33035e5b50c27efa.mid'>[listen]</a></div>

![](33035e5b50c27efax.png)

```haskell
tremolo 2 $ times 2 $ (c |> d)^/2

```

</div>

TODO chord tremolo

## Slides and glissando

[`slide`][slide]
[`glissando`][glissando]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='455023b9c80482a0.mid'>[listen]</a></div>

![](455023b9c80482a0x.png)

```haskell
glissando $ scat [c,d]^/2

```

</div>

## Harmonics

Use the [`harmonic`][harmonic] function:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='3577bdcff02045dd.mid'>[listen]</a></div>

![](3577bdcff02045ddx.png)

```haskell
(harmonic 1 $ c^/2)
    </>
(harmonic 2 $ c^/2)
    </>
(harmonic 3 $ c^/2)

```

</div>

TODO artificial harmonics

[`artificial`][artificial]


## Text

TODO

[`text`][text]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='5351da121c9bf05d.mid'>[listen]</a></div>

![](5351da121c9bf05dx.png)

```haskell
text "pizz." $ c^/2

```

</div>

## Chords

Note with the same onset and offset are rendered as chords by default. If you want to prevent this you must put them in separate parts.

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='2eb839e952b93cc5.mid'>[listen]</a></div>

![](2eb839e952b93cc5x.png)

```haskell
scat [c,d,e,c] <> scat [e,f,g,e] <> scat [g,a,b,g]

```

</div>

Or, equivalently:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='2d1c5c02c1378cf0.mid'>[listen]</a></div>

![](2d1c5c02c1378cf0x.png)

```haskell
pcat [c,e,g] |> pcat [d,f,a] |> pcat [e,g,b] |> pcat [c,e,g]

```

</div>

TODO how part separation works w.r.t. division etc

[`simultaneous`][simultaneous]

[`simult`][simult]

## Rests

Similar to chords, there is usually no need to handle rests explicitly.

TODO add explicit rests etc

[`mcatMaybes`][mcatMaybes] 

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='1f74a9ab0e749367.mid'>[listen]</a></div>

![](1f74a9ab0e749367x.png)

```haskell
mcatMaybes $ times 4 (accentAll g^*2 |> rest |> scat [d,d]^/2)^/8

```

</div>
                 



# Transformations

## Time

[`rev`][rev]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='339ae0c0fd3b9259.mid'>[listen]</a></div>

![](339ae0c0fd3b9259x.png)

```haskell
let
    melody = accent $ legato $ scat [d, scat [g,fs]^/2,bb^*2]^/4
in melody |> rev melody

```

</div>

[`times`][times]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='701c5015f33304a4.mid'>[listen]</a></div>

![](701c5015f33304a4x.png)

```haskell
let
    melody = legato $ scat [c,d,e,c]^/16
in times 4 $ melody

```

</div>

[`sustain`][sustain]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='60dc3260048dae39.mid'>[listen]</a></div>

![](60dc3260048dae39x.png)

```haskell
scat [e,d,f,e] <> c

```

</div>


[`anticipate`][anticipate]

<!--
[`repeated`][repeated]

```music+haskellx
let 
    m = legato $ scat [c,d,scat [e,d]^/2, c]^/4 
in [c,eb,ab,g] `repeated` (\p -> up (asPitch p .-. c) m)
```
-->

## Onset and duration

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='55fd573b2001a8a.mid'>[listen]</a></div>

![](55fd573b2001a8ax.png)

```haskell
let                
    melody = asScore $ legato $ scat [scat [c,d,e,c], scat [e,f], g^*2]
    pedal  = asScore $ delayTime (melody^.onset) $ stretch (melody^.duration) $ c_
in compress 4 $ melody </> pedal

```

</div>

## Pitch

[`invertPitches`][invertPitches]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='572fb63c22f84242.mid'>[listen]</a></div>

![](572fb63c22f84242x.png)

```haskell
(scat [c..g]^*(2/5))
    </>
(invertPitches c $ scat [c..g]^*(2/5))
    </>
(invertPitches e $ scat [c..g]^*(2/5))

```

</div>


## Pitches and intervals

TODO

## Name and accidental

TODO

## Spelling

TODO

## Quality and number

TODO


## Intonation

TODO

## Inspecting dissonant intervals

TODO

## Semitones and enharmonic equivalence

TODO

## Spelling

TODO

## Scales

TODO

## Chords

TODO



## Parts

## Instrument, part and sub-part

## Extracting and modifying parts

## Part composition


# Time-based structures

[`Transformable`][Transformable]

[`Splittable`][Splittable]

[`Reversible`][Reversible]

[`HasPosition`][HasPosition]

[`HasDuration`][HasDuration]


## Time and duration

[`Time`][Time]

[`Duration`][Duration]

## Spans

[`Span`][Span]

## Notes

[`Note`][Note]

## Voice

A [`Voice`][Voice] represents a single voice of music. It consists of a sequence of values with duration, but no time. 

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='786d2383245b9c9d.mid'>[listen]</a></div>

![](786d2383245b9c9dx.png)

```haskell
stretch (1/4) $ scat [c..a]^/2 |> b |> c'^*4

```

</div>

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='6391c8a4c4a26fdb.mid'>[listen]</a></div>

![](6391c8a4c4a26fdbx.png)

```haskell
stretch (1/2) $ scat [c..e]^/3 |> f |> g^*2

```

</div>


It can be converted into a score by stretching each element and composing in sequence.

<!--
```music+haskellx
let
    x = [ (1, c),
          (1, d),
          (1, f),
          (1, e) ]^.voice

    y = join $ [ (1, x), 
                 (0.5, up _P5 x), 
                 (4, up _P8 x) ]^.voice

in stretch (1/8) $ voiceToScore $ y
```
-->

## Tracks

A [`Track`][Track] is similar to a score, except that it events have no offset or duration. It is useful for representing point-wise occurrences such as samples, cues or percussion notes.

It can be converted into a score by delaying each element and composing in parallel. An explicit duration has to be provided.

<!--
```music+haskellx
let
    x = [ (0, c), (1, d), (2, e) ]^.track
    y = join $ [ (0, x), 
                (1.5,  up _P5 x), 
                (3.25, up _P8 x) ]^.track

in trackToScore (1/8) y
```
-->

## Scores

[`Score`][Score]




# Meta-information

It is often desirable to annotate music with extraneous information, such as title, creator or time signature. Also, it is often useful to mark scores with structural information such as movement numbers, rehearsal marks or general annotations. In the Music Suite these are grouped together under the common label *meta-information*. 

Each type of meta-information is stored separately and can be extracted and transformed depending on its type. Each type of meta-information has a default value which is implicitly chosen if no meta-information of the given type has been entered (for example the default title is empty, the default key signature is C major and so on).

The distinction between ordinary musical data and meta-data is not always clear cut. As a rule of thumb, meta-events are any kind of event that does not directly affect how the represented music sounds when performed. However they might affect the appearance of the musical notation. For example, a *clef* is meta-information, while a *slur* is not. A notable exception to this rule is meta-events affecting tempo such as metronome marks and fermatas, which usually *do* affect the performance of the music.

## Title

[`title`][title]

[`subtitle`][subtitle]

[`subsubtitle`][subsubtitle]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='6fcc5379512ba159.mid'>[listen]</a></div>

![](6fcc5379512ba159x.png)

```haskell
title "Frere Jaques" $ scat [c,d,e,c]^/4

```

</div>

## Attribution

[`composer`][composer]

[`lyricist`][lyricist]

[`arranger`][arranger]

[`attribution`][attribution]

[`attributions`][attributions]

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='7a6e97aaa81dd848.mid'>[listen]</a></div>

![](7a6e97aaa81dd848x.png)

```haskell
composer "Anonymous" $ scat [c,d,e,c]

```

</div>

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='71070892445769d.mid'>[listen]</a></div>

![](71070892445769dx.png)

```haskell
composer "Anonymous" $ lyricist "Anonymous" $ arranger "Hans" $ scat [c,d,e,c]^/4

```

</div>

## Key signatures

[`key`][key]

[`keySignature`][keySignature]

[`keySignatureDuring`][keySignatureDuring]

[`withKeySignature`][withKeySignature]

## Time signatures          

[`time`][time]

[`compoundTime`][compoundTime]

[`timeSignature`][timeSignature]

[`timeSignatureDuring`][timeSignatureDuring]

[`withTimeSignature`][withTimeSignature]

## Tempo

[`metronome`][metronome]

[`tempo`][tempo]

[`tempoDuring`][tempoDuring]

[`withTempo`][withTempo]

[`renderTempo`][renderTempo]

## Fermatas, caesuras and breathing marks

TODO

## Ritardando and accellerando

TODO

## Rehearsal marks

TODO

[`rehearsalMark`][rehearsalMark]

[`rehearsalMarkDuring`][rehearsalMarkDuring]

[`withRehearsalMark`][withRehearsalMark]

## Barlines and repeats

There is generally no need to enter bars explicitly, as this information can be inferred from other meta-information. Generally, the following meta-events (in any part), will force a change of bar:

* Key signature changes
* Time signature changes
* Tempo changes
* Rehearsal marks

However, the user may also enter explicit bar lines using the following functions:

[`barline`][barline]

[`doubleBarline`][doubleBarline]

[`finalBarline`][finalBarline]

Whenever a bar line is created as a result of a meta-event, an shorted time signature may need to be inserted as in:

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='5f1d2f467655ff45.mid'>[listen]</a></div>

![](5f1d2f467655ff45x.png)

```haskell
compress 4 $ timeSignature (4/4) (scat [c,d,e,c,d,e,f,d,g,d]) |> timeSignature (3/4) (scat [a,g,f,g,f,e])

```

</div>

TODO adapt getBarDurations and getBarTimeSignatures to actually do this

TODO repeats

## Clefs

To set the clef for a whole passage, use [`clef`][clef]. The clef is used by most notation backends and ignored by audio backends.

To set the clef for a preexisting passage in an existing score, use [`clefDuring`][clefDuring].

TODO example

## Annotations

Annotations are simply textual values attached to a specific section of the score. In contrast to other types of meta-information annotations always apply to the whole score, not to a single part. To annotate a score use [`annotate`][annotate], to annotate a specific span, use [`annotateSpan`][annotateSpan].

Annotations are invisible by default. To show annotations in the generated output, use
[`showAnnotations`][showAnnotations].

<div class='haskell-music'>

<div class='haskell-music-listen'><a href='5753dd6f3c2997e3.mid'>[listen]</a></div>

![](5753dd6f3c2997e3x.png)

```haskell
showAnnotations $ annotate "First note" c |> d |> annotate "Last note" d

```

</div>

## Custom meta-information

Meta-information is not restricted to the types described above. In fact, the user can add meta-information of any type that satisfies the `IsAttribute` constraint, including user-defined types. Each type of meta-information is stored separately from other types, and is invisible to the user by default. You might think of each score as having one an infinite set of associated meta-scores, each containing both part-specific and global meta information.

Meta-information is required to implement `Monoid`. The `mempty` value is used as a default value for the type, while the `mappend` function is used to combine the default value and all values added by the user.

[`addMetaNote`][addMetaNote]

[`addGlobalMetaNote`][addGlobalMetaNote]

[`withMeta`][withMeta]

[`withGlobalMeta`][withGlobalMeta]

[`withMetaAtStart`][withMetaAtStart]

[`withGlobalMetaAtStart`][withGlobalMetaAtStart]

Typically, you want to use a monoid similar to `Maybe`, `First` or `Last`, but not one derived from the list type. The reason for this is that meta-scores compose, so that `getMeta (x <> y) = getMeta x <> getMeta y`.

TODO unexpected results with filter and recompose, solve by using a good Monoid
Acceptable Monoids are Maybe and Set/Map, but not lists (ordered sets/unique lists OK)
See issue 103


# Import and export

The standard distribution (installed as part of `music-preludes`) of the Music Suite includes a variety of input and output formats. There are also some experimental formats, which are distributed in separate packages, these are marked as experimental below.

The conventions for input or output formats is similar to the convention for properties (TODO ref above): for any type `a` and format `T a`, input formats are defined by an *is* constraint, and output format by a *has* constraint. For example, types that can be exported to Lilypond are defined by the constraint `HasLilypond a`, while types that can be imported from MIDI are defined by the constraint `IsMidi a`.

## MIDI

All standard representations support MIDI input and output. The MIDI representation uses [HCodecs](http://hackage.haskell.org/package/HCodecs) and the real-time support uses [hamid](http://hackage.haskell.org/package/hamid). 

<!--
You can read and write MIDI files using the functions [`readMidi`][readMidi] and [`writeMidi`][writeMidi]. To play MIDI back in real-time, use [`playMidi`][playMidi] or [`playMidiIO`][playMidiIO], which uses [reenact](http://hackage.haskell.org/package/reenact).
-->

Beware that MIDI input may contain time and pitch values that yield a non-readable notation, you need an sophisticated piece of analysis software to convert raw MIDI input to quantized input.

## Lilypond

All standard representations support Lilypond output. The [lilypond](http://hackage.haskell.org/package/lilypond) package is used for parsing and pretty printing of Lilypond syntax. Lilypond is the recommended way of rendering music.

Lilypond input is not available yet but will hopefully be added soon.

An example:

```haskell
toLyString $ asScore $ scat [c,d,e]

```

    <<
        \new Staff { <c'>1 <d'>1 <e'>1 }
    >>


## MusicXML

All standard representations support MusicXML output. The [musicxml2](http://hackage.haskell.org/package/musicxml2) package is used for 
parsing and pretty printing. 

The output is fairly complete, with some limitations ([reports][issue-tracker] welcome). There are no plans to support input in the near future.

Beware of the extreme verboseness of XML, for example:

```haskell
toMusicXmlString $ asScore $ scat [c,d,e]

```

    <?xml version='1.0' ?>
    <score-partwise>
      <movement-title>Title</movement-title>
      <identification>
        <creator type="composer">Composer</creator>
      </identification>
      <part-list>
        <score-part id="P1">
          <part-name></part-name>
        </score-part>
      </part-list>
      <part id="P1">
        <measure number="1">
          <attributes>
            <key>
              <fifths>0</fifths>
              <mode>major</mode>
            </key>
          </attributes>
          <attributes>
            <divisions>768</divisions>
          </attributes>
          <direction>
            <direction-type>
              <metronome>
                <beat-unit>quarter</beat-unit>
                <per-minute>60</per-minute>
              </metronome>
            </direction-type>
          </direction>
          <attributes>
            <time symbol="common">
              <beats>4</beats>
              <beat-type>4</beat-type>
            </time>
          </attributes>
          <note>
            <pitch>
              <step>C</step>
              <alter>0.0</alter>
              <octave>4</octave>
            </pitch>
            <duration>3072</duration>
            <voice>1</voice>
            <type>whole</type>
          </note>
        </measure>
        <measure number="2">
          <note>
            <pitch>
              <step>D</step>
              <alter>0.0</alter>
              <octave>4</octave>
            </pitch>
            <duration>3072</duration>
            <voice>1</voice>
            <type>whole</type>
          </note>
        </measure>
        <measure number="3">
          <note>
            <pitch>
              <step>E</step>
              <alter>0.0</alter>
              <octave>4</octave>
            </pitch>
            <duration>3072</duration>
            <voice>1</voice>
            <type>whole</type>
          </note>
        </measure>
      </part>
    </score-partwise>
    

## ABC Notation

ABC notation (for use with [abcjs](http://code.google.com/p/abcjs/) or similar engines) is still experimental.

## Guido

Guido output (for use with the [GUIDO engine](http://guidolib.sourceforge.net/)) is not supported yet. This would be useful, as it allow real-time rendering of scores.

## Vextab

Vextab output (for use with [Vexflow](http://www.vexflow.com/)) is not supported yet.

## Sibelius

The [music-sibelius](http://hackage.haskell.org/package/music-sibelius) package provides experimental import of Sibelius scores (as MusicXML import is [not supported](#musicxml)).

<!--
This feature could of course also be used to convert Sibelius scores to other formats such as Guido or ABC without having to write in the ManuScript language used by Sibelius.
-->



# Customizing music representation

TODO


# Examples

See the [examples](https://github.com/music-suite/music-preludes/tree/master/examples) directory in `music-preludes`.


### Acknowledgements

The Music Suite is indebted to many other previous libraries and computer music environments, particularly [Common Music][common-music], [Max/MSP][max-msp], [SuperCollider][supercollider], [nyquist][nyquist], [music21][music21], [Guido][guido], [Lilypond][lilypond] and [Abjad][abjad]. Some of the ideas for the quantization algorithms came from [Fomus][fomus].

It obviously ows a lot to the Haskell libraries that it follows including [Haskore][haskore], [Euterpea][euterpea] and [temporal-media][temporal-media]. The idea of defining a custom internal representation, but relying on standardized formats for input and output comes from [Pandoc][pandoc]. The idea of splitting the library into a set of packages (and the name) comes from the [Haskell Suite][haskell-suite]. The temporal structures, their instances and the concept of denotational design comes from [Reactive][reactive] (and its predecessors). [Diagrams][diagrams] provided the daring example and some general influences on the design.


<script src="js/jasmid/stream.js"></script>
<script src="js/jasmid/midifile.js"></script>
<script src="js/jasmid/replayer.js"></script>
<script src="js/midi.js"></script>
<script src="js/Base64.js" type="text/javascript"></script>
<script src="js/base64binary.js" type="text/javascript"></script>
<script src="js/main.js" type="text/javascript"></script>



<!-- Unknown: anticipate No such identifier: anticipate-->


<!-- Unknown: playMidi No such identifier: playMidi-->


<!-- Unknown: playMidiIO No such identifier: playMidiIO-->


<!-- Unknown: withTempo No such identifier: withTempo-->

[.+^]: /docs/api/music-pitch/Music-Pitch.html#v:-46--43--94-
[.-.]: /docs/api/music-pitch/Music-Pitch.html#v:-46--45--46-
[</>]: /docs/api/music-score/Music-Score-Meta.html#v:-60--47--62-
[<>]: /docs/api/music-pitch/Music-Pitch.html#v:-60--62-
[Division]: /docs/api/music-parts/Music-Parts.html#t:Division
[Duration]: /docs/api/music-score/Music-Time-Duration.html#t:Duration
[HasDuration]: /docs/api/music-score/Music-Time-Duration.html#t:HasDuration
[HasPosition]: /docs/api/music-score/Music-Time-Position.html#t:HasPosition
[Instrument]: /docs/api/music-parts/Music-Parts.html#t:Instrument
[IsInterval]: /docs/api/music-pitch-literal/Music-Pitch-Literal-Interval.html#t:IsInterval
[IsPitch]: /docs/api/music-pitch-literal/Music-Pitch-Literal-Pitch.html#t:IsPitch
[Note]: /docs/api/music-score/Music-Time-Note.html#t:Note
[Part]: /docs/api/music-score/Music-Score-Part.html#t:Part
[Reversible]: /docs/api/music-score/Music-Time-Reverse.html#t:Reversible
[Score]: /docs/api/music-score/Music-Time-Score.html#t:Score
[Solo]: /docs/api/music-parts/Music-Parts.html#t:Solo
[Span]: /docs/api/music-score/Music-Time-Duration.html#t:Span
[Splittable]: /docs/api/music-score/Music-Time-Split.html#t:Splittable
[Subpart]: /docs/api/music-parts/Music-Parts.html#t:Subpart
[Time]: /docs/api/music-score/Music-Time-Duration.html#t:Time
[Track]: /docs/api/music-score/Music-Time-Track.html#t:Track
[Transformable]: /docs/api/music-score/Music-Time-Internal-Transform.html#t:Transformable
[Voice]: /docs/api/music-score/Music-Time-Voice.html#t:Voice
[accentAll]: /docs/api/music-score/Music-Score-Articulation.html#v:accentAll
[accentLast]: /docs/api/music-score/Music-Score-Articulation.html#v:accentLast
[accent]: /docs/api/music-score/Music-Score-Articulation.html#v:accent
[addGlobalMetaNote]: /docs/api/music-score/Music-Score-Meta.html#v:addGlobalMetaNote
[addMetaNote]: /docs/api/music-score/Music-Score-Meta.html#v:addMetaNote
[annotateSpan]: /docs/api/music-score/Music-Score-Meta-Annotations.html#v:annotateSpan
[annotate]: /docs/api/music-score/Music-Score-Meta-Annotations.html#v:annotate
[arranger]: /docs/api/music-score/Music-Score-Meta-Attribution.html#v:arranger
[artificial]: /docs/api/music-score/Music-Score-Harmonics.html#v:artificial
[attribution]: /docs/api/music-score/Music-Score-Meta-Attribution.html#v:attribution
[attributions]: /docs/api/music-score/Music-Score-Meta-Attribution.html#v:attributions
[augment]: /docs/api/music-pitch-literal/Music-Pitch-Augmentable.html#v:augment
[barline]: /docs/api/music-score/Music-Score-Meta-Barline.html#v:barline
[clefDuring]: /docs/api/music-score/Music-Score-Meta-Clef.html#v:clefDuring
[clef]: /docs/api/music-score/Music-Score-Meta-Clef.html#v:clef
[composer]: /docs/api/music-score/Music-Score-Meta-Attribution.html#v:composer
[compoundTime]: /docs/api/music-score/Music-Score-Meta-Time.html#v:compoundTime
[compress]: /docs/api/music-score/Music-Time-Internal-Transform.html#v:compress
[diminish]: /docs/api/music-pitch-literal/Music-Pitch-Augmentable.html#v:diminish
[doubleBarline]: /docs/api/music-score/Music-Score-Meta-Barline.html#v:doubleBarline
[finalBarline]: /docs/api/music-score/Music-Score-Meta-Barline.html#v:finalBarline
[flat]: /docs/api/music-pitch/Music-Pitch-Common-Pitch.html#v:flat
[flatten]: /docs/api/music-pitch-literal/Music-Pitch-Alterable.html#v:flatten
[glissando]: /docs/api/music-score/Music-Score-Slide.html#v:glissando
[harmonic]: /docs/api/music-score/Music-Score-Harmonics.html#v:harmonic
[invertPitches]: /docs/api/music-score/Music-Score-Pitch.html#v:invertPitches
[keySignatureDuring]: /docs/api/music-score/Music-Score-Meta-Key.html#v:keySignatureDuring
[keySignature]: /docs/api/music-score/Music-Score-Meta-Key.html#v:keySignature
[key]: /docs/api/music-score/Music-Score-Meta-Key.html#v:key
[legato]: /docs/api/music-score/Music-Score-Articulation.html#v:legato
[lyricist]: /docs/api/music-score/Music-Score-Meta-Attribution.html#v:lyricist
[marcato]: /docs/api/music-score/Music-Score-Articulation.html#v:marcato
[mcatMaybes]: /docs/api/music-score/Music-Score.html#v:mcatMaybes
[metronome]: /docs/api/music-score/Music-Score-Meta-Tempo.html#v:metronome
[pcat]: /docs/api/music-score/Music-Time-Juxtapose.html#v:pcat
[portato]: /docs/api/music-score/Music-Score-Articulation.html#v:portato
[readMidi]: /docs/api/music-score/Music-Score-Import-Midi.html#v:readMidi
[rehearsalMarkDuring]: /docs/api/music-score/Music-Score-Meta-RehearsalMark.html#v:rehearsalMarkDuring
[rehearsalMark]: /docs/api/music-score/Music-Score-Meta-RehearsalMark.html#v:rehearsalMark
[renderTempo]: /docs/api/music-score/Music-Score-Meta-Tempo.html#v:renderTempo
[repeated]: /docs/api/music-score/Music-Score.html#v:repeated
[rev]: /docs/api/music-score/Music-Time-Reverse.html#v:rev
[scat]: /docs/api/music-score/Music-Time-Juxtapose.html#v:scat
[separated]: /docs/api/music-score/Music-Score-Articulation.html#v:separated
[sharp]: /docs/api/music-pitch/Music-Pitch-Common-Pitch.html#v:sharp
[sharpen]: /docs/api/music-pitch-literal/Music-Pitch-Alterable.html#v:sharpen
[showAnnotations]: /docs/api/music-score/Music-Score-Meta-Annotations.html#v:showAnnotations
[simult]: /docs/api/music-score/Music-Time-Score.html#v:simult
[simultaneous]: /docs/api/music-score/Music-Time-Score.html#v:simultaneous
[slide]: /docs/api/music-score/Music-Score-Slide.html#v:slide
[staccatissimo]: /docs/api/music-score/Music-Score-Articulation.html#v:staccatissimo
[staccato]: /docs/api/music-score/Music-Score-Articulation.html#v:staccato
[stretch]: /docs/api/music-score/Music-Time-Internal-Transform.html#v:stretch
[subsubtitle]: /docs/api/music-score/Music-Score-Meta-Title.html#v:subsubtitle
[subtitle]: /docs/api/music-score/Music-Score-Meta-Title.html#v:subtitle
[sustain]: /docs/api/music-score/Music-Time-Juxtapose.html#v:sustain
[tempoDuring]: /docs/api/music-score/Music-Score-Meta-Tempo.html#v:tempoDuring
[tempo]: /docs/api/music-score/Music-Score-Meta-Tempo.html#v:tempo
[tenuto]: /docs/api/music-score/Music-Score-Articulation.html#v:tenuto
[text]: /docs/api/music-score/Music-Score-Text.html#v:text
[timeSignatureDuring]: /docs/api/music-score/Music-Score-Meta-Time.html#v:timeSignatureDuring
[timeSignature]: /docs/api/music-score/Music-Score-Meta-Time.html#v:timeSignature
[time]: /docs/api/music-score/Music-Score-Meta-Time.html#v:time
[times]: /docs/api/music-score/Music-Time-Juxtapose.html#v:times
[title]: /docs/api/music-score/Music-Score-Meta-Title.html#v:title
[tremolo]: /docs/api/music-score/Music-Score-Tremolo.html#v:tremolo
[withGlobalMetaAtStart]: /docs/api/music-score/Music-Score-Meta.html#v:withGlobalMetaAtStart
[withGlobalMeta]: /docs/api/music-score/Music-Score-Meta.html#v:withGlobalMeta
[withKeySignature]: /docs/api/music-score/Music-Score-Meta-Key.html#v:withKeySignature
[withMetaAtStart]: /docs/api/music-score/Music-Score-Meta.html#v:withMetaAtStart
[withMeta]: /docs/api/music-score/Music-Score-Meta.html#v:withMeta
[withRehearsalMark]: /docs/api/music-score/Music-Score-Meta-RehearsalMark.html#v:withRehearsalMark
[withTimeSignature]: /docs/api/music-score/Music-Score-Meta-Time.html#v:withTimeSignature
[writeMidi]: /docs/api/music-score/Music-Score-Export-Midi.html#v:writeMidi
[|>]: /docs/api/music-score/Music-Time-Juxtapose.html#v:-124--62-

[Lilypond]:         http://lilypond.org
[Timidity]:         http://timidity.sourceforge.net/
[HaskellPlatform]:  http://www.haskell.org/platform/

[issue-tracker]:    https://github.com/hanshoglund/music-score/issues

[pandoc]:           http://johnmacfarlane.net/pandoc/
[haskell-suite]:    https://github.com/haskell-suite
[music-util-docs]:  https://github.com/hanshoglund/music-util/blob/master/README.md#music-util

[common-music]:     http://commonmusic.sourceforge.net/
[temporal-media]:   http://hackage.haskell.org/package/temporal-media
[abjad]:            https://pypi.python.org/pypi/Abjad/2.3
[max-msp]:          http://cycling74.com/products/max/
[nyquist]:          http://audacity.sourceforge.net/help/nyquist
[reactive]:         http://www.haskell.org/haskellwiki/Reactive
[diagrams]:         http://projects.haskell.org/diagrams/
[supercollider]:    http://supercollider.sourceforge.net/
[music21]:          http://music21-mit.blogspot.se/
[guido]:            http://guidolib.sourceforge.net/
[lilypond]:         http://lilypond.org/
[fomus]:            http://fomus.sourceforge.net/
[haskore]:          http://www.haskell.org/haskellwiki/Haskore
[euterpea]:         http://haskell.cs.yale.edu/euterpea/
[haskell]:          http://haskell.org
[pandoc]:           http://johnmacfarlane.net/pandoc/





