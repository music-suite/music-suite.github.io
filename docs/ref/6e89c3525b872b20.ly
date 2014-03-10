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
    \new Staff {   \set Staff.instrumentName = "" \set Staff.shortInstrumentName = "" \time 4/4 \clef treble {   d'4 g'8 fis'8 bes'2
                                                                                                             } f'4 bes'8 a'8 des''2 bes'4 ees''8 d''8 ges''2 a'4 d''8 cis''8 f''2 d'4 g'8 fis'8 bes'2 f'4 bes'8 a'8 des''2 bes'4 ees''8 d''8 ges''2 a'4 d''8 cis''8 f''2 d'4 g'8 fis'8 bes'2 f'4 bes'8 a'8 des''2 bes'4 ees''8 d''8 ges''2 a'4 d''8 cis''8 f''2 d'4 g'8 fis'8 bes'2 f'4 bes'8 a'8 des''2 bes'4 ees''8 d''8 ges''2 a'4 d''8 cis''8 f''2 d'4 g'8 fis'8 bes'2 f'4 bes'8 a'8 des''2 bes'4 ees''8 d''8 ges''2 a'4 d''8 cis''8 f''2 d'4 g'8 fis'8 bes'2 f'4 bes'8 a'8 des''2 bes'4 ees''8 d''8 ges''2 a'4 d''8 cis''8 f''2 d'4 g'8 fis'8 bes'2
               }
>>