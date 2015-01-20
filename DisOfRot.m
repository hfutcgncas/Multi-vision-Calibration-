function dis = DisOfRot(R1,R2)
%% 求转移矩阵的距离，采用《Metrics for 3D Rotations: Comparison and Analysis》中的 第五种范数
dis = norm(eye(3) - R1*R2','fro');

end