function dis = DisOfRot(R1,R2)
%% ��ת�ƾ���ľ��룬���á�Metrics for 3D Rotations: Comparison and Analysis���е� �����ַ���
dis = norm(eye(3) - R1*R2','fro');

end