function [m]=zhiliang(i,mm,MP,E)%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% A为杆截面积
%%% pp为杆密度
%%% m为全局坐标系下的一致质量阵
%%% M为局部坐标系下的一致质量阵
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      ML=mm(1,1);  %单元左侧节点的序号
      MR=mm(1,2);  %单元右侧节点的序号
      A=E(i,2);
    DX=MP(MR,1)-MP(ML,1);  %detX
    DY=MP(MR,2)-MP(ML,2);  %detY
  L=(DX^2+DY^2)^0.5;  %计算每个单元的长度
  a=atan(DY/DX);  %单元的角度（弧度制）
  pp=7800;
  M=pp*A*L/420*[140 0 0 70 0 0
                0 156 22*L 0 54 -13*L
                0 22*L 4*L^2 0 13*L -3*L^2
                70 0 0 140 0 0
                0 54 13*L 0 156 -22*L
                0 -13*L -3*L^2 0 -22*L 4*L^2];
 T=[cos(a) -sin(a) 0 0 0 0
     sin(a) cos(a) 0 0 0 0
     0 0 1 0 0 0 
     0 0 0 cos(a) -sin(a) 0
     0 0 0 sin(a) cos(a) 0
     0 0 0 0 0 1];
 m=T*M*inv(T);