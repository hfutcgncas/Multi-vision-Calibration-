function [c,ceq] = OC2(r)

R = reshape(r,3,3);

c = [];
eq = eye(3) - R*R';
ceq = eq(:);


end