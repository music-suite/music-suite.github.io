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
    \new Staff {   \set Staff.instrumentName = "" r1 r1 <c'>8 r2.. <d'>8 r4. <g'>8 r4. <e'>8 r4. <a'>8 r4. r4 <c''>8 r8 <b'>8 r4. r4 <d''>8 r8 r2 r4 <e''>8
               }
>>