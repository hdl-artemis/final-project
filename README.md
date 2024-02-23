## Introduction
Our task involved implementing an image processing algorithm using Verilog. The objective was to create a
Verilog program that performs fundamental image processing operations on a provided raw image file,
including grayscale conversion, brightness adjustment, and contrast enhancement.

## Objectives

* Learn how to read images in Verilog.
* Demonstrate proficiency in basic image processing operations and pixel manipulation using Verilog.
* Review Verilog system tasks and operations for practical implementation.
* Familiarize ourselves with fundamental image processing operations, including:
    - Manipulation of Bitmap
    - Changing colors
    - Increasing sharpness
    - Grayscale conversion
    - Adjusting colors

## Usage

To run the program, you will need to have Verilog installed (iverilog in path). Once you have Verilog installed, you can run the following commands:

```sh
make run
```
This will run the program and display the output.

```sh
make clean
```

This will remove the output files.

## Notes

Verilog cannot directly read image files. This is why, instead we convert the
image into hex values and then read the hex values in Verilog.

## Requirements

* Verilog (we used v12)
* Make -> optional, but *makes* life easier (pun intended)