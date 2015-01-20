function Par = P_3D2Par(P_3D,P_modle,modleRot)
model_point = 54;
model_count = size(P_3D,1)/model_point;
%% 将P_3D按照模板分组
P = cell(model_count,1);
for i = 1:model_count
    P{i} = P_3D(((i-1)*model_point+1):(i*model_point),:);
end
%%
% 根据平均世界坐标与模板坐标，得到模板坐标与世界坐标系之间的转换关系（s,R,T）
R = cell(model_count,1);
T = cell(model_count,1);
s = cell(model_count,1);
err = cell(model_count,1);

for i = 1:model_count          % 对于标定板不同的多种摆放位置，得到世界坐标系的多种转移矩阵(经过检验)
    [s{i}, R{i}, T{i}, err{i}] = absoluteOrientationQuaternion( P{i}',P_modle, 1);
end
%%
% 得到矫正后的Exx
Rot2 = cell(model_count,1);
Exx   = cell(model_count,1);
for i = 1:model_count
    Rot2{i} = [R{i},T{i};0 0 0 1];   
    Exx{i} = modleRot(:,:,i)*Rot2{i} ;
end
%%
% 融合Exx
T_Par = [0 ;0 ;0 ;0];
q = [0 0 0 0];
for i = 1:model_count
    T_Par = T_Par + Exx{i}(:,4);
    q = q + dcm2quat(Exx{i}(1:3,1:3));
end
T_Par = T_Par./model_count;
q = q./norm(q);

Par = [quat2dcm(q);0,0,0];
Par = [Par,T_Par];

end