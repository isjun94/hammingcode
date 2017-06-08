function [rdata] = bpsk_demod(fading_data)
L = length(fading_data);
rdata = zeros(1,L);
for ii = 1 : length(fading_data)
        
    rdata(ii) = (fading_data(ii) >0);

end

end

