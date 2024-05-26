function [maxdp,dpm] = DP(box)
    maxdp = 0;
    % CALCULATING DIFFERENTIAL PROBABILITY %
    clear xor1 xor2 xor3
    for ii = 1:1:255
        xor3 = [];
        xor1 = [];
        xor2 = [];
        for hh = 1:1:256
            xor3(hh) = bitxor(hh-1,ii);
            xor1(hh) = box(xor3(hh)+1);
        end
        for hh = 1:1:256
            xor2(hh) = bitxor(box(hh),xor1(hh));
        end
        counterdp = [];
        for hh = 1:1:256
            counterdp(hh) = 0;
        end
        for hh = 1:1:256
           counterdp(xor2(hh)+1) = counterdp(xor2(hh)+1)+1;
        end
        for hhh = 1:1:256
           for jjj = 1:1:256-hhh
               if counterdp(jjj) > counterdp(jjj+1)
                   tempdp = counterdp(jjj);
                   counterdp(jjj) = counterdp(jjj+1);
                   counterdp(jjj+1) = tempdp;
               end
           end
        end
        dp(ii) = counterdp(256); 
        if(dp(ii) > maxdp)
        	maxdp = dp(ii);
        end
    end
    dp(256) = 0;
    temp = 1;
    dpm = zeros(16,16);
    for hh = 1:1:16
        for jj = 1:1:16
            dpm(hh,jj) = dp(temp);
            temp = temp+1;
        end
    end
end

