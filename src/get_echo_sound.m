%{
    Copyright (c) 2022 Yosep Kim.
    See LICENSE for more information
    https://github.com/ypskm/sound-effect-matlab
%}
function [echo_sound, fs] = get_echo_sound(fname, channel, num_echo, bool_want_plot, fade_rate)
    [x_tot, fs_tot] = audioread(fname);
    fs = fs_tot;
    x = x_tot(:,channel);

    echo_frac_n = linspace(0, 1, num_echo+1); 

    h = zeros(num_echo, size(x, 1)+1);
    
    % number of index
    n = 0:1:size(x, 1);

    %calculate impulse response
    for i = 1:num_echo
        h(i,:) = dirac(n - round(echo_frac_n(i)* fs));
        index = h(i,:) == Inf;
        h(i, index) = fade_rate^((1/num_echo)*(i-1));
    end

    h_tot = sum(h);

    %get echo sound
    echo_sound = conv(x,h_tot);
    %remove silent part at the end
    echo_sound = echo_sound(1, 1:size(x, 1) + (fs * 0.75));

    if(bool_want_plot)
        get_cmp_fig(n, fs, x, echo_sound);
    end

end