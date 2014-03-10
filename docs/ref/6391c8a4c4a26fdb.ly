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
    \new Staff {   \set Staff.instrumentName = "" \set Staff.shortInstrumentName = "" \time 4/4 \clef treble {   \times 2/3
                                                                                                                        {   c'4 d'4 e'4
                                                                                                                        } \times 2/3
                                                                                                                                 f'2.
                                                                                                             } g'1
               }
>>