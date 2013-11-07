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
    \new Staff {   \set Staff.instrumentName = "" <b>4( <c'>4) <c'>4( <b>4~ <b>4) <b>4( <c'>4 <d'>4) <b>4 <c'>4 <b>2 <e'>4( <d'>4 <b>4 <c'>4) <b>2 <d'>4 <e'>4 <b>4 <c'>2 <b>4 <b>4( <c'>4) <c'>4( <b>4~ <b>4) <b>4( <c'>4 <d'>4) <b>4 <c'>4 <b>2 <e'>4( <d'>4 <b>4 <c'>4) <b>2 <d'>4 <e'>4 <b>4 <c'>2 <b>4 r1 r1 r1 r1 \clef alto <b>4( <cis'>4) <cis'>4( <b>4~ <b>4) <b>4( <cis'>4 <d'>4) <b>4 <cis'>4 <b>2 <e'>4( <d'>4 <b>4 <cis'>4) <b>2 <d'>4 <e'>4 <b>4 <cis'>2 <b>4 <b>4( <cis'>4) <cis'>4( <b>4~ <b>4) <b>4( <cis'>4 <d'>4) <b>4 <cis'>4 <b>2 <e'>4( <d'>4 <b>4 <cis'>4) <b>2 <d'>4 <e'>4 <b>4 <cis'>2 <b>4
               }
    \new Staff {   \set Staff.instrumentName = "" r1 r1 r1 r1 r1 r1 r1 <b>4.( <c'>4.) <c'>4~( <c'>8 <b>2.) <b>8~( <b>4 <c'>4. <d'>4.) <b>4. <c'>4. <b>4~ <b>2 <e'>4.( <d'>8~ <d'>4 <b>4. <c'>4.) <b>2. <d'>4~ <d'>8 <e'>4. <b>4. <c'>8~ <c'>8~ <c'>2 <b>4. r1 r1 r1 r1 r1 r1 r1 \clef alto <b>4.( <cis'>4.) <cis'>4~( <cis'>8 <b>2.) <b>8~( <b>4 <cis'>4. <d'>4.) <b>4. <cis'>4. <b>4~ <b>2 <e'>4.( <d'>8~ <d'>4 <b>4. <cis'>4.) <b>2. <d'>4~ <d'>8 <e'>4. <b>4. <cis'>8~ <cis'>8~ <cis'>2 <b>4.
               }
>>