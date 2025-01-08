# UXXX2UTF8

A series of scripts for converting UTF-8 text to and from U+XXXXX format.

The Standard Format import function of FLEx doesn't properly handle UTF-8 characters from the Unicode [Supplementary Multilingual Plane](https://en.wiktionary.org/wiki/Appendix:Unicode#Plane_1:_Supplementary_Multilingual_Plane).
This repo provides a work-around for this problem.

The work-around uses two scripts written in Perl.
One script converts the Unicode text from certain SFM fields into a form that can be imported by FLEx.
Each character in the field is changed to the corresponding U+XXXXX_ form where the XXXXX is the hexidecimal Unicode encoding of the character.
The U+XXXXX_ form is not really legible, but can be imported into FLEx

After import into FLEx, You will run a second Perl script within FLEx to convert the text in those FLEx fields back into UTF-8 text.

Required Software:

1) These instructions are for Microsoft Windows.
2) A version of Perl must be installed on Windows. Strawberry Perl is recommended. Available [here.](https://strawberryperl.com/)
3) The SIL Encoding Converters. Available [here](https://software.sil.org/silconverters/) Make sure the Perl Expressions Transduction Engine is selected.:

![Perl Expressions](./Perl%20Expresssions.png "Perl Expressions Transduction Engine")

## Encoding UTF8 to U+XXXXX_
The perl script `Ucode.pl` converts text from UTF-8 to U+XXXXX_ format.
The texts of specified SFMs to be converted (lx, se and xv are the defaults).
For example, this line from the Sample SFM file
````
\lx ellohay👋 orldway🌐
````
is changed to:
````
\lx U+0065_U+006C_U+006C_U+006F_U+0068_U+0061_U+0079_U+1F44B_U+0020_U+006F_U+0072_U+006C_U+0064_U+0077_U+0061_U+0079_U+1F310_
````
Code for creating a Converter that does this in the SIL Encoding Converters is in *Ucodesnippet.txt*
### Bugs In SIL Perl Encoding Converter
The SIL Perl Encoding Converter has two bugs.
The code included in the snippets contains work-arounds to avoid the bugs, but care must be taken to follow exactly the instruction in the code snippets.
Here are the bugs that are avoided:
  - The code passed to the converter must end with a semicolon.
	- The converter will accept code without a trailing semicolon, but it will fail with an obscure message on execution.
  - The Encoding Converter tries to use the Perl code to create a name for the converter. Some Perl code causes a crash when it tries to create a dialog box for the name.
	- If you initially create a converter using simple perl code, you can create a dummy converter and name it what you want.
	- Once the converter is created and named, you can modify it to use the code that does the work, but would otherwise cause the name dialog box to crash.
## Decoding U+XXXXX_ to UTF8
This section discusses the decode process which is the inverse function of the previous section.
The perl script `Udecode.pl` converts text from U+XXXXX_ to UTF-8 format.
The texts of specified SFMs to be converted (lx, se and xv are the defaults).
For example, this line from the Sample SFM file
````
\lx U+0065_U+006C_U+006C_U+006F_U+0068_U+0061_U+0079_U+1F44B_U+0020_U+006F_U+0072_U+006C_U+0064_U+0077_U+0061_U+0079_U+1F310_
````
is changed to:
````
\lx ellohay👋 orldway🌐
````
Code for creating a Converter that does this in the SIL Encoding Converters is in *Udecodesnippet.txt*

The note above about bugs in the Perl Encoding Converter also apply here.
