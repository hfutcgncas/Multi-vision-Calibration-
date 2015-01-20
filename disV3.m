close all
clear
%%
InitData

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
figure,
plot(Psrc{1}(:,1),Psrc{1}(:,2),'r.');
%end
Pavg =  P_3d{1};
for i = 2:6
    Pavg = Pavg + P_3d{i};
end
Pavg = Pavg./6;
figure,
plot3(Pavg(:,1),Pavg(:,2),Pavg(:,3),'r.');


 
% 
% figure,
% plot3(Pdis{1}(:,1),Pdis{1}(:,2),Pdis{1}(:,3),'r.');
% hold on 
% plot3(Pdis{2}(:,1),Pdis{2}(:,2),Pdis{2}(:,3),'b.');
% hold on
% plot3(Pdis{3}(:,1),Pdis{3}(:,2),Pdis{3}(:,3),'g.');
% hold on
% plot3(Pdis{4}(:,1),Pdis{4}(:,2),Pdis{4}(:,3),'k.');
% hold on
% plot3(Pdis{5}(:,1),Pdis{5}(:,2),Pdis{5}(:,3),'c.');
% hold on
% plot3(Pdis{6}(:,1),Pdis{6}(:,2),Pdis{6}(:,3),'m.');
% hold off
