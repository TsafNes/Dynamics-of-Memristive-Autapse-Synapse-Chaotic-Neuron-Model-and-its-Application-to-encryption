function [SB] = Sbox(Iv)
    format long
    N = 40; S_init = [];
    ov = GCM(100,Iv);
    Iv = ov'; yes = 1; k1 = 1;
    while(yes)
        ov = GCM(1,Iv);
        Iv = ov';
        xx = sum(Iv);
        ele = mod(floor(xx*10^(14)),256);   
        t1 = ismember(S_init,ele(1));
        t1 = sum(t1);         
        if(t1 == 0)                
            S_init(k1) = ele;                
            k1 = k1+1;
        end
        if(length(S_init) == 256)
            yes = 0;
        end
    end
    nl1 = NL(S_init); du1 = DP(S_init);
    fit1 = nl1+256-du1;
    c1 = 34; c2 = c1;
    for k = 1:1:N
        ov = GCM(1,Iv);
        Iv = ov'; x = Iv(1); y = Iv(2); z = Iv(3);
        c1 = mod(c1+floor(x*10^14),256)+1;
        c2 = mod(c2+floor((y+z)*10^14),256);
        c3 = bitxor(S_init(c1),c2);
        [~,b] = ismember(S_init,c3);
        c4 = find(b);
        S = S_init;
        val = S(c4); S(c4) = S(c1); S(c1) = val;
        nl2 = NL(S); du2 = DP(S); fit2 = nl2+256-du2;
        if(fit2 >= fit1)
            S_init = S;
            fit1 = fit2;
        end
    end
    for i = 1:256
        tmp = dec2bin(S(i),8);
        num = 1;
        for j = 7:-1:0
        	s_t(8*i-j) = str2num(tmp(num));
            num = num+1;
        end
    end
    SB = reshape(s_t,32,64);
    SB(SB == 0) = -1;
end

