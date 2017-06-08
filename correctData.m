function [data_corrected] = correctData(m, data_hamm_rx)
% Checks error and correct data using general algorithm
%
% Author : Insung Jun
% Date : June 07. 2017
%
% Generate matrices for hamming coding
[H, ~, ~, n, ~] = hmGenerator(m);
% H : parity-check matrix
% G : generator matrix
% R : recover matrix
% n : block length
% k : message length

data_hamm_rx = reshape(data_hamm_rx, n, []);
nd = size(data_hamm_rx,2);

%% Parity-check received data

% Multiply received data with parity-check matrix
data_hamm_error_corrected = data_hamm_rx;

data_hamm_parity_check = H * data_hamm_rx;
data_hamm_parity_check = rem(data_hamm_parity_check, 2);
data_parity_error = bi2de(data_hamm_parity_check', 'right-msb');

% Find out which data is broken and fix the data
for i=1:nd
    if data_parity_error(i)
        data_hamm_error_corrected(data_parity_error(i), i) = not(data_hamm_error_corrected(data_parity_error(i),i));
    end 
end

data_corrected = reshape(data_hamm_error_corrected, 1, []);