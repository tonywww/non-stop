# non-stop
An application that moves the mouse when idle to disable the screen saver.

Modify from KillSaver.

# From .au3 to .exe
https://www.autoitscript.com/autoit3/docs/intro/compiler.htm

# AutoIt Downloads
https://www.autoitscript.com/site/autoit/downloads/

# Are my AutoIt EXEs really infected?
Copy and Pasted from https://www.autoitscript.com/forum/topic/34658-are-my-autoit-exes-really-infected/

If you have been using AutoIt for any length of time you will know that it is a great, and powerful scripting language. As with all powerful languages there comes a downside. Virus creation by those that are malicious.

AutoIt has no virii installed on your system, and if a script you have created has been marked as a virus, (and you're not malicious) then this is a false positive. They found a set of instructions in an AutoIt EXE out there somewhere, took the general signature of the file, and now all AutoIt EXE's are marked (or most of them). This can be due to several reasons.

AutoIt is packed with UPX. UPX is an open source software compression packer. It is used with many virii (to make them smaller).
Malicious scripter got the AutoIt script engine recognized as a virus.
And I am sure there are more ways your executable could be marked, but that covers the basics.
Now I am sure you are wanting to know what you can do to get back up and running without being recognized as a virus. You have to send in a report to the offending AV company alerting them to the false positive they have made. It never hurts to send in your source code along with a compiled exe, to help them realize their mistake.

You may have to wait up to 24 hours for them to release an update. The time it takes really depends on the offending AV company.
