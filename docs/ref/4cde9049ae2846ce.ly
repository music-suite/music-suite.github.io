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
    \new Staff {   \set Staff.instrumentName = "" <b>2( <c'>2) <c'>2( <b>2~ <b>2) <b>2( <c'>2 <d'>2) <b>2 <c'>2 <b>1 <e'>2( <d'>2 <b>2 <c'>2) <b>1 <d'>2 <e'>2 <b>2 <c'>2~ <c'>2 <b>2 <b>2( <c'>2) <c'>2( <b>2~ <b>2) <b>2( <c'>2 <d'>2) <b>2 <c'>2 <b>1 <e'>2( <d'>2 <b>2 <c'>2) <b>1 <d'>2 <e'>2 <b>2 <c'>2~ <c'>2 <b>2 r1 r1 r1 r1 r1 r1 r1 r1 <b>2( <cis'>2) <cis'>2( <b>2~ <b>2) <b>2( <cis'>2 <d'>2) <b>2 <cis'>2 <b>1 <e'>2( <d'>2 <b>2 <cis'>2) <b>1 <d'>2 <e'>2 <b>2 <cis'>2~ <cis'>2 <b>2 <b>2( <cis'>2) <cis'>2( <b>2~ <b>2) <b>2( <cis'>2 <d'>2) <b>2 <cis'>2 <b>1 <e'>2( <d'>2 <b>2 <cis'>2) <b>1 <d'>2 <e'>2 <b>2 <cis'>2~ <cis'>2 <b>2
               }
    \new Staff {   \set Staff.instrumentName = "" r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 <b>2.( <c'>4~ <c'>2) <c'>2~( <c'>4 <b>2.~ <b>2.) <b>4~( <b>2 <c'>2~ <c'>4 <d'>2.) <b>2. <c'>4~ <c'>2 <b>2~ <b>1 <e'>2.( <d'>4~ <d'>2 <b>2~ <b>4 <c'>2.) <b>1~ <b>2 <d'>2~ <d'>4 <e'>2. <b>2. <c'>4~ <c'>1~ <c'>4 <b>2. r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 r1 <b>2.( <cis'>4~ <cis'>2) <cis'>2~( <cis'>4 <b>2.~ <b>2.) <b>4~( <b>2 <cis'>2~ <cis'>4 <d'>2.) <b>2. <cis'>4~ <cis'>2 <b>2~ <b>1 <e'>2.( <d'>4~ <d'>2 <b>2~ <b>4 <cis'>2.) <b>1~ <b>2 <d'>2~ <d'>4 <e'>2. <b>2. <cis'>4~ <cis'>1~ <cis'>4 <b>2.
               }
>>