#99:approximate_256   this none this rxd

"Attempt to downscale a 24-bit RGB color into an 8-bit 256 color.";
"Disclaimer: Looks terrible.";
{r, g, b} = args;
red = toint(r) * 8 / 256;
green = toint(g) * 8 / 256;
blue = toint(b) * 7 / 256;
ret = red << 5 |. green << 2 |. blue;
return ret;
