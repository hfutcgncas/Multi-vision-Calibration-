close all
clear
clc
%%
InitData
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

disP_3d(M,Psrc)

%%
disp('--------Cam88 ---------------');
[Par1 ,dis1] = Dis_Par_P3d(Cam88InData,Cam88ExData,Psrc{1},Pavg);
Par1 - Cam88ExData(1:3,:)
dis1
disp('--------------------------------');
%
disp('--------Cam89 ---------------');
[Par2 ,dis2] = Dis_Par_P3d(Cam89InData,Cam89ExData,Psrc{2},Pavg);
Par2 - Cam89ExData(1:3,:)
dis2
disp('--------------------------------');
%
disp('--------Cam98 ---------------');
[Par3 ,dis3] = Dis_Par_P3d(Cam98InData,Cam98ExData,Psrc{3},Pavg);
Par3 - Cam98ExData(1:3,:)
dis3
disp('--------------------------------');
%
disp('--------Cam99 ---------------');
[Par4 ,dis4] = Dis_Par_P3d(Cam99InData,Cam99ExData,Psrc{4},Pavg);
Par4 - Cam99ExData(1:3,:)
dis4

%%
M{1} = Cam88InData*[Par1;0 0 0 1];
M{2} = Cam89InData*[Par2;0 0 0 1];
M{3} = Cam98InData*[Par3;0 0 0 1];
M{4} = Cam99InData*[Par4;0 0 0 1];

disP_3d(M,Psrc)