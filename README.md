perl-extensions
=================

This project is a demonstration of how to build perl wrappers for a C program that uses structs and has complicated arguments. I have built the wrapper using both SWIG (in two mechanisms) and perlguts. This is the perl equivalent of the python swig project I had done earlier.

To build and install all the perl extensions:

> make -f Makefile.main

This generates the swig wrapper files and also compiles the extension.

> sudo make install

This installs the extension.

Testing extensions after installation:
> perl test.pl

Objectives::

What the C Program does:
* The C header file defines a simple struct 'MYService' with just a string value in it.
* Various methods are defined to create and return MYService * as well as MYService **.
* In the fill_* methods, an address pointer (to MYService ** or MYService *** ) is passed and this pointer is filled up.

What the Perl wrappers need to do:
* For the get_* methods, since the MYService struct in C contains just a string, the perl binding can simply return a string value or a list of strings in python.
* For the fill_* methods, perl code cannot pass pointers and hence the last argument for these methods need to be converted into the return value.
* For the fill_* methods, The actual integer return value can be used to indicate whether the operation succeeded or not i.e. throw a perl Runtime Exception if something goes wrong.

Description::

SWIG Wrapper:
* To wrap the fill_* methods, converting the value of MYService stringEntry into a string and return a list of strings.
* Quite a bit of explanations on how the wrappers were written is in the example.i file. I have used typemaps extensively to do this.

XS Wrappers(Not done):
* Whether you are using SWIG or XS, learning perlxs is a must. It teaches you how XS wrappers are built, and how to naturally extend perl.
* I did not implement the XS wrapper for this application as I did not plan to use it anyway. But the official documentation is a must read before proceeding.

Conclusion::
* Much misery was endured to figure all this out! Hope you, the reader, have an easier time...
* Please check the notes file in same repository for details.
