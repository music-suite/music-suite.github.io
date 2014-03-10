\include "lilypond-book-preamble.ly"
\paper {
  #(define dump-extents #t)

  indent = 0\mm
  line-width = 210\mm - 2.0 * 0.4\in
  ragged-right = ##t
  force-assignment = #""
  line-width = #(- line-width (* mm  3.000000))
}
\header {
  title = ""
  composer = ""
}
\layout {
}

<<
    \new Staff {   \set Staff.instrumentName = "" \set Staff.shortInstrumentName = "" \time 4/4 \clef alto b4-\pp(-> c'4) c'4(-> b4~ b4) b4( c'4 d'4) b4 c'4 b2 e'4( d'4 b4 c'4) b2 d'4 e'4 b4 c'2 b4 b4(-> c'4) c'4(-> b4~ b4) b4( c'4 d'4) b4 c'4 b2 e'4( d'4 b4 c'4) b2 d'4 e'4 b4 c'2 b4 r1 r1 r1 r1 b4(-> cis'4) cis'4(-> b4~ b4) b4( cis'4 d'4) b4 cis'4 b2 e'4( d'4 b4 cis'4) b2 d'4 e'4 b4 cis'2 b4 b4(-> cis'4) cis'4(-> b4~ b4) b4( cis'4 d'4) b4 cis'4 b2 e'4( d'4 b4 cis'4) b2 d'4 e'4 b4 cis'2 b4
               }
    \new Staff {   \set Staff.instrumentName = "" \set Staff.shortInstrumentName = "" \time 4/4 r1 r1 r1 r1 r1 r1 r1 \clef alto b4.-\pp(-> c'4.) c'4~(-> c'8 b2.) b8~( b4 c'4. d'4.) b4. c'4. b4~ b2 e'4.( d'8~ d'4 b4. c'4.) b2. d'4~ d'8 e'4. b4. c'8~ c'8~ c'2 b4. r1 r1 r1 r1 r1 r1 r1 b4.(-> cis'4.) cis'4~(-> cis'8 b2.) b8~( b4 cis'4. d'4.) b4. cis'4. b4~ b2 e'4.( d'8~ d'4 b4. cis'4.) b2. d'4~ d'8 e'4. b4. cis'8~ cis'8~ cis'2 b4.
               }
>>