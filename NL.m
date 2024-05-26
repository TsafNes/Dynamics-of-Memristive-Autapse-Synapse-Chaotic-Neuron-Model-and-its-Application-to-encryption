function [avg,nn] = NL(box)
    size3 = 8;
    size1 = 256;
    bool = zeros(256,8);
    for hh = 1:1:size1
        for jj = 1:1:size3
            bool(hh,size3+1-jj) = power(-1,bitget(box(hh),jj));
        end
    end
    H = hadamard(size1);
    asum = 0;
    nn = zeros(1,8);
    count12 = 0;
    for hh = 1:1:size3
        max = 0;
        for kk = 1:1:size1
            temp = 0;
            for jj = 1:1:size1
                if bool(jj,hh) == H(kk,jj)
                    temp = temp+1;
                else
                    temp = temp-1;
                end
            end
            temp = abs(temp);
            count12 = count12+1;
            if temp > max
                max = temp;
            end
        end
        nn(size3+1-hh) = 128-max/2;
        asum = asum+nn(size3+1-hh);
    end
    avg = asum/size3;
end