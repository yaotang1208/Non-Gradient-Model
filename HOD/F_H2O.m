function [ Fv ] = F_H2O( Fv_S,Fv_N )
%UNTITLED3 Summary of this function goes here
%   calculate the real water vapor flux
N = length(Fv_S);
Fv = Fv_S;
    for i = 1:N
        if Fv_S(i) < 0
            if Fv_S(i) < Fv_N(i)
                Fv(i) = Fv_N(i);
            end
        end
    end

end

