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
    \new Staff {   \set Staff.instrumentName = "" r1 r8 r2 <g'>8 <a'>8 <b'>8 <c''>8. <d''>32 <c''>32 <b'>8 <e''>8 <a'>8 <d''>8. <e''>16 <d''>16 <c''>16 <b'>16 <c''>16 <b'>16 <a'>16 <g'>4
               }
    \new Staff {   \set Staff.instrumentName = "" r8 <c'>8 <d'>8 <e'>8 <f'>8. <g'>32 <f'>32 <e'>8 <a'>8 <d'>8 <g'>8. <a'>16 <g'>16 <f'>16 <e'>16 <f'>16 <e'>16 <d'>16 <c'>4
               }
>>