function [demodata] = bpsk_mod_demod(data, sgma)

% BPSK Modulation
[tx_data] = bpsk_mod(data);

% AWGN channel
[awgn_data] = channel_awgn(tx_data, sgma);

% BPSK Demodulation
[demodata] = bpsk_demod(awgn_data);