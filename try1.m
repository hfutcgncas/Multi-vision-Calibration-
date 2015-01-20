close all
clear
clc
%%
InitData
global Pavg;
global In;
global Ex;
global P_2d;

In = Cam89InData(:,1:3);
Ex = Cam89ExData;
P_2d = Psrc{2};
In1 = Cam89InData;

%% 得到平均的3D坐标
P_3d = cell(6,1);
cnt = size(Psrc{1},1);
for i=1:cnt
    pn = Im2D23D(Psrc{1}(i,:),M{1},Psrc{2}(i,:),M{2});
    P_3d{1} = [P_3d{1};pn];
    pn = Im2D23D(Psrc{1}(i,:),M{1},Psrc{3}(i,:),M{3});
    P_3d{2} = [P_3d{2};pn];
    pn = Im2D23D(Psrc{1}(i,:),M{1},Psrc{4}(i,:),M{4});
    P_3d{3} = [P_3d{3};pn];
    pn = Im2D23D(Psrc{2}(i,:),M{2},Psrc{3}(i,:),M{3});
    P_3d{4} = [P_3d{4};pn];
    pn = Im2D23D(Psrc{2}(i,:),M{2},Psrc{4}(i,:),M{4});
    P_3d{5} = [P_3d{5};pn];
    pn = Im2D23D(Psrc{3}(i,:),M{3},Psrc{4}(i,:),M{4});
    P_3d{6} = [P_3d{6};pn];
end

Pavg =  zeros(162,3);
for i = 1:6
    Pavg = Pavg + P_3d{i};
end
Pavg = Pavg/6;

%Pavg = P_3d{1};

%%
% P_cam 是摄像机坐标系下的3D位置
P_cam = Ex*[Pavg';ones(1,162)];

P_scr = In1*P_cam;
out1 = P_scr;
for i = 1:162
    out1(1,i) = P_scr(1,i)/P_scr(3,i);
    out1(2,i) = P_scr(2,i)/P_scr(3,i);
    out1(3,i) = P_scr(3,i)/P_scr(3,i);
end

out1(1:2,:) - Psrc{2}'
% 
% % % out2 是由图像坐标反解得到的摄像机坐标系下的3D位置
% out2 = (In)\[P_2d';ones(1,162)];
% s2 = zeros(162,1);
% s1 = P_cam(1:3,:)./out2;
% for i = 1:162
%     s2(i) = sum(s1(:,i))/3;
% end
% s3 = diag(s2);
% S = s3;
% %%
% % 由3D坐标与图像坐标反解Ex的过程。  其中S是自由变量，为对角阵。
% A1 = (In\[Psrc{2}';ones(1,162)]);
% A2 = [Pavg';ones(1,162)]'/([Pavg';ones(1,162)]*[Pavg';ones(1,162)]');
% da = Ex(1:3,:) - A1*S*A2;
% 
% KK = A1*S*A2;
% MM =  In1*[KK;0 0 0 1]*[Pavg';ones(1,162)];
% 
% for i = 1:162
%     MM(1,i) = MM(1,i)/MM(3,i);
%     MM(2,i) = MM(2,i)/MM(3,i);
%     MM(3,i) = MM(3,i)/MM(3,i);
% end
% 
% MM(1:2,:) - Psrc{2}'
% 
% out = minD(s2)
% 
% 
% %%
% %最优化问题
% [x,fval,exitflag,output,lambda,grad,hessian] = Opt(s2);
% 
% out = minD(x)

