+++
layout = "single"
title = "Keyboards and how they work Part 2"
date = "2015-08-27"

+++

I left off in [the last post]({{< ref "post/2015/2015-08-27-keyboard-snobbery.markdown" >}}) talking about how the internals of a PS2 keyboard and the hardware inside them work. In this one I intend to explain more about how custom controllers like [Soarer's convertor](https://geekhack.org/index.php?topic=17458.0), [HaaTa's KiiboHD](https://github.com/kiibohd/controller) and [TMK](https://github.com/tmk/tmk_keyboard) work to communicate with the USB-HID subsystem of the operating system.

## So how does a USB keyboard work?

Heading back towards the hardware, we can think about the microcontroller in 3 discrete components: 

* *The scan module:* This is what was discussed in the previous post. It takes the state of the keys on the board and turns them into scancodes for the translation module to interpret. Most of the time, when customizing a keyboard "in hardware", the layering and most of the configuration happens here.

* *The translation module:* This module of code takes the scancodes and maps them to USB-HID output codes, or whatever sort of output you might want like midi or physical interfaces. USB-HID being the most likely for keyboards is the one we will discuss now. This is can also be known as the macro module.

* *The output module:* This sends signals to the device it is attached to over the protocol decided in the translation module, again most often USB, but in the cases of Soarer's convertor, it can output many different kinds of proprietary keyboard protocols.

The image below is from the great [Massdrop article](https://www.massdrop.com/article/introduction-to-keyboard-programming) by HaaTa (registration annoyingly required). I hope to go into a bit more detail about the specifics of how the firmware communicates with the HID subsystem, the kernel, your window manager, and eventually whatever application is using it.

![Switches Diagram](/switches-diagram.png)


