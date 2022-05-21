%{
    Copyright (c) 2022 Yosep Kim.
    See LICENSE for more information
    https://github.com/ypskm/sound-effect-matlab
%}
function [b, a] = get_bpf(fc1, fc2, fs, N)
    % FIR Window Bandpass filter designed using the FIR1 function.
    % All frequency values are in Hz.
    % fs: Sampling Frequency
    % N: Order
    % fc1: First Cutoff Frequency
    win = blackman(N + 1);
    % return
    b = fir1(N, 2*[fc1 fc2] / fs, 'bandpass', win, 'scale');
    a = [1];
end
