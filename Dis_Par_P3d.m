function [Par1 ,dis] = Dis_Par_P3d(In_Par,Ex_Par,Psrc,P_3d)
%%
global Pavg;
global In;
global Ex;
global P_2d;

In = In_Par(:,1:3);
Ex = Ex_Par;
P_2d = Psrc;
Pavg = P_3d;

deleteList = [];
%%
% 计算参数的初值

% P_cam 是摄像机坐标系下的3D位置（带景深）
P_cam = Ex*[Pavg';ones(1,162)];
% out2 是由图像坐标反解得到的摄像机坐标系下的3D位置
out2 = In\[P_2d';ones(1,162)];
s2 = zeros(162,1);
s1 = P_cam(1:3,:)./out2;
for i = 1:162
    s2(i) = sum(s1(:,i))/3;
    if sum(abs(s1(:,i)-s2(i))) < 0.5*s2(i)
        continue;
    else
        deleteList = [deleteList;i];
    end
end

Pavg(deleteList,:) = [];
P_2d(deleteList,:) = [];
s2(deleteList,:) = [];

disp('delete points:')
disp(size(deleteList,1))


out = minD(s2);


%%
%最优化问题
[x,fval,exitflag,output,lambda,grad,hessian] = Opt(s2);

dis = minD(x);

S = diag(x);
A1 = (In\[P_2d';ones(1,size(P_2d,1))]);
A2 = [Pavg';ones(1,size(Pavg,1))]'/([Pavg';ones(1,size(Pavg,1))]*[Pavg';ones(1,size(Pavg,1))]');
A3 = A1*S*A2;
Par1 = A3;

end