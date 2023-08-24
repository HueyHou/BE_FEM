function[k]=fehes(Ee,mm,MP,i)
k=zeros(6,6);
      ML=mm(1,1);  %单元左侧节点的序号
      MR=mm(1,2);  %单元右侧节点的序号
    DX=MP(MR,1)-MP(ML,1);  %detX
    DY=MP(MR,2)-MP(ML,2);  %detY
  L=(DX^2+DY^2)^0.5;  %计算每个单元的长度
  a=atan(DY/DX);  %单元的角度（弧度制）
  E=Ee(i,1);
  A=Ee(i,2);
  I=Ee(i,3);%材料常数
  

k=E/L*[A*cos(a)*cos(a)+12*I/(L^2)*sin(a)*sin(a) (A-12*I/(L^2))*cos(a)*sin(a) -6*I*sin(a)/L -(A*cos(a)*cos(a)+12*I*sin(a)*sin(a)/(L^2)) -(A-12*I/(L^2))*cos(a)*sin(a) -6*I*sin(a)/L                 
        (A-12*I/(L^2))*cos(a)*sin(a) A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2) 6*I*cos(a)/L -(A-12*I/(L^2))*cos(a)*sin(a) -(A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2)) 6*I*cos(a)/L                                        
        -6*I*sin(a)/L 6*I*cos(a)/L 4*I 6*I*sin(a)/L -6*I*cos(a)/L 2*I
        -(A*cos(a)*cos(a)+12*I*sin(a)*sin(a)/(L^2)) -(A-12*I/(L^2))*cos(a)*sin(a) 6*I*sin(a)/L A*cos(a)*cos(a)+12*I*sin(a)*sin(a)/(L^2) (A-12*I/(L^2))*cos(a)*sin(a) 6*I*sin(a)/L 
        -(A-12*I/(L^2))*cos(a)*sin(a) -(A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2)) -6*I*cos(a)/L (A-12*I/(L^2))*cos(a)*sin(a) A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2) -6*I*cos(a)/L 
        -6*I*sin(a)/L 6*I*cos(a)/L 2*I 6*I*sin(a)/L -6*I*cos(a)/L 4*I];
end