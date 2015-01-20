function [c,ceq] = OptimizationConstraints(s)


global Pavg;
global In;
%global Ex;
global P_2d;

S = diag(s);

A1 = (In\[P_2d';ones(1,size(P_2d,1))]);
A2 = [Pavg';ones(1,size(Pavg,1))]'/([Pavg';ones(1,size(Pavg,1))]*[Pavg';ones(1,size(Pavg,1))]');
A3 = (A1*S*A2)';

c = [];
eq = eye(3) - A3(1:3,1:3)*A3(1:3,1:3)';
ceq = eq(:);

end