%{
    Copyright (c) 2022 Yosep Kim.
    See LICENSE for more information
    https://github.com/ypskm/sound-effect-matlab
%}

function [b, a] = get_hpf(fc, fs, N)
    % FIR Window Lowpass filter designed using the FIR1 function.
    % All freq in Hz.
    % fs: Sampling Frequency
    % fc: Cutoff Frequency 
    % N: Order

    win = 2 * fc / fs; % (rad/sample /pi)
    b = fir1(N, win, 'high'); % coefficients of x in difference equations
    a = [1];
end
