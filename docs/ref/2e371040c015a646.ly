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
    \new Staff {   \set Staff.instrumentName = "" \set Staff.shortInstrumentName = "" \clef treble <a,>8 <b,>8 \clef alto <c>8 <d>8 \clef treble <e>8 <f>8 \clef bass <g>8 <a>8 \clef treble <b>8 <c'>8 <d'>8 <e'>8 <f'>8 <g'>8 <a'>8 <b'>8 <c''>8
               }
>>