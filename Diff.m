function C = Diff(P,s1,s2)
% Diffusion algorithm
    [m,n] = size(P); B = zeros(m,n); C = zeros(m,n);
    d = m*n; P = double(P); A = P(:); 
    B0 = 0; 
    B(1) = mod(B0+s1(1)+A(1),256);
    for i = 2:d
        B(i) = mod(B(i-1)+s1(i)+A(i),256);
    end
    C0 = 0; 
    C(m*n) = mod(C0+s2(m*n)+B(m*n),256);
    for i = d-1:-1:1
        C(i) = mod(C(i+1)+s2(i)+B(i),256);
    end
    C = reshape(C,m,n);
end