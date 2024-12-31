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

## Encoding UTF8 to U+XXXXX
The perl script `Ucode.pl` converts text from UTF-8 to U+XXXXX format.
The texts of specified SFMs to be converted (lx, se and xv are the defaults).
For example, this line from the Sample SFM file
````
\lx ellohay👋 orldway🌐
````
is changed to:
````
\lx U+0065U+006CU+006CU+006FU+0068U+0061U+0079U+1F44BU+0020U+006FU+0072U+006CU+0064U+0077U+0061U+0079U+1F310
````
Code for creating a Converter that does this in the SIL Encoding Converters is in *Ucodesnippet.txt*


