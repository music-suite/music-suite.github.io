

# User Guide

## Installation

The Music Suite depends on the [Haskell platform][HaskellPlatform] as well as some
other Haskell libraries which can be installed automatically. To install the suite
with all its dependencies:

    cabal install music-preludes

It is recommended to also install [Lilypond][Lilypond], which allow you to
view musical scores. You can also use other software as long as it supports
the input and output formats used by the Music Suite.


## Generating music

<!--
A piece of music is described by a *expressions* such as this one:

```haskell
c |> d |> e

```

The simplest way to render this expression is to save it in a file named
`foo.music` (or similar) and convert it using `music2pdf foo.music`. This
should render a file called `foo.pdf` containing the following:



![](e812b3370beb65fx.png)

There are several programs for converting music expressions:

* `music2musicxml` converts a Music file to MusicXML
* `music2mid` converts a Music file to MIDI
* `music2ly` converts a Music file to a Lilypond file
* `music2wav` converts a Music file to audio (using Timidity)
* `music2pdf` converts a Music file to graphics (using Lilypond)

## Generating music with explicit Haskell modules
-->

Alternatively, you can create a file called `test.hs` (or similar) with the following structure:

```haskell
import Music.Prelude.Basic

music = c |> d |> e
main = defaultMain music

```

Then either execute it using:

    $ runhaskell test.hs
    
or compile and run it with

    $ ghc --make test
    $ ./test

However, `music.hs` can also be loaded into a Haskell interpreter or compiled.
In this case the resulting program will generate and open a file called
`test.pdf` containing the output seen above.

In fact, the `music2pdf` program is a simple utility that substitutes a single expression into a Haskell module such as the one above and executes the resulting main function.



# Writing music

## Preludes and music representations

The Music Suite is partially a framework for describing various musical representations.
However for most practical purposes, we will not want to invent a new representation from
scratch, but rather start with a standard representation.

## Basics

The simplest music expression is just a single note.

<div class='haskell-music'>



![](344658b06e772a3ex.png)

```haskell
c

```

</div>

As you might have guessed, entering a single note name will render a note in
the middle octave with duration one. This can be changed by applying
transformations such as [`up`][up], [`down`][down], [`delay`][delay] or
[`stretch`][stretch].

Allthough the actual types are more general, you can think of `c` as an expression
of type `Score Note`, and the transformations as functions `Score Note -> Score Note`.

<div class='haskell-music'>



![](72259aeb0502b2ebx.png)

```haskell
up (perfect octave) . compress 2 . delay 3 $ c

```

</div>

Music expressions can be composed [`<>`][<>]:

<div class='haskell-music'>



![](2417d7f318b299eex.png)

```haskell
c <> e <> g

```

</div>

Or in sequence using [`|>`][|>]:

<div class='haskell-music'>



![](e812b3370beb65fx.png)

```haskell
c |> d |> e

```

</div>

Or partwise using [`</>`][</>]:

<div class='haskell-music'>



![](59dcbb2937c2906cx.png)

```haskell
c </> e </> g

```

</div>

These can be combined:

<div class='haskell-music'>



![](15f865c87a0796d1x.png)

```haskell
let
    triad a = a <> up _M3 a <> up _P5 a
in up _P8 (scat [c,d,e,f,g,a,g,f]^/8) </> (triad c)^/2 |> (triad g_)^/2

```

</div>

The `^*` and `^/` operators can be used as shorthands for `delay` and `compress`.

<div class='haskell-music'>



![](6e082ce15a9e3be5x.png)

```haskell
(c |> d |> e |> c |> d^*2 |> d^*2)^/16

```

</div>

As a shorthand for `x |> y |> z ..`, we can write `scat [x, y, z]`.
[`scat`][scat]

<div class='haskell-music'>



![](8dcc23c8a43be98x.png)

```haskell
scat [c,e..g]^/4

```

</div>

For `x <> y <> z ..`, we can write `pcat [x, y, z]`.
[`pcat`][pcat]

<div class='haskell-music'>



![](1a42f3fa65506151x.png)

```haskell
pcat [c,e..g]^/2

```

</div>



## Pitch

Standard pitch names:

<div class='haskell-music'>



![](6cfe439b3533d41ax.png)

```haskell
scat [c, d, e, f, g, a, b]

```

</div>

Shorter syntax for other octaves:

<div class='haskell-music'>



![](762a2558558e6d28x.png)

```haskell
c__ |> c_ |> c |> c' |> c''

```

</div>

