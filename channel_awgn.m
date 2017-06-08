function [awgn_data] = channel_awgn(tx_data,sgma)

inoise = randn(1,length(tx_data)).*sgma;
qnoise = 1j.*randn(1,length(tx_data)).*sgma;
awgn_data = tx_data + inoise + qnoise; 


end

