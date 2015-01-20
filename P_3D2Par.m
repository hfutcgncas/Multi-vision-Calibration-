function Par = P_3D2Par(P_3D,P_modle,modleRot)
model_point = 54;
model_count = size(P_3D,1)/model_point;
%% ��P_3D����ģ�����
P = cell(model_count,1);
for i = 1:model_count
    P{i} = P_3D(((i-1)*model_point+1):(i*model_point),:);
end
%%
% ����ƽ������������ģ�����꣬�õ�ģ����������������ϵ֮���ת����ϵ��s,R,T��
R = cell(model_count,1);
T = cell(model_count,1);
s = cell(model_count,1);
err = cell(model_count,1);

for i = 1:model_count          % ���ڱ궨�岻ͬ�Ķ��ְڷ�λ�ã��õ���������ϵ�Ķ���ת�ƾ���(��������)
    [s{i}, R{i}, T{i}, err{i}] = absoluteOrientationQuaternion( P{i}',P_modle, 1);
end
%%
% �õ��������Exx
Rot2 = cell(model_count,1);
Exx   = cell(model_count,1);
for i = 1:model_count
    Rot2{i} = [R{i},T{i};0 0 0 1];   
    Exx{i} = modleRot(:,:,i)*Rot2{i} ;
end
%%
% �ں�Exx
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