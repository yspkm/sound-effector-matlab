%{
    Copyright (c) 2022 Yosep Kim.
    See LICENSE for more information
    https://github.com/ypskm/sound-effect-matlab
%}
function get_cmp_fig(n, fs, original_signal, modified_signal)
    % fs:sample_rate;
    x = original_signal;
    mdf_x = modified_signal;

    %figure('Time Domain');
    figure
    subplot(2, 1, 2);
    plot(n(1, 1:fs), mdf_x(1:fs));
    axis([0, fs, min(mdf_x(1:fs)), max(mdf_x(1:fs))]);
    title('Processed Sound in Time Domain');
    xlabel('DT Index');
    ylabel('Processed Sound');

    subplot(2, 1, 1);
    plot(n(1, 1:fs), x(1:fs));
    axis([0, fs, min(mdf_x(1:fs)), max(mdf_x(1:fs))]);
    title('Original sound in Time Domain');
    xlabel('DT Index');
    ylabel('Original Sound');

    figure
    subplot(2, 1, 2);
    semilogx(n(1, 1:fs), abs(fft(mdf_x(1:fs))));
    temp = abs(fft(mdf_x(1:fs)));
    axis([0, fs, min(temp), max(temp)+10]);
    title('Processed Sound in Frequency Domain');
    xlabel('DT Index');
    ylabel('Processed Sound');

    subplot(2, 1, 1);
    semilogx(n(1, 1:fs), abs(fft(x(1:fs))));
    axis([0, fs, min(temp), max(temp)+10]);
    title('Original sound in Frequency Domain');
    xlabel('DT Index');
    ylabel('Original Sound');

end