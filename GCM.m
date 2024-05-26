function [ov] = GCM(len,Iv)
% Constructing 3-D generalized chaotic sequence
% len：length of generated chaotic sequence，Iv：initial states of chaotic map
    cx = zeros(1,len); cy = zeros(1,len); cz = zeros(1,len); 
    cx(1) = Iv(1); cy(1) = Iv(2); cz(1) = Iv(3);
    for j = 1 : len+100-1
        cx(j+1) = mod(3*cx(j)+1*cy(j)+4*cz(j),1);
        cy(j+1) = mod(8*cx(j)+3*cy(j)+11*cz(j),1);
        cz(j+1) = mod(6*cx(j)+2*cy(j)+9*cz(j),1);
    end
    ov = [cx(101:end);cy(101:end);cz(101:end)];
end