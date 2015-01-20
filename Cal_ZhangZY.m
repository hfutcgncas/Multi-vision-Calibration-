function ExPar = Cal_ZhangZY(Psrc,InPar,M_modle)

%% �������������ڶ���ռ�ƽ���ͼ����������Ӧ������󣬽�������ExPar��  
NumofBorad = size(Psrc{1},1)/54; %����ͼ�����м����궨��
ExPar = cell(1,size(InPar,2));

%��ÿ���������ÿ���궨�壬����H��
for k = 1:size(InPar,2)
    A = InPar{k}(:,1:3);
    for i = 1:NumofBorad
        [~,npts]=size(M_modle);
        matrixone=ones(1,npts);
        M_In=[M_modle;matrixone];
        m = Psrc{k}( ((i-1)*54+1):(i*54), :)';
        m =[m;matrixone];
        H(:,:,i) = homography2d1(M_In,m)';
               
        s=(1/norm(inv(A)*H(1,:,i)')+1/norm(inv(A)*H(2,:,i)'))/2;
        rl1=s*inv(A)*H(1,:,i)';
        rl2=s*inv(A)*H(2,:,i)';
        rl3=cross(rl1,rl2);
        RL=[rl1,rl2,rl3];
        t = s*inv(A)*H(3,:,i)';
        %%%%%%%%%%%%%%%%%%%%
        % see Appendix C "Approximating a 3*3 matrix by a Rotation Matrix", P19
        [U,~,V] = svd(RL);
        ExPar{k}(:,:,i)=[(U*V'),t;0 0 0 1];
        %%%%%%%%%%%%%%%%%%%%
    end
end

end