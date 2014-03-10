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
    \new Staff {   \set Staff.instrumentName = "" \set Staff.shortInstrumentName = "" \time 4/4 \clef treble {   a,8 b,8 c8 d8 e8 f8 g8 a8
                                                                                                             } \clef treble {   b8 c'8 d'8 e'8 f'8 g'8 a'8 b'8
                                                                                                                            } \time 1/8 c''8
               }
>>