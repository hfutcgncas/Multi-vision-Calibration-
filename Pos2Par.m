%function ExPar = Pos2Par( P_3D,P_2D )
%用来由图像坐标与点云坐标，反解外参数
%   P_3D为空间坐标，P_2D为图像坐标
clear all
clc
InitData;

M_modle;
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

Pavg =  P_3d{1};
for i = 2:6
    Pavg = Pavg + P_3d{i};
end
Pavg = Pavg./6;
%%
Pa = cell(3,1);
for i = 1:3
    Pa{i} = Pavg(((i-1)*54+1):(i*54),:);
end

P_modle = [M_modle;zeros(1,54)];
%%
% 根据平均世界坐标与模板坐标，得到模板坐标与世界坐标系之间的转换关系（s,R,T）
R = cell(3,1);
T = cell(3,1);
s = cell(3,1);
err = cell(3,1);

RR = cell(3,1);
Pdis = cell(3,1);

figure,
plot3(Pa{1}(:,1),Pa{1}(:,2),Pa{1}(:,3),'r.');

    Rot2= cell(3,1);
for i = 1:3
    [s{i}, R{i}, T{i}, err{i}] = absoluteOrientationQuaternion( Pa{i}',P_modle, 0);
    RR{i} = [R{i},T{i}./s{i};0 0 0 1];
    Pdis{i} = (s{i}*R{i}*(Pa{i}'))';
    for j = 1:54
        Pdis{i}(j,:) = Pdis{i}(j,:) + T{i}';
    end
    
    Rot2{i} = [R{i},T{i};0 0 0 1]; 
end
%%






%end

