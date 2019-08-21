function [ eta ] = F_eta( SWC )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
SWC_max = nanmax(SWC);
SWC_min = nanmin(SWC);
SWC_range = SWC_max - SWC_min;
eta_1 = 1;
eta_2 = 10./3.*(SWC - SWC_min)./ SWC_range;

N = length(SWC);
eta = zeros(N,1);
for i = 1:N
    if eta_2(i) < eta_1
        eta(i) = eta_2(i);
    else
        eta(i) = eta_1;
    end
end

end

