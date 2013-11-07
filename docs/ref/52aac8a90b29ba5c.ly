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
                                                         {   <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8
                                                         } \times 2/3
                                                                  {   <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8
                                                                  } \times 2/3
                                                                           {   <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8
                                                                           } \times 2/3
                                                                                    {   <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8 <g'>8
                                                                                    }
               }
    \new Staff {   \set Staff.instrumentName = "" r1 \times 2/3
                                                            {   <g>8( <a>8 <bes>8 <c'>8 <d'>8 <ees'>8) <d'>4.-. <bes>4.-.
                                                            } <g>4-. r2. \times 2/3
                                                                                {   <g>8( <a>8 <bes>8 <c'>8 <d'>8 <ees'>8) <d'>4.-. <bes>4.-.
                                                                                } <g>4-.
               }
>>