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
    \new Staff {   \set Staff.instrumentName = "" \clef bass <c>8-. <g>8-. <c'>8-. <g>8-. \clef alto <aes>8-. <ees'>8-. <d'>8-. <a'>8-. \clef treble <g'>8-. <fis'>8-. <e'>8-. <d'>8-.->
               }
>>