clear all
close all

%% Identify available monitors
Screens=Screen('Screens');
whichScreen=max(Screens); % this will select the external monitor when available (but not always)
% whichScreen=1;

%% Configure PTB
PsychImaging('PrepareConfiguration');
PsychImaging('AddTask', 'General', 'InterleavedLineStereo', 0); % this tells PTB to use two image buffers, one for each eye

%% Launch PTB on the selected monitor
[window, screenRect] = PsychImaging('OpenWindow', whichScreen);

%% Turn your images as 'textures'
image1 = imread('street1.jpg');
texture1=Screen('MakeTexture', window, image1);
image2 = imread('street2.jpg');
texture2=Screen('MakeTexture', window, image2);

image1Rect = [0 0 size(image1,2) size(image1,1)];
image2Rect = [0 0 size(image2,2) size(image2,1)];

%% Put your images in each of the two image buffers
Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture',window,texture1,image1Rect,image1Rect);

Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture',window,texture2,image2Rect,image2Rect);

%% Flip the image buffers on screen
vbl = Screen('Flip', window);
