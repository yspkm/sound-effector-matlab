%% #### Recommend not to change other codes except the parameter value!! #####
%% matlab Data expression
% All variables are expressed as a matrix
% m = 3; 1 by 1 matrix of its element is 3
% m = [1 1; 2 3]; 2 by 2 matrix. row 1: 1 1. row 2: 2 3.
% m(x,y); element at row x, column y
% m(:,y); elements in column y

%%
clear
clc
close all
%% Parameter settings

% #1. Enter the length of time of .wav source file (unit: second (ex) 2:30 -> 150)
t_len = 10.1108;

%% Read .wav file into numerical value
[m,sample_freq] = audioread('4seconds.wav');
t = linspace(0,t_len,length(m(:,1)));

% Extract left, right signals
m1 = m(:,1); % left channel
m2 = m(:,2); % right channel 

% Create .wav file of left, right sound
% audiowrite('mono1.wav',m1,sample_freq)
% audiowrite('mono2.wav',m2,sample_freq)

%% Processing
% Example: filter design 
% you may use fir1() for the design of a low pass filte
% filter design 
b=[1];
a=[1]; 

% filtering 
m1_fout = filter(b,a,m1);
m2_fout = filter(b,a,m2);

% you can try other processing such as 'echo effect' or 'equalization' 
y1 = m1_fout; 
y2 = m2_fout; 

%audiowrite('output_signal_left.wav',y1,sample_freq)
%audiowrite('output_signal_right.wav',y2,sample_freq)

% Composition of the output 
y = [];
y(:,1) = y1;
y(:,2) = y2;
audiowrite('processed.wav',y,sample_freq)

%% Observe the signal waveform
figure('Name','Original left channel')
plot(t,m1,'b.:')
axis([0 t_len -1 1])
title('Original mono')
xlabel('time [sec]')
ylabel('amplitude')
grid

figure('Name','Original left channel (close up)')
plot(t,m1,'b.:')
axis([1.00 1.05 -1 1])  % Set the range of x axis as 40 ~ 80, y axis as (-1 ~ 1)
title('Original mono(close up)')
xlabel('time [sec]')
ylabel('amplitude')
grid
