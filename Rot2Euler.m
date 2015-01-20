function outEuller = Rot2Euler(Rot)
%     if( Rot(3,1) ~= 1 && Rot(3,1) ~= -1)
%         alpha = -asin(Rot(3,1));
%         beta  = atan2(Rot(3,2)/cos(alpha),Rot(3,3)/cos(alpha));
%         gamma = atan2(Rot(2,1)/cos(alpha),Rot(1,1)/cos(alpha));
%     else
%         gamma = 0;
%         if Rot(3,1) == -1
%             alpha = pi/2;
%             beta  = gamma + atan2(R(1,2),R(1,3));
%         else
%             alpha = -pi/2;
%             beta  = -gamma + atan2(-R(1,2),-R(1,3));
%         end
%     end
%     outEuller = [alpha,beta,gamma];
    outEuller = [0 0 0];
    [outEuller(1),outEuller(2),outEuller(3)] = dcm2angle( Rot );
end