\include "lilypond-book-preamble.ly"
\paper {
  #(define dump-extents #t)

  indent = 0\mm
  line-width = 210\mm - 2.0 * 0.4\in
  ragged-right = ##t
  force-assignment = #""
  line-width = #(- line-width (* mm  3.000000))
}
\layout {
}
<<
    \new Staff {   \set Staff.instrumentName = "" r1 <a,>4 <b,>4 \clef bass <c>4 <d>4 <e>4 <f>4 <g>4 <a>4 <b>4 <c'>4
               }
>>