close all
clear
clc
%%
InitData

%% �õ�ƽ����3D����
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
%% ��ʾģ����ͼ�����꣬����У��
figure,
plot(M_modle(1,:),M_modle(2,:),'r.');
figure,
plot(Psrc{3}(:,1),Psrc{3}(:,2),'r.');
%% ��������������3���ռ�ƽ���ͼ����������Ӧ������󣬽�������ExPar��  
NumofBorad = size(Psrc{1},1)/54; %����ͼ�����м����궨��
InPar = {Cam88InData,Cam89InData,Cam98InData,Cam99InData};
ExPar = cell(1,4);

res = cell(size(InPar,2),NumofBorad);
%��ÿ���������ÿ���궨�壬����H��
for k = 1:size(InPar,2)
    ImageCoor = Psrc{k};
    A = InPar{k}(:,1:3);
    for i = 1:NumofBorad
        [~,npts]=size(M_modle);
        matrixone=ones(1,npts);
        M_In=[M_modle;matrixone];
        m = Psrc{k}( ((i-1)*54+1):(i*54), :)';
        m =[m;matrixone];
        H(:,:,i) = homography2d1(M_In,m)';
        
        %��֤H��׼ȷ��
%             kkk = H(:,:,i)'*M_In;
%             for asd = 1:size(kkk,2)
%                 kkk(:,asd) = kkk(:,asd)/kkk(3,asd);
%             end
%             kkk - m
        
        s=(1/norm(inv(A)*H(1,:,i)')+1/norm(inv(A)*H(2,:,i)'))/2;
        rl1=s*inv(A)*H(1,:,i)';
        rl2=s*inv(A)*H(2,:,i)';
        rl3=cross(rl1,rl2);
        RL=[rl1,rl2,rl3];
        t = s*inv(A)*H(3,:,i)';
        %%%%%%%%%%%%%%%%%%%%
        % see Appendix C "Approximating a 3*3 matrix by a Rotation Matrix", P19
        [U,S,V] = svd(RL);
        ExPar{k}(:,:,i)=[(U*V'),t;0 0 0 1];
        %%%%%%%%%%%%%%%%%%%%
        %����������Ƿ������ȷ�������飬��ԭ�����2�����أ���������ȷ��
%             xxxx = InPar{k}*ExPar{k}(:,:,i)*[M_modle;zeros(1,npts);matrixone];
%             xxxx(1,:) = xxxx(1,:)./xxxx(3,:);
%             xxxx(2,:) = xxxx(2,:)./xxxx(3,:);
%             xxxx(3,:) = xxxx(3,:)./xxxx(3,:);
%             res{k,i} = xxxx - m;
    end
end
%% �������������������88��λ�ñ任(����4Ԫ����ƽ������)
dE = cell(1,3);
dEavg = cell(1,3);
for k = 2:size(InPar,2)
    q    = zeros(1,4);
    Tavg = zeros(4,1);
    R = zeros(3,3);
    for i = 1:NumofBorad
        dE{k-1}(:,:,i) = ExPar{1,k}(:,:,1)/(ExPar{1,1}(:,:,i));
        Tavg = Tavg + dE{k-1}(:,end,i); 
        q = q + dcm2quat(dE{k-1}(1:3,1:3,i));
        R = R + dE{k-1}(1:3,1:3,i);
    end 
    Tavg = Tavg/NumofBorad;
    q = q/norm(q);
    Eavg = quat2dcm(q);
%     [U,S,V] = svd(R);
%     Eavg2 = U*[1 0 0;0 1 0;0 0 det(U)*det(V)]*V';
%     Eavg2 - Eavg
    dEavg{k-1} = [Eavg;0 0 0];
    dEavg{k-1} = [dEavg{k-1},Tavg];
end
% % ��֤dE���������ȷ
%  Cam89ExData/Cam88ExData - dEavg{1}
%  Cam98ExData/Cam88ExData - dEavg{2}
%  Cam99ExData/Cam88ExData - dEavg{3}
%% 

%%
% figure,
% plot3(Pavg(:,1),Pavg(:,2),Pavg(:,3),'r.');

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%
Pa = cell(3,1);
for i = 1:3
    Pa{i} = Pavg(((i-1)*54+1):(i*54),:);
end

P_modle = [M_modle;zeros(1,54)];
%%
% ����ƽ������������ģ�����꣬�õ�ģ����������������ϵ֮���ת����ϵ��s,R,T��
R = cell(3,1);
T = cell(3,1);
s = cell(3,1);
err = cell(3,1);

RR = cell(3,1);
Pdis = cell(3,1);

figure,
plot3(Pa{1}(:,1),Pa{1}(:,2),Pa{1}(:,3),'r.');


for i = 1:3          % ���ڱ궨�岻ͬ�����ְڷ�λ�ã��õ���������ϵ������ת�ƾ���(��������)
    [s{i}, R{i}, T{i}, err{i}] = absoluteOrientationQuaternion( Pa{i}',P_modle, 0);
    RR{i} = [R{i},T{i}./s{i};0 0 0 1];
    Pdis{i} = (s{i}*R{i}*(Pa{i}'))';
    for j = 1:54
        Pdis{i}(j,:) = Pdis{i}(j,:) + T{i}';
    end
end
%%
Rot2 = cell(3,1);
Exx   = cell(3,1);
for i = 1:3
    Rot2{i} = [R{i},T{i};0 0 0 1];   
    Exx{i} = ExPar{1}(:,:,i)*Rot2{i} ;
end

%% ��֤Exx��׼ȷ�ԣ�����׼ȷ�����ɼ��������˽ϴ�����
% 
%             xxxx = InPar{1}*Exx{1} *[ P_3d{1}';ones(1,162)];
%             xxxx(1,:) = xxxx(1,:)./xxxx(3,:);
%             xxxx(2,:) = xxxx(2,:)./xxxx(3,:);
%             xxxx(3,:) = xxxx(3,:)./xxxx(3,:);
%             zzz1 = xxxx - [Psrc{1}';ones(1,162)];           
% 
%             xxxx = InPar{1}*Exx{2} *[ P_3d{1}';ones(1,162)];
%             xxxx(1,:) = xxxx(1,:)./xxxx(3,:);
%             xxxx(2,:) = xxxx(2,:)./xxxx(3,:);
%             xxxx(3,:) = xxxx(3,:)./xxxx(3,:);
%             zzz2 = xxxx - [Psrc{1}';ones(1,162)];
%             
%             xxxx = InPar{1}*Exx{3} *[ P_3d{1}';ones(1,162)];
%             xxxx(1,:) = xxxx(1,:)./xxxx(3,:);
%             xxxx(2,:) = xxxx(2,:)./xxxx(3,:);
%             xxxx(3,:) = xxxx(3,:)./xxxx(3,:);
%             zzz3 = xxxx - [Psrc{1}';ones(1,162)];
%% ��Exx�Ľ�������ں�
Ex = P_3D2Par(Pavg,P_modle,ExPar{1});


