
<!-- README.md is generated from README.Rmd. Please edit that file -->
screenshotr
===========

The goal of this package is to support a **shiny** gadget as an RStudio addin.

This addin will make it easier for you to insert screenshots into your R Markdown documents.

It is imagined that, to use the addin, you would follow these steps:

1.  Take the screenshot normally. On Mac, I find cmd-ctrl-shift-4 to be very useful.

2.  In RStudio's file-editor pane, place the cursor where you would like to insert your `![]()` code.

3.  On the addin, Click the paste-image button to paste the image to the addin.

4.  Specify the image scaling.

5.  Save the rescaled image to your filesystem.

6.  Click the paste-code button.

I imagine this will be use the **clipr** package and the **magick** package.