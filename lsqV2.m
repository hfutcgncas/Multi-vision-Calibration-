close all
clear
clc
%%
InitData

%% 得到平均的3D坐标
P_3d = disP_3d(M,Psrc);

fac = [1 1 1 1 1 1];
fac = fac/sum(fac);

facHis = [];
disHis = [];
for k = 1:30
    Pavg =  zeros(162,3);
    for i = 1:6
        Pavg = Pavg + fac(i)*P_3d{i};
    end
    
    %%
    % 计算各个摄像机在多个空间平面的图像坐标所对应的外矩阵，结果存放在ExPar中
    InPar = {Cam88InData,Cam89InData,Cam98InData,Cam99InData};
    ExPar = Cal_ZhangZY(Psrc,InPar,M_modle);
    %%
    % 根据Pavg，求得映射的参数
    P_modle = [M_modle;zeros(1,54)];
    
    Ex = cell(4,1);
    M1 = cell(4,1);
    for i = 1 : 4
        Ex{i} = P_3D2Par(Pavg,P_modle,ExPar{i});
      %  M{i} = InPar{i}*Ex{i};
        M1{i} = InPar{i}*Ex{i};
    end
    %%
    % 计算当前外参与初始外参之间的距离。
    R1 = Ex{1}(1:3,1:3);
    R2 = Cam88ExData(1:3,1:3);
    dis1 = DisOfRot(R1,R2);
    
    R1 = Ex{2}(1:3,1:3);
    R2 = Cam89ExData(1:3,1:3);
    dis2 = DisOfRot(R1,R2);
    
    R1 = Ex{3}(1:3,1:3);
    R2 = Cam98ExData(1:3,1:3);
    dis3 = DisOfRot(R1,R2);
    
    R1 = Ex{4}(1:3,1:3);
    R2 = Cam99ExData(1:3,1:3);
    dis4 = DisOfRot(R1,R2);
    %%      
    fac = fac +      100* [     dis1*dis2...
                                , dis1*dis3...
                                , dis1*dis4...
                                , dis2*dis3...
                                , dis2*dis4...
                                , dis3*dis4];
     fac = fac/sum(fac);
     
     facHis = [facHis;fac];
     disHis = [disHis;dis1,dis2,dis3,dis4];

    
end

disP_3d(M1,Psrc);