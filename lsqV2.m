close all
clear
clc
%%
InitData

%% �õ�ƽ����3D����
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
    % �������������ڶ���ռ�ƽ���ͼ����������Ӧ������󣬽�������ExPar��
    InPar = {Cam88InData,Cam89InData,Cam98InData,Cam99InData};
    ExPar = Cal_ZhangZY(Psrc,InPar,M_modle);
    %%
    % ����Pavg�����ӳ��Ĳ���
    P_modle = [M_modle;zeros(1,54)];
    
    Ex = cell(4,1);
    M1 = cell(4,1);
    for i = 1 : 4
        Ex{i} = P_3D2Par(Pavg,P_modle,ExPar{i});
      %  M{i} = InPar{i}*Ex{i};
        M1{i} = InPar{i}*Ex{i};
    end
    %%
    % ���㵱ǰ������ʼ���֮��ľ��롣
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