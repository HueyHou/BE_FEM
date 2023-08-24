clear all
clc
syms v  f E A L 
%v是位移列向量
%K是总的刚度矩阵
%f是位移列向量
p=fopen('textofbeans.txt','r');%写入有信息的文件
q=fopen('EAL.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q);
%输出节点个数，节点坐标，单元个数，单元节点编号，位移约束数量及位移约束向量，载荷数量及载荷向量，材料的E，A，L
NDF=NF*NP;%维度
K=zeros(NDF,NDF);%总刚度矩阵的开始，零矩阵
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%生成单位刚度矩阵%名字后面再改%给该单元的节点编号和所有节点坐标
    K=jiahe(K,k,ME(i,:),NF*2);%加到总刚度阵里%名字后面再改
end
P=zeros(3*NP,1);%力向量

for i=1:NL
    P(LL(i,1))=LL(i,2);
end%写入载荷
q=0;
for i=1:NDF
    for j=1:NDF
        o=abs(K(i,j));
        if q<=o;
            q=o;
        end
    end
end%找最大的一个数
aa=q*10^4;%对角大数的大数
Z=K;%备份总体刚度阵
for i=1:NR
    f=NRR(i,1);
%     K(f,f)=aa*K(f,f);
    K(f,f)=10^13;
end%对角大数法
for i=1:NR
    f=NRR(i,1);
%     P(f)=K(f,f)*NRR(i,2)
   P(f)=10^13*NRR(i,2)
end%对角大数的力处理
% u=K^(-1)*P;
u=inv(K)*P;
fprintf('位移向量\n');
fprintf('%1.9f\n',u);%保留4位小数
Z;
F=Z*u;
fprintf('力向量：\n');
fprintf('%1.9f\n',F);%保留4位小数

filename = 'OUTCOME.xlsx';
xlswrite(filename,u)  

% f=0;
% for i=1:4
%     t=3*i-1;
%     F(t)
%     f=f+F(t);
% end
% f

MN=yingli(NE,ME,NP,MP,F)
% 
%  MP=[0,0;0,3;0,6;0,9;9,0;9,3;9,6;9,9;18,0;18,3;18,6;18,9];
%  Ax=[MP(1,1) MP(2,1) MP(3,1) MP(2,1) MP(3,1) MP(4,1) MP(5,1) MP(6,1)...
%      MP(7,1) MP(6,1) MP(7,1) MP(8,1) MP(9,1) MP(10,1) MP(11,1)];
%  Ay=[MP(1,2) MP(2,2) MP(3,2) MP(2,2) MP(3,2) MP(4,2) MP(5,2) MP(6,2)...
%      MP(7,2) MP(6,2) MP(7,2) MP(8,2) MP(9,2) MP(10,2) MP(11,2)];
%  Bx=[MP(2,1) MP(3,1) MP(4,1) MP(6,1) MP(7,1) MP(8,1) MP(6,1) MP(7,1)...
%      MP(8,1) MP(10,1) MP(11,1) MP(12,1) MP(10,1) MP(11,1) MP(12,1)];
%  By=[MP(2,2) MP(3,2) MP(4,2) MP(6,2) MP(7,2) MP(8,2) MP(6,2) MP(7,2)...
%      MP(8,2) MP(10,2) MP(11,2) MP(12,2) MP(10,2) MP(11,2) MP(12,2)];
%  X=[Ax;Bx];
%  Y=[Ay;By];
%  
%  plot(X,Y,'k')
% 
% Ux=u(1:3:end,:);
%  Uy=u(2:3:end,:);
%  U=[Ux Uy];
%  Ax=[U(1,1) U(2,1) U(3,1) U(2,1) U(3,1) U(4,1) U(5,1) U(6,1)...
%      U(7,1) U(6,1) U(7,1) U(8,1) U(9,1) U(10,1) U(11,1)];
%  Ay=[U(1,2) U(2,2) U(3,2) U(2,2) U(3,2) U(4,2) U(5,2) U(6,2)...
%      U(7,2) U(6,2) U(7,2) U(8,2) U(9,2) U(10,2) U(11,2)];
%  Bx=[U(2,1) U(3,1) U(4,1) U(6,1) U(7,1) U(8,1) U(6,1) U(7,1)...
%      U(8,1) U(10,1) U(11,1) U(12,1) U(10,1) U(11,1) U(12,1)];
%  By=[U(2,2) U(3,2) U(4,2) U(6,2) U(7,2) U(8,2) U(6,2) U(7,2)...
%      U(8,2) U(10,2) U(11,2) U(12,2) U(10,2) U(11,2) U(12,2)];
%  X=[Ax;Bx];
%  Y=[Ay;By];
%  
%  plot(X,Y,'b')
%  
 

% Cx=[MP(1,1) MP(2,1) MP(3,1) MP(2,1) MP(3,1) MP(4,1) MP(5,1) MP(6,1)...
%      MP(7,1) MP(6,1) MP(7,1) MP(8,1) MP(9,1) MP(10,1) MP(11,1)];
%  Cy=[MP(1,2) MP(2,2) MP(3,2) MP(2,2) MP(3,2) MP(4,2) MP(5,2) MP(6,2)...
%      MP(7,2) MP(6,2) MP(7,2) MP(8,2) MP(9,2) MP(10,2) MP(11,2)];
%  Dx=[MP(2,1) MP(3,1) MP(4,1) MP(6,1) MP(7,1) MP(8,1) MP(6,1) MP(7,1)...
%      MP(8,1) MP(10,1) MP(11,1) MP(12,1) MP(10,1) MP(11,1) MP(12,1)];
%  Dy=[MP(2,2) MP(3,2) MP(4,2) MP(6,2) MP(7,2) MP(8,2) MP(6,2) MP(7,2)...
%      MP(8,2) MP(10,2) MP(11,2) MP(12,2) MP(10,2) MP(11,2) MP(12,2)];
%  X1=[Cx;Dx];
%  Y1=[Cy;Dy];
% 
% u=1000*u;
%  Ux=u(1:3:end,:);
%  Uy=u(2:3:end,:);
%  U=[Ux Uy];
%  X=U+MP;
%  Ax=[X(1,1) X(2,1) X(3,1) X(2,1) X(3,1) X(4,1) X(5,1) X(6,1)...
%      X(7,1) X(6,1) X(7,1) X(8,1) X(9,1) X(10,1) X(11,1)];
%  Ay=[X(1,2) X(2,2) X(3,2) X(2,2) X(3,2) X(4,2) X(5,2) X(6,2)...
%      X(7,2) X(6,2) X(7,2) X(8,2) X(9,2) X(10,2) X(11,2)];
%  Bx=[X(2,1) X(3,1) X(4,1) X(6,1) X(7,1) X(8,1) X(6,1) X(7,1)...
%      X(8,1) X(10,1) X(11,1) X(12,1) X(10,1) X(11,1) X(12,1)];
%  By=[X(2,2) X(3,2) X(4,2) X(6,2) X(7,2) X(8,2) X(6,2) X(7,2)...
%      X(8,2) X(10,2) X(11,2) X(12,2) X(10,2) X(11,2) X(12,2)];
%  X=[Ax;Bx];
%  Y=[Ay;By];
% 
%  plot(X1,Y1,'k')
%   hold on
%   plot(X,Y,'b')
% 
% 
% 
% 
% 
% 
% %   for i=1:11
% %     while (2<=i)&&(i<=4)
% %         plot([MP(i,1),MP(i+4,1)],[MP(i,2),MP(i+2,2)],'k');
% %         hold on
% %     end
% %     while (6<=i)&&(i<=8)
% %         plot([MP(i,1),MP(i+4,1)],[MP(i,2),MP(i+2,2)],'k');
% %         hold on
% %     end
% %     while (1<=i)&&(i<=3)
% %         plot([MP(i,1),MP(i+1,1)],[MP(i,2),MP(i+1,2)],'k');
% %         hold on
% %     end
% %     while (5<=i)&&(i<=7)
% %         plot([MP(i,1),MP(i+1,1)],[MP(i,2),MP(i+1,2)],'k');
% %         hold on
% %     end
% %     while  (9<=i)&&(i<=11)
% %         plot([MP(i,1),MP(i+1,1)],[MP(i,2),MP(i+1,2)],'k');
% %         hold on
% %     end
% %  end
% 
% 
% % set(0,'defaultfigurecolor','w')%设置背景色为白色
% % x1=MP(:,1)
% % X2=MP(:,2);
% % figure(1)
% % plot(x1,X2,'o','LineWidth',15)
% % nodex = [0, 0.2, 0.4, 0.6, 0.8, 1.0,...
% %          0, 0.2, 0.4, 0.6, 0.8, 1.0,...
% %          0, 0.2, 0.4, 0.6, 0.8, 1.0];  %节点X坐标
% % nodey = [0,   0,   0,   0,   0,   0,...
% %          0.2, 0.2, 0.2, 0.2, 0.2, 0.2,...
% %          0.4, 0.4, 0.4, 0.4, 0.4, 0.4];%节点Y坐标
% % nodeUx = [0, 1, 2, 3, 4, 5,...
% %           0, 1, 2, 3, 4, 5,...
% %           0, 1, 2, 3, 4, 5];%节点X方向位移
% % nel = 10;%单元数
% % nelx = 5;%X方向单元数
% % nely = 2;%Y方向单元数
% % X = [];
% % Y = [];
% % Ux = [];
% % for j = 1:nely
% %     for i = 1:nelx
% %         X0 = [nodex((j-1)*(nelx+1)+i), nodex((j-1)*(nelx+1)+i+1),...
% %               nodex(j*(nelx+1)+i+1), nodex(j*(nelx+1)+i)]';
% %         X = [X X0];
% %         Y0 = [nodey((j-1)*(nelx+1)+i), nodey((j-1)*(nelx+1)+i+1),...
% %               nodey(j*(nelx+1)+i+1), nodey(j*(nelx+1)+i)]';
% %         Y = [Y Y0];
% %         Ux0 = [nodeUx((j-1)*(nelx+1)+i), nodeUx((j-1)*(nelx+1)+i+1),...
% %               nodeUx(j*(nelx+1)+i+1), nodeUx(j*(nelx+1)+i)]';
% %         Ux = [Ux Ux0];
% %             end   
% % end
% % patch(X,Y,Ux); %填充
% % shading interp;   %色彩平滑
% % colorbar; 
% % axis equal;

% for  i=1:NE  
%     ML=ME(i,1);  %单元左侧节点的序号
%     MR=ME(i,2);  %单元右侧节点的序号
%     XY=zeros(6,1);
%        XY(1,1)=u(ML*3-2,1);
%       XY(2,1)=u(ML*3-1,1);
%       XY(3,1)=u(ML*3,1);
%       XY(4,1)=u(MR*3-2,1);
%       XY(5,1)=u(MR*3-1,1);
%       XY(6,1)=u(MR*3,1);
%     DX=MP(MR,1)-MP(ML,1);  %detX
%     DY=MP(MR,2)-MP(ML,2);  %detY
%     L=(DX^2+DY^2)^0.5;  %计算每个单元的长度
%     a=atan(DY/DX);  %单元的角度（弧度制）
%     C=cos(a);
%     S=sin(a);
%     T=[C -S 0 0 0 0
%       S C 0 0 0 0
%       0 0 1 0 0 0
%       0 0 0 C -S 0
%       0 0 0 S C 0
%       0 0 0 0 0 1];
%     xy=T^(-1)*XY;
%  for X=1:0.1:L
%    N_1=1-X/L;
%    N_2=X/L;
%   N1=1/L^3*(2*X^3-3*X^2*L+L^3);
%   N2=1/L^3*(L*X^3-2*X^2*L^2+X*L^3);
%   N3=1/L^3*(-2*X^3+3*X^2*L);
%   N4=1/L^3*(L*X^3-X^2*L^2);
%   ux0=MP(ML,1);
%   uy0=MP(ML,2);
%   ux=N_1*xy(1,1)+N_2*xy(4,1);
%   uy=[N1 N2 N3 N4]*[xy(2,1) xy(3,1) xy(5,1) xy(6,1)]';
%   plot([ux0,ux],[uy0,uy],'b')
%   hold on
%   ux0=ux;
%   uy0=uy;
%  end
% end



% for i=1:NE
%     ML=ME(i,1);  %单元左侧节点的序号
%     MR=ME(i,2);  %单元右侧节点的序号
%     plot([MP(ML,1),MP(MR,1)],[MP(ML,2),MP(MR,2)],'k')
%     hold on
% end

for i=1:NE
    ML=ME(i,1);  %单元左侧节点的序号
    MR=ME(i,2);  %单元右侧节点的序号
    plot([MP(ML,1),MP(MR,1)],[MP(ML,2),MP(MR,2)],'k')
    hold on
    plot([MP(ML,1)+10*u(ML*3-2,1),MP(MR,1)+10*u(ML*3-1,1)],[MP(ML,2)+10*u(MR*3-2,1),MP(MR,2)+10*u(MR*3-1,1)],'b')
    hold on
end