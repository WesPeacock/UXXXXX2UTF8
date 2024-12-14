# UXXX2UTF8
A series of scripts for converting UTF-8 text to and from U+XXXX format.

The Standard Format import function of FLEx doesn't handle UTF-8 characters from every Unicode block properly.
This repo provides a work-around for this problem.

The work-around uses two scripts written in Perl.
One script converts the Unicode text from certain SFM fields into a form that can be imported by FLEx.
Each character in the field is changed to the corresponding U+XXXXX form where the XXXXX is the hexidecimal Unicode encoding of the character.
The U+XXXXX form is not really legible, but can be imported into FLEx
After import, a second script can be run within FLEx to convert the text back into UTF-8 text.

For examples of SFM text see [MDF_2000.pdf](https://s3.amazonaws.com/downloads.sil.org/legacy/shoebox/MDF_2000.pdf).
