function en_scr = EnscrCat(P,x)
% 2-D Cat permutation，P：image to be processed，x：index sequence
    [m,n] = size(P);
    d = m*n;
    P = double(P);
    a = reshape(x(1:d),m,n);
    b = reshape(x(d+1:2*d),m,n);
    A = P;
    for i = 1:m
        for j = 1:n
            k = mod([1,a(i,j);b(i,j),a(i,j)*b(i,j)+1]*[i;j],[m;n])+[1;1];
            t = A(i,j);
            A(i,j) = A(k(1),k(2));
            A(k(1),k(2)) = t;
        end
    end
    en_scr = A;
end
