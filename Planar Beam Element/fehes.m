function[k]=fehes(Ee,mm,MP,i)
k=zeros(6,6);
      ML=mm(1,1);  %��Ԫ���ڵ�����
      MR=mm(1,2);  %��Ԫ�Ҳ�ڵ�����
    DX=MP(MR,1)-MP(ML,1);  %detX
    DY=MP(MR,2)-MP(ML,2);  %detY
  L=(DX^2+DY^2)^0.5;  %����ÿ����Ԫ�ĳ���
  a=atan(DY/DX);  %��Ԫ�ĽǶȣ������ƣ�
  E=Ee(i,1);
  A=Ee(i,2);
  I=Ee(i,3);%���ϳ���
  

k=E/L*[A*cos(a)*cos(a)+12*I/(L^2)*sin(a)*sin(a) (A-12*I/(L^2))*cos(a)*sin(a) -6*I*sin(a)/L -(A*cos(a)*cos(a)+12*I*sin(a)*sin(a)/(L^2)) -(A-12*I/(L^2))*cos(a)*sin(a) -6*I*sin(a)/L                 
        (A-12*I/(L^2))*cos(a)*sin(a) A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2) 6*I*cos(a)/L -(A-12*I/(L^2))*cos(a)*sin(a) -(A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2)) 6*I*cos(a)/L                                        
        -6*I*sin(a)/L 6*I*cos(a)/L 4*I 6*I*sin(a)/L -6*I*cos(a)/L 2*I
        -(A*cos(a)*cos(a)+12*I*sin(a)*sin(a)/(L^2)) -(A-12*I/(L^2))*cos(a)*sin(a) 6*I*sin(a)/L A*cos(a)*cos(a)+12*I*sin(a)*sin(a)/(L^2) (A-12*I/(L^2))*cos(a)*sin(a) 6*I*sin(a)/L 
        -(A-12*I/(L^2))*cos(a)*sin(a) -(A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2)) -6*I*cos(a)/L (A-12*I/(L^2))*cos(a)*sin(a) A*sin(a)*sin(a)+12*I*cos(a)*cos(a)/(L^2) -6*I*cos(a)/L 
        -6*I*sin(a)/L 6*I*cos(a)/L 2*I 6*I*sin(a)/L -6*I*cos(a)/L 4*I];
end