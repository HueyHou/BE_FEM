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

X=zeros(3,NE);
Y=zeros(3,NE);
X0=zeros(4,NE);
Y0=zeros(4,NE);

for i=1:NP
    U(i,1)=u(2*i-1,1);
    U(i,2)=u(2*i,1);
end%位移矩阵

MU=MP+U;
%形变后的点坐标

for i=1:NE
    a=ME(i,1);b=ME(i,2);c=ME(i,3);
    [bb,k]=sanjiao(t,E,v,ME(i,:),MP,i);
    sigma=bb*0.01*[U(a,1);U(a,2);U(b,1);U(b,2);U(c,1);U(c,2)];
    sigmaX(i,1)=sigmaX(i,1)+sigma(1,1);
    sigmaY(i,1)=sigmaY(i,1)+sigma(2,1);
    sigmaXY(i,1)=sigmaXY(i,1)+sigma(3,1);
    X(1,i)=X(1,i)+MU(a,1);
    X(2,i)=X(2,i)+MU(b,1);
    X(3,i)=X(3,i)+MU(c,1);
    Y(1,i)=Y(1,i)+MU(a,2);
    Y(2,i)=Y(2,i)+MU(b,2);
    Y(3,i)=Y(3,i)+MU(c,2);
    X0(1,i)=X0(1,i)+MP(a,1);
    X0(2,i)=X0(2,i)+MP(b,1);
    X0(3,i)=X0(3,i)+MP(c,1);
    X0(4,i)=X0(4,i)+MP(a,1);
    Y0(1,i)=Y0(1,i)+MP(a,2);
    Y0(2,i)=Y0(2,i)+MP(b,2);
    Y0(3,i)=Y0(3,i)+MP(c,2);
    Y0(4,i)=Y0(4,i)+MP(a,2);
end
XX=[X;X(1,:)];YY=[Y;Y(1,:)];
subplot (2,2,1);
plot(X0,Y0,'b.--');hold on;plot(XX,YY,'r.-');title('变形图');
subplot (2,2,2);
patch(X,Y,sigmaX);title('应力x');
colorbar;%显示色彩表。
subplot (2,2,3);
patch(X,Y,sigmaY);title('应力y');
colorbar;%显示色彩表。
subplot (2,2,4);
patch(X,Y,sigmaXY);title('应力xy');
colorbar;%显示色彩表。