Sharps and flats can be added by the functions [`sharp`][sharp] and [`flat`][flat], which are written 
*postfix* thanks to some overloading magic.

<div class='haskell-music'>



![](7d4cbd690475a6c8x.png)

```haskell
c sharp |> d |> e flat

```

</div>

You can also use the ordinary (prefix) versions `sharpen` and `flatten`.

<div class='haskell-music'>



![](1101f1aee219368ex.png)

```haskell
sharpen c 
    </> 
(sharpen . sharpen) c

```

</div>

Shorter syntax for sharp and flat notes:

<div class='haskell-music'>



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
flatten d             == d flat        == ds
(sharpen . sharpen) c == c doubleSharp == css
(flatten . flatten) d == d doubleFlat  == dss

```

Note that there is no guarantee that your pitch representation use enharmonic equivalence, so `cs == db` may or may not hold.

## Dynamics


[`dynamics`][dynamics]

<div class='haskell-music'>



![](312f3abfc8d2e31dx.png)

```haskell
dynamics _p c

```

</div>

## Articulation

Some basic articulation functions are [`legato`][legato], [`staccato`][staccato], [`portato`][portato], [`tenuto`][tenuto], [`separated`][separated], [`spiccato`][spiccato]:

<div class='haskell-music'>



![](4e0bf333c3a1253bx.png)

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
spiccato (scat [c..g]^/8)

```

</div>

[`accent`][accent]
[`marcato`][marcato]

<div class='haskell-music'>



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



![](222067bf4985543dx.png)

```haskell
accentLast (scat [c..g]^/8)
    </>
accentAll (scat [c..g]^/8)

```

</div>

Applying articulations over multiple parts:

<div class='haskell-music'>



![](540fe2d00ef8ec97x.png)

```haskell
let
    p1 = scat [c..b]^/4
    p2 = delay (1/4) $ scat [c..b]^/4
    p3 = delay (3/4) $ scat [c..b]^/4
in (accent . legato) (p1 </> p2 </> p3)

```

</div>

## Tremolo

[`tremolo`][tremolo]

<div class='haskell-music'>



![](33035e5b56c28868x.png)

```haskell
tremolo 2 $ times 2 $ (c |> d)^/4

```

</div>

## Slides and glissando

[`slide`][slide]
[`glissando`][glissando]

<div class='haskell-music'>



![](455023b9c80482a0x.png)

```haskell
glissando $ scat [c,d]^/2

```

</div>

## Harmonics

Use the [`harmonic`][harmonic] function:

<div class='haskell-music'>



![](3577bdcff02045ddx.png)

```haskell
(harmonic 1 $ c^/2)
    </>
(harmonic 2 $ c^/2)
    </>
(harmonic 3 $ c^/2)

```

</div>
[`artificial`][artificial]


## Text

[`text`][text]

<div class='haskell-music'>



![](5351da121c9bf05dx.png)

```haskell
text "pizz." $ c^/2

```

</div>

## Rests

Sometimes it is useful to work with scores that have a duration but no events.
This kind of score is represented by `rest` and has the type `Score (Maybe
Note)`. We use [`removeRests`][removeRests] to convert a `Score (Maybe a)`
into a `Score a`.

<div class='haskell-music'>



![](655bf6c96f41cdbfx.png)

```haskell
removeRests $ times 4 (accent g^*2 |> rest |> scat [d,d]^/2)^/8

```

</div>
                 



# Transformations

## Time

[`retrograde`][retrograde]
[`times`][times]

<div class='haskell-music'>



![](65329ddee37e18ebx.png)

```haskell
let
    melody = legato $ scat [d, scat [g,fs]^/2,bb^*2]^/4
in melody |> retrograde melody

```

</div>

<div class='haskell-music'>



![](701c5015f33304a4x.png)

```haskell
let
    melody = legato $ scat [c,d,e,c]^/16
in times 4 $ melody

```

</div>

<div class='haskell-music'>



![](209d91caa25c1affx.png)

```haskell
let 
    m = legato $ scat [c,d,scat [e,d]^/2, c]^/4 
in [c,eb,ab,g] `repeated` (\p -> up (asPitch p .-. c) m)

```

</div>

### Onset and duration

<div class='haskell-music'>



![](6f4bfbf5a4d6c76ax.png)

```haskell
let                
    melody = asScore $ legato $ scat [scat [c,d,e,c], scat [e,f], g^*2]
    pedal  = asScore $ delayTime (onset melody) $ stretch (duration melody) $ c_
in compress 4 $ melody </> pedal

```

