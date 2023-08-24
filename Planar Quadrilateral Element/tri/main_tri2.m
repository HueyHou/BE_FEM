clear all
clc
syms u f E A L 
%u是位移列向量
%K是总的刚度矩阵
%f是位移列向量
E=210*10^9;%杨氏模量
t=0.02;%厚度
v=0.3;%泊松比
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%写入题目信息文件
p=fopen('nodes_coordinates.txt','r');
q=fopen('elements.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL]=trioffinput2020(p,q);
%%%%输出节点自由度，节点个数，节点坐标，单元个数，单元节点编号，位移约束数量及位移约束向量，载荷数量及载荷向量，材料的E，A，L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%总刚度矩阵组装
NDF=NF*NP;%总刚度阵维度
K=zeros(NDF,NDF);%创建总刚度矩阵的零矩阵
for i=1:NE
    [bb,k]=sanjiao(t,E,v,ME(i,:),MP,i);%创建单位刚度阵
    K=jiahetri(K,k,ME(i,:));%组装总刚度阵
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%调用求解函数，求解位移、力列向量
[u,F]=testofsolve(NP,NL,NR,NRR,K,LL);
u=u*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%绘制变形图，sigmaX，sigamY，sigmaXY应力图

U=zeros(NP,2);

sigmaX=zeros(NE,1);
sigmaY=zeros(NE,1);
sigmaXY=zeros(NE,1);

sigmaX=zeros(NE,1);
sigmaY=zeros(NE,1);
sigmaXY=zeros(NE,1);
X=zeros(3,NE);
Y=zeros(3,NE);
for i=1:NE
    a=ME(i,1);b=ME(i,2);c=ME(i,3);
    sigama=bb*[U(a,1);U(a,2);U(b,1);U(b,2);U(c,1);U(c,2)];
    sigmaX(i,1)=sigmaX(i,1)+sigma(1,1);
    sigmaY(i,1)=sigmaY(i,1)+sigma(2,1);
    sigmaXY(i,1)=sigmaXY(i,1)+sigma(3,1);
    X(1,i)=X(1,i)+MU(a,1);
    X(2,i)=X(2,i)+MU(b,1);
    X(3,i)=X(3,i)+MU(c,1);
    Y(1,i)=Y(1,i)+MU(a,2);
    Y(2,i)=Y(2,i)+MU(b,2);
    Y(3,i)=Y(3,i)+MU(c,2);
end
subplot (1,3,1)
patch(X,Y,sigmaX)
subplot (1,3,2)
patch(X,Y,sigmaY)
subplot (1,3,3)
patch(X,Y,sigmaXY)
colorbar;