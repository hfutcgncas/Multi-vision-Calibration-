function out = Euler2Rot(Euler)
% 
%   alpha = Euler(1);
%   beta  = Euler(2);
%   gamma = Euler(3);
%   out = [ cos(alpha)*cos(gamma)-cos(beta)*sin(alpha)*sin(gamma)  -cos(beta)*cos(gamma)*sin(alpha)-cos(alpha)*sin(gamma)  sin(alpha)*sin(beta);
%                       cos(gamma)*sin(alpha)+cos(alpha)*cos(beta)*sin(gamma)   cos(alpha)*cos(beta)*cos(gamma)-sin(alpha)*sin(gamma) -cos(alpha)*sin(beta);
%                       sin(beta)*sin(gamma)                        cos(gamma)*sin(beta)                       cos(beta)      ];     
out  = angle2dcm( Euler(1),Euler(2),Euler(3) );
end