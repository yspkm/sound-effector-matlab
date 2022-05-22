%{
    Copyright (c) 2022 Yosep Kim.
    See LICENSE for more information
    https://github.com/ypskm/sound-effect-matlab
%}


function [equalized_sound, fs] = get_equalized_sound(fname, channel, gain, fc1, fc2, N)
    [x_tot, fs] = audioread(fname);
    x = x_tot(:, channel);
    [b, a] = get_bpf(fc1, fc2, fs, N);
    adder_x = filter(b, a, x);
    %return
    equalized_sound = (x - adder_x)*(1/gain)+ (gain)*adder_x;

    get_cmp_fig(0:1:size(x, 1), fs, x, equalized_sound);
end

