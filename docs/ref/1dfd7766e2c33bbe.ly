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
    \new Staff {   \set Staff.instrumentName = "" \clef treble <aes'>32-. <bes'>32-. <c''>32-. <aes'>32-. <fes''>16 <g'>16 <bes'>8( <aes'>8)
               }
>>