</div>

## Pitch

### Pitches and intervals

### Name and accidental

### Spelling

### Quality and number


## Intonation

TODO

### Inspecting dissonant intervals

### Semitones and enharmonic equivalence

### Spelling

### Scales

### Chords



## Parts

### Instrument, part and sub-part

### Extracting and modifying parts

### Part composition



# Time-based structures

[`Score`][Score]
[`Voice`][Voice]
[`Track`][Track]
[`Delayable`][Delayable]
[`Stretchable`][Stretchable]


# Meta-information

## Basic information

## Time signatures          

## Key signatures

## Rehearsal marks

## Miscellaneous

# Import and export

## MIDI
## MusicXML
## Lilypond
## ABC Notation
## Guido
## Vextab


# Customizing music representation

# Examples

<div class='haskell-music'>



![](5c63147a8994815x.png)

```haskell
let subj = removeRests $ scat [ 
            scat [rest,c,d,e], 
            f^*1.5, scat[g,f]^/4, scat [e,a,d], g^*1.5,
            scat [a,g,f,e,f,e,d]^/2, c^*2 
        ]^/8

in (delay (6/4) $ up (perfect fifth) subj) </> subj

```

</div>





















[scat]:         /docs/api/Music-Time-Juxtapose.html#v:scat
[pcat]:         /docs/api/Music-Time-Juxtapose.html#v:pcat
[times]:        /docs/api/Music-Time-Juxtapose.html#v:times
[<>]:           http://hackage.haskell.org/packages/archive/semigroups/0.9.2/doc/html/Data-Semigroup.html#v:-60--62-
[|>]:           /docs/api/Music-Time-Juxtapose.html#v:-124--62-
[</>]:          /docs/api/Music-Score-Combinators.html#v:-60--47--62-

[delay]:        /docs/api/Music-Time-Delayable.html#v:delay
[stretch]:      /docs/api/Music-Time-Stretchable.html#v:stretch
[compress]:     /docs/api/Music-Time-Stretchable.html#v:compress
[removeRests]:  /docs/api/Music-Score-Combinators.html#v:removeRests

[dynamics]:     /docs/api/Music-Score-Dynamics.html#v:dynamics

[Score]:        /docs/api/Music-Score-Score.html#v:Score
[Voice]:        /docs/api/Music-Score-Score.html#v:Voice
[Track]:        /docs/api/Music-Score-Score.html#v:Track
[Delayable]:    /docs/api/Music-Time-Delayable.html#v:Delayable
[Stretchable]:  /docs/api/Music-Time-Stretchable.html#v:Stretchable


[legato]:       /docs/api/Music-Score-Articulation.html#v:legato
[staccato]:     /docs/api/Music-Score-Articulation.html#v:staccato
[portato]:      /docs/api/Music-Score-Articulation.html#v:portato
[tenuto]:       /docs/api/Music-Score-Articulation.html#v:tenuto
[separated]:    /docs/api/Music-Score-Articulation.html#v:separated
[spiccato]:     /docs/api/Music-Score-Articulation.html#v:spiccato

[accent]:       /docs/api/Music-Score-Articulation.html#v:accent
[marcato]:      /docs/api/Music-Score-Articulation.html#v:marcato
[accentLast]:   /docs/api/Music-Score-Articulation.html#v:accentLast
[accentAll]:    /docs/api/Music-Score-Articulation.html#v:accentAll

[retrograde]:   /docs/api/Music-Score-Combinators.html#v:retrograde

[harmonic]:     /docs/api/Music-Score-Ornaments.html#v:harmonic
[artificial]:   /docs/api/Music-Score-Ornaments.html#v:artificial
[tremolo]:      /docs/api/Music-Score-Ornaments.html#v:tremolo
[glissando]:    /docs/api/Music-Score-Ornaments.html#v:glissando
[slide]:        /docs/api/Music-Score-Ornaments.html#v:slide
[text]:         /docs/api/Music-Score-Ornaments.html#v:text

[up]:           /docs/api/Music-Score-Pitch.html#v:up
[down]:         /docs/api/Music-Score-Pitch.html#v:down

[catMaybes]:    http://hackage.haskell.org/packages/archive/base/latest/doc/html/Data-Maybe.html#v:catMaybes


[Lilypond]:         http://lilypond.org
[Timidity]:         http://timidity.sourceforge.net/
[HaskellPlatform]:  http://www.haskell.org/platform/




