# UXXX2UTF8

A series of scripts for converting UTF-8 text to and from U+XXXXX_ format.

The Standard Format import function of FLEx doesn't properly handle UTF-8 characters from the Unicode Plane 1, the  [Supplementary Multilingual Plane](https://en.wiktionary.org/wiki/Appendix:Unicode#Plane_1:_Supplementary_Multilingual_Plane).
The Unicode Plane 1 contains a number of alphabets and the section set aside for emojis.
This repo provides a work-around for this problem.

The work-around uses two scripts written in Perl.
One script converts the Unicode Plane 1 text from certain SFM fields into a form that can be imported by FLEx.
Each Plane 1 character in the field is changed to the corresponding U+XXXXX_ form, where the XXXXX is the hexidecimal Unicode encoding of the character.
The U+XXXXX_ form is not really legible, but can be imported into FLEx.

After import into FLEx, you will run a second Perl script within the Bulk Edit function in FLEx to convert the text in those FLEx fields back into UTF-8 text.

Required Software:

1) These instructions are for Microsoft Windows.
2) A version of Perl must be installed on Windows. Strawberry Perl is recommended. Available [here.](https://strawberryperl.com/)
3) The SIL Encoding Converters. Available [here](https://software.sil.org/silconverters/) Make sure the Perl Expressions Transduction Engine is selected.:

![Perl Expressions](./Perl%20Expresssions.png "Perl Expressions Transduction Engine")

## Encoding UTF8 to U+XXXXX_
The perl script `Ucode.pl` converts the Unicode Plane 1 text from UTF-8 to U+XXXXX_ format.
The texts of specified SFMs to be converted (lx, se and xv are the defaults).
For example, this line from the Sample SFM file
````
\lx ellohay👋 orldway🌐
````
is changed to:
````
\lx ellohayU+1F44B_ orldwayU+1F310_
````
Code for creating a Converter that does this in the SIL Encoding Converters is in *Ucodesnippet.txt*. Once the encoding converter is set up, the function of the perl script `Ucode.pl` could be performed by the SIL SFM converter.

### Bugs In SIL Perl Encoding Converter
The SIL Perl Encoding Converter has two bugs.
The code included in the snippets contains work-arounds to avoid the bugs, but care must be taken to follow exactly the instruction in the code snippets.
Here are the bugs that are avoided:
  - The code passed to the converter must end with a semicolon.
	- The converter will accept code without a trailing semicolon, but it will fail with an obscure message on execution.
  - The Encoding Converter tries to use the Perl code to create a name for the converter. Some Perl code causes a crash when it tries to create a dialog box for the name.
	- If you initially create a converter using simple perl code, you can create a dummy converter and name it what you want.
	- Once the converter is created and named, you can modify it to use the code that does the work, but would otherwise cause the name dialog box to crash. 

## Decoding U+XXXXX_ to UTF8
This section discusses the decode process which is the inverse function of the previous section.
The perl script `Udecode.pl` converts text from U+XXXXX_ to UTF-8 format.
The texts of specified SFMs to be converted (lx, se and xv are the defaults).
For example, this line from the Sample SFM file
````
\lx ellohayU+1F44B_ orldwayU+1F310_
````
is changed to:
````
\lx ellohay👋 orldway🌐
````
Code for creating a Converter that does this in the SIL Encoding Converters is in *Udecodesnippet.txt*

The note above about bugs in the Perl Encoding Converter also apply here.

## Encoding and Decoding an entire file

Rather than encoding/decoding just certain SFMs, you may want to process an entire file.
The scripts `UcodeTxt.pl` and `UdecodeTxt.pl` will do that.
Running the `UdecodeTxt.pl`  on a FLEx fwdata file should be able to decode the entire FLEx project, although this has not been tested.

## Notes on the U+XXXXX_ encoding scheme
The U+XXXXX_ encoding scheme was specifically chosen rather than the equivalent HTML \&#xXXXXX; encoding. This was done because it will not be interpreted by any program likely to be handling the data.
The trailing underscore disambiguates additional hexidecimal data (e.g., homograph numbers) following the data.
