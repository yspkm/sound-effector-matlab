%{
    Copyright (c) 2022 Yosep Kim.
    See LICENSE for more information
    https://github.com/ypskm/sound-effect-matlab
%}

function main(fname)
    fname = strcat('../dat/input/', fname);

    [X, FS] = audioread(fname);
    x1 = X(:, 1);
    x2 = X(:, 2);

    bass = [20, 300];
    middle = [300, 6 * 10^3];
    treble = [6 * 10^3, 20 * 10^3];
    N = 8192;

    %original file backup 
    audiowrite('../dat/output/original.wav', X, FS);

    %low pass filter
    [b_lpf, a_lpf] = get_lpf(300, FS, N);
    lpf_sound(:, 1) = filter(b_lpf, a_lpf, x1);
    lpf_sound(:, 2) = filter(b_lpf, a_lpf, x2);
    get_cmp_fig(0:1:size(x2, 1), FS, x2, lpf_sound(:, 2));
    audiowrite('../dat/output/processed_lpf.wav', lpf_sound, FS);

    %high pass filter
    [b_hpf, a_hpf] = get_hpf(300, FS, N);
    hpf_sound(:, 1) = filter(b_hpf, a_hpf, x1);
    hpf_sound(:, 2) = filter(b_hpf, a_hpf, x2);
    get_cmp_fig(0:1:size(x2, 1), FS, x2, hpf_sound(:, 2));
    audiowrite('../dat/output/processed_hpf.wav', hpf_sound, FS);

    %band pass filter
    [b_bpf, a_bpf] = get_bpf(300, 3000, FS, N);
    bpf_sound(:, 1) = filter(b_bpf, a_bpf, x1);
    bpf_sound(:, 2) = filter(b_bpf, a_bpf, x2);
    get_cmp_fig(0:1:size(x2, 1), FS, x2, bpf_sound(:, 2));
    audiowrite('../dat/output/processed_bpf.wav', bpf_sound, FS);

    % double echo
    [echo_sound_double(:, 1), fs] = get_echo_sound(fname, 1, 2, true, 0.61);
    [echo_sound_double(:, 2), fs] = get_echo_sound(fname, 2, 2, true, 0.61);
    audiowrite('../dat/output/processed_echo_double.wav', echo_sound_double, fs);

    % quad echo
    [echo_sound_quad(:, 1), fs] = get_echo_sound(fname, 1, 4, true, 0.61);
    [echo_sound_quad(:, 2), fs] = get_echo_sound(fname, 2, 4, true, 0.61);
    audiowrite('../dat/output/processed_echo_quad.wav', echo_sound_quad, fs);

    % bass boost equalizer
    [equalized1(:, 1), fs] = get_equalized_sound(fname, 1, 4.5, bass(1), bass(2), N);
    [equalized1(:, 2), fs] = get_equalized_sound(fname, 2, 4.5, bass(1), bass(2), N);
    audiowrite('../dat/output/processed_eq_bass.wav', equalized1, fs);

    % middle boost equalizer
    [equalized2(:, 1), fs] = get_equalized_sound(fname, 1, 4.5, middle(1), middle(2), N);
    [equalized2(:, 2), fs] = get_equalized_sound(fname, 2, 4.5, middle(1), middle(2), N);
    audiowrite('../dat/output/processed_eq_middle.wav', equalized2, fs);

    % treble boost equalizer
    [equalized3(:, 1), fs] = get_equalized_sound(fname, 1, 4.5, treble(1), treble(2), N);
    [equalized3(:, 2), fs] = get_equalized_sound(fname, 2, 4.5, treble(1), treble(2), N);
    audiowrite('../dat/output/processed_eq_treble.wav', equalized3, fs);

    % pitch up -> time domain compression
    audiowrite('../dat/output/processed_pitch_up.wav', X, fs*2);
    % pitch down -> time domain tension
    audiowrite('../dat/output/processed_pitch_down.wav', X, fs/2);
end
