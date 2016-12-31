+++
layout = "single"
title = "Building and configuring the WhiteFox keyboard"
date = "2016-12-30"
tags = [
  "keyboards",
  "whitefox",
  "hhkb",
  "MassDrop",
  "tmk"
  ]

+++

![WhiteFox Image Courtesy of https://www.reddit.com/user/Z085](whitefox-clean.jpg)

Weakness got the best of me, and I purchased the [WhiteFox keyboard kit](https://www.massdrop.com/buy/the-whitefox-keyboard) from Massdrop. Ever since I built my ErgoDox Infinity and played around with the TMK firmware to customize it, I've always wanted another fully-programmable 60% board like the [GH60](http://blog.komar.be/projects/gh60-programmable-keyboard/) or [GMK Infinity](https://www.massdrop.com/buy/infinity-keyboard-kit). Up to this point, I have settled for the significantly less expensive and less customizable Pok3r, and found some minor annoyances around remapping function keys enough to warrant the purchase. Sort of.

Standard MassDrop rules apply to this purchase, where you sink a ton of money into something, get really excited, then wind up waiting for what feels like forever for it to show up. I think from point of purchase to delivery was around 3 months, which is not that bad, but always feels weird. The forums on MassDrop are always full of people complaining about ship dates moving and problems with stock and whatever else anyone can whinge about. Get used to it, or just wait until the massdrop ship date when reddit /r/mechmarket is suddenly flooded with people who bought other boards in the meantime and then suddenly realized they own far more keyboards than they wanted. 

Purchase and Delivery
----

The packaging and delivery of the board itself was extremely impressive. My ErgoDox arrived in a plain box with all of the parts in plastic bags that were unlabeled and that was about it. Pretty standard for DIY stuff in my experience. The WhiteFox arrived in really fancy branded packaging, with all the components packed neatly in customized boxes padded for the components themselves in fancy feeling materials. I generally don't care about packaging, but this rivaled Apple's super-sexy product boxes and accessories. There are a bunch of photos from another /r/mechanicalkeyboards user [here if you want to have a look](https://imgur.com/a/1RRHP#jqvRIPc).
The sticker shock on this board is pretty serious. It was $250 all said and done because this board was pricey outright, and I went with Zealios 65g Purple Switches. Shockingly, I don't regret it yet. The build quality is really high on the plate, and the base. The cable that was included is good looking, the caps are more than sufficent and attractive.
I have another board that has the zelio switches in it, but I haven't used it much since I want a different plate for it. Word to the wise, 3d printing a plate makes for a really crappy feeling keyboard.

Assembly
----

The assembly itself was pretty straightforward. Everything fit as expected, the diodes were pre-installed on the PCB so the fussiest part of soldering everything was already done. Essentially you drop the switches in, solder them up to the board, add the LEDs, and call it a day. I *had* a couple of photos that I took during assembly, but I unfortunately lost my phone the day after I put this whole thing together, so managed to lose those as well. The [assembly guide](http://matt3o.com/how-to-build-your-whitefox/) by the board's creator is more than enough documentation to get this built easily and error-free.
In reading about other users assembly processes, it seems that there were a couple of manufacturing defect that effected many of the boards. I completely failed to notice them both. One of them was about the stabilizers for a few of the keys getting stuck under the edge of the keyswitch, causing them to fail to return up and get stuck. An exacto knife solves this problem, as long as you don't mind mangling the plastic on your key switches. If you do mind that, there are alternate solutions, or you may need an even more pointless and fidgety hobby. Like building high-end audio cables or modifying headphones. ლ(ಠ益ಠლ)
The other defect was more serious, and involved the legs on the switches begin too wide for the pre-drilled holes in the PCB, so when you tried to screw the plate into the base, you were exerting a lot of pressure and flex on to the PCB. This problem I noticed briefly while popping the first switches in, and noticed that you could just push a tad bit harder and seat the switches in very snugly. Surely not the most elegant of solutions, but definitely not something I personally will ever have to worry about, until I'm desoldering these switches because something horrible has happened to the board. Not going to optimize for that scenario.

Programming and Customization
----

The WhiteFox has more keys than I'm used to. There is an arrow cluster, which I have yet to touch because I have muscle-memorized a bunch of macros and shortcuts that I wrote using TMK features, like mapping the arrow keys the the vim-like HJKL on a layer below the default, moving all infrequently used keys to that layer as well. This makes it a problem when I'm using other keyboards and is the primary driving force for having access to this level of customization. That and the fun of being able to use mousekeys, macro keys, and other weird features that do make typing more pleasurable and efficient over time.
There are a number of different ways to program the layouts of this board, including the official channel of the gui-based [online configuration tool](https://input.club/configurator-whitefox/). This tool outputs a file that is ready to burn onto your board and be done with it. The disadvantage of this is that you don't have access to some of the really useful features that TMK offers you, including control of all those LEDs you just soldered into the switches. I skipped this and tried using the project that is the backend for that online tool, available from the [kiibohd github](https://github.com/kiibohd/controller). I have a lot to say about this piece of software, but will keep it brief.
The tooling around the software itself (build scripts, documentation, wrappers and the like) are fantastic. When I built the ErgoDox 3 years ago, figuring out all this was not exactly friendly or easy. These tools are pretty solid and mature at this point, and wouldn't feel too bad about telling someone to go RTFM when they hit issues :). The downside, is that they are in a constant state of rewrite. I seem to embark on a keyboard project every 2-4 months, and in that time, things have moved on frustratingly quickly and in what feels like a pretty disorganized fashion. There are a bunch of different versions of the spec for the KLL (Keyboard Layout Language) that are not particularly well documented, and there are many ways to implement the same functionality without a canonical suggestion of what the right way to do something might be, or if what you're trying to accomplish is even possible. I banged against this for FAR longer than I should have, until realizing that what I wanted to do (have the esc key emit a ~ when shift is pressed) is really not hard to do in "stock" TMK. I found a fork where someone had done the heavy lifting of mapping out the HID keycodes to reasonable names, then just implemented what I wanted in C. This is what worked for the HHKB TMK mod, and for the ErgoDox, and probably will be the approach that I stick to going forward.
All that being said, once I ditched all the new stuff and just ran with what I know, getting this board up to usable speed was quick and relatively painless. There are a couple of features that I would like to implement and probably will later this week including some fancy dimming stuff for the LEDs (I actually don't like the LEDs all that much, will probably just leave them off forever and have that be an expensive lesson), and the ability to drop the controller into programming mode without having to hit the little button on the back of the board.

Summary
---

I am a lot happier with this board than I thought I would be, and this has likely just become my daily driver for my work machine. It is less ugly and intimidating than my HHKB, so I'll likely get less weird looks at work. It has an arrow cluster, so when others are using it, they won't feel naked or stupid. The caps are labeled, so it doesn't carry the same amount of snark or superiority that a customized HHKB with no indications of anything does. All good things for a healthy working environment.

Drop me an email with any feedback, I nuked my twitter account.
