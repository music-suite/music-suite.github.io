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
    \new Staff {   \set Staff.instrumentName = "" \times 2/3
                                                         { <c'>1 <d'>2~ } \times 2/3
                                                                                 { <d'>2 <e'>1
                                                                                 } <f'>1~ <f'>1
               }
>>