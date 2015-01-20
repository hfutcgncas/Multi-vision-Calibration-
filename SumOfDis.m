function res = SumOfDis(r)

    global Pavg;
    global Cam88ExData;
    global Cam88InData;

    global Cam89ExData;
    global Cam89InData;

    global Cam98ExData;
    global Cam98InData;

    global Cam99ExData;
    global Cam99InData;

    global Psrc;

    R = reshape(r,3,3);
    P = Pavg*R';
    
   %%
   [Par1 ,dis1] = Dis_Par_P3d(Cam88InData,Cam88ExData,Psrc{1},P);
   [Par2 ,dis2] = Dis_Par_P3d(Cam89InData,Cam89ExData,Psrc{2},P);
   [Par3 ,dis3] = Dis_Par_P3d(Cam98InData,Cam98ExData,Psrc{3},P);
   [Par4 ,dis4] = Dis_Par_P3d(Cam99InData,Cam99ExData,Psrc{4},P);
   %%
   res = dis1^2 + dis2^2 + dis3^2 + dis4^2;

end