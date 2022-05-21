%% Low pass filtering example 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
close all

% Parameter settings
t_duration = 30; 
Fs = 80; % sampling frequency. No smaller than double of maximum frequency of x.
t = 0:1/Fs:t_duration; % sample points in the observed interval.
x = 2*cos(2*pi*0.7*t) + 7*sin(2*pi*5*t) + 5*cos(2*pi*23*t); % sampled signal


%% Freq domain analysis of the signal
% fft(arg1,arg2): Fast Fourier Transform function
%   - arg1: a subject which is transformed
%   - arg2: # of frequency response sample points
xfft = fft(x);
L = length(xfft);

P2 = abs(xfft/L);
P1 = P2(1:floor(L/2)+1); % Only positive frequency components including DC component.
P1(2:end-1) = 2*P1(2:end-1); % One-sided spectrum has doubled amplitude that of double-sided spectrum.

f = Fs*(0:(L/2))/L; % Components of x is only located below Fs/2. 
plot(f,P1)
xlim([0 Fs/2])
xlabel('frequency [Hz]'); ylabel('amplitude'); title('Spectrum of x');

%% Low-pass filtering
% butter(arg1,arg2): butterworth filter model
%   - arg 1: order of the filter (The higher, the steeper the slope.)
%   - arg 2: cutoff frequency
% arg 2 is usually specified with target signal's sampling frequency. (Fs/2 term)
% Recommended not to use too much high value of arg1.

fc = 10 ;                   % filter cutoff frequency (in Hz) 
Omega_c = (fc/Fs)*2*pi;     % Omega_c (rad/sample) 

filter_n = 60;                      % filter order 
cutoff_w = 2*fc/Fs;                 % (rad/sample /pi)

b = fir1(filter_n,cutoff_w);        % coefficients of x in difference equations 
a = [1]; 

% Freqeuncy response of the filter given
figure
freqz(b,a);                         % shows H(e^(jOmega)) in log scale 
fvtool(b,a);                        % similar to freqz(.) 

% Filtering the signal
y = filter(b,a,x);

%% Filtered signal: Frequency domain analysis 
clear L P1 P2;

yfft = fft(y);
L = length(yfft);

P2 = abs(yfft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure
f = Fs*(0:(L/2))/L;
plot(f,P1);
xlim([0 Fs/2]);
xlabel('frequency [Hz]'); ylabel('amplitude'); title('Spectrum of y');
grid on; 