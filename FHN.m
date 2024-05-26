function [f] = FHN(t,y)
% 新忆阻神经网络模型的定义
    f = zeros(6,1);
    alpha = 0.1; beta = 1; gamma = 0.2;
    a1 = 1; b1 = 3; c1 = 1; d1 = 5; I1 = 0.1;
    a2 = 1; b2 = 0.1; c2 = 0.1; d2 = 1/3; I2 = 2.5;
    f(1) = y(2)-a1*y(1)^3+b1*y(1)^2+I1-alpha*y(6)*(y(1)-y(4))-alpha*y(1)*y(3);
    f(2) = c1-d1*y(1)^2-y(2);
    f(3) = gamma*y(1)+beta*cos(y(3));
    f(4) = y(4)-d2*y(4)^3-y(5)+I2;
    f(5) = c2*(a2+y(4)-b2*y(5));
    f(6) = gamma*(y(1)-y(4))+beta*cos(y(6));
end

