function ED = Idiff(X,s1,s2)
% Inverse diffusion algorithm
    C = double(X);
    [m,n] = size(X);
    d = m*n; D0 = 0;
    D(d) = mod(256*2+C(d)-D0-s2(d),256);
    for i = d-1:-1:1
        D(i) = mod(256*2+C(i)-C(i+1)-s2(i),256);
    end
    E0 = 0;
    E(1) = mod(256*2+D(1)-E0-s1(1),256);
    for i = 2:d
        E(i) = mod(256*2+D(i)-D(i-1)-s1(i),256);
    end
    ED = reshape(E,m,n);
end


