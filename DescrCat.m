function de_scr = DescrCat(C,x)
% inverse 2-D Cat permutation，C：image to be processed，x：index sequence
    [m,n] = size(C);
    d = m*n;
    C = double(C);
    a = reshape(x(1:d),m,n);
    b=reshape(x(d+1:2*d),m,n);
    B = C;
    for i = m:-1:1
        for j = n:-1:1
            k = mod([1,a(i,j);b(i,j),a(i,j)*b(i,j)+1]*[i;j],[m;n])+[1;1];
            t = B(i,j);
            B(i,j) = B(k(1),k(2));
            B(k(1),k(2)) = t;
        end
    end
    de_scr = B;
end