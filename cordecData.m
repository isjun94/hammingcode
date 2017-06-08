function [decodedData] = cordecData(m, data)
% Correct and decode data using general algorithm
%
% Author : Insung Jun
% Date : June 07. 2017
%

[hamm_corrected] = correctData(m, data);
[hamm_deocded] = decodeData(m, hamm_corrected);
decodedData = hamm_deocded';