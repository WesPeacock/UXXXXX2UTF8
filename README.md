# UXXX2UTF8

A series of scripts for converting UTF-8 text to and from U+XXXXX format.

The Standard Format import function of FLEx doesn't handle UTF-8 characters from every Unicode block properly.
This repo provides a work-around for this problem.

The work-around uses two scripts written in Perl.
One script converts the Unicode text from certain SFM fields into a form that can be imported by FLEx.
Each character in the field is changed to the corresponding U+XXXXX form where the XXXXX is the hexidecimal Unicode encoding of the character.
The U+XXXXX form is not really legible, but can be imported into FLEx

After import into FLEx, You will run a second Perl script within FLEx to convert the text in those FLEx back into UTF-8 text.

Required Software:

1) These instructions are for Microsoft Windows.
2) A version of Perl must be installed on Windows. Strawberry Perl is recommended. Available [here.](https://strawberryperl.com/)
3) The SIL Encoding Converters. Available [here](https://software.sil.org/silconverters/) Make sure the Perl Expressions Transduction Engine is selected.:

![Perl Expressions](./Perl%20Expresssions.png "Perl Expressions Transduction Engine")


