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
    \new Staff {   \set Staff.instrumentName = "" \repeat tremolo 4
                                                                  <c'>16 \repeat tremolo 4
                                                                                         <d'>16 \repeat tremolo 4
                                                                                                                <c'>16 \repeat tremolo 4
                                                                                                                                       <d'>16
               }
>>