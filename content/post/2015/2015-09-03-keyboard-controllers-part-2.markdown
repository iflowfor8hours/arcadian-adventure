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

## Keyboard Switches to Microcontroller interface

If the [schematic](/12keykeyboard.jpg) in the previous part was not very helpful for understanding what is going on inside the keyboard, I found some excellent pictures from a custom keyboard build by a user named matt3o on the [deskauthority forums](http://deskthority.net/workshop-f7/brownfox-step-by-step-t6050.html). He took a lot of excellent photos while building his 'brownfox' keyboard. 

First, he wired the switches in rows, using diodes.
![Detail of rows of switches](/rowsdetail.jpg)

As you can see from further away, they are wired in serial and don't terminate anywhere yet.
![Rows fully wired](/rows.jpg)

Next, the columns were wired up, also in serial. He used insulation to keep the vertical wires from touching the exposed wiring of the diode legs. He passed the wiring underneath to keep it neat and easily debuggable if something went wrong.
![Rows and Columns fully wired](/rowsandcolumnswired.jpg)

Lastly, he wired the individual rows and columns to to a microcontroller. In this case a teensy 2.0, commonly used in keyboard projects because of its small size and the availability of good, open-source and battle tested firmware available for it. The high number of inputs and low power consumption are also key factors in this decision. 
![Controller wired up](/controllerfullywired.jpg)


Those are the essential hardware components of any keyboard. Some switches, a wiring matrix and a controller. We'll have more detail on how the controller software works in the next post.





## What is USB-HID?

USB HID is the [Human Interface Device](https://en.wikipedia.org/wiki/USB_human_interface_device_class) standard used by USB to deal with interfaces devices. 
The HID standard specifies a set of descriptors and protocols that the author of a device driver or any of software can choose what to do with. This gives a great level of flexibility in what HID can be used for. A simple example would be a two button mouse. Once a device negotiates with HID that it is a mouse, HID provides an interface that allows the mouse to specify a very limited number of variables as they come through the hardware to the HID. Namely the state of the two buttons, and the X and Y displacement. Driver authors and hardware manufacturers can extend this to other functionality your mouse probably has, like a scrollwheel and a third button, but HID takes care of the basic hardware to host communication. 

This topic can be researched quite easily if you are interested by reading the [standard itself](http://www.usb.org/developers/hidpage/) if that kind of thing is up your alley. I found this aptly named resource to be particularly helpful, [USB Made Simple](http://www.usbmadesimple.co.uk/ums_5.htm).

##

