# ImageJ_Align_2WB
## Intro
For in-vitro protein-protein interation studys using western blotting, researchers often blot the membrane with two different probes. This often results in probing, stripping and reprobing. In this case, two sets of the visible and chemilumescent images will be generated. This macro allows user to align two sets of western blottng results of the same membrane after stripping and reprobing.
## Why do you want to use this macro
Yes, you can do the alignment and stacking with all the built-in scripts in FIJI (FIJI IS IMAGEJ). It probably costs you about 100 mouse/keyboard inputs to get the job done (assuming you did everything correct in the first place). Once you have tones of results you might just go crazy by align and stack them one by one. I put those repeating tasks into a macro to protect you from arthritis (more likely just to kill my time while waiting my electrophrosis to finish) so you only need about 15 inputs to get the job done. This probably won't be very useful for a lot of people, but myself will definitely benefit from it.
## How to use it
### Preparation
1. You will need to install FIJI (FIJI IS IMAGEJ). I haven't tested this in plain IMAGEJ (too lazy).
2. You need to download 'Align_2WB.ijm'.
3. Two sets of your western blot results. Each set need have one visible and one chemilumescent image (they should be perfectly align, if you take them using the same instriment at the same time). Two sets of you results have to be from the same membrane.
4. Drag those images (4 in total) in to FIJI.
### In FIJI (FIJI IS IMAGEJ)
1. Click Macro-Run and find your downloaded 'Align_2WB.ijm'.
2. In the drop-down list select what they are (VIS1, WB1, VIS2, WB2). Then click OK.
3. Wait until a window pops up asking you to draw a straight line. Draw one across the opposit corner. Then click OK.
4. Do the same thing to the other image. Draw a straight line across the same opposit corner. Then click OK.
5. Wait until a window pops up asking you to selecting color chennals. Pick your ideal color (I normally do red for WB1 and Green for WB2_Aligned). Then click ok. (I feel like I can just do red for WB1 and Green for WB2_Aligned by default without letting the user choose it, which saves you another 5 clicks)
6. Done! Now the two chemelumenescent images will be aligned and stacked onto each other and having the same field of view as the 1st visible image.
## P.S.
I only know how to do some light coding in python. This is the very first script I've written in JAVA with the help of ChatGTP. Any JAVA developer can finded a lot of redundence in my script, so please don't judge too hard about that. If you have any suggestion, feel free to tell me and I will be glad to make some improvement.
