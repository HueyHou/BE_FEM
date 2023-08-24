clear all
clc
syms u f E A L 
%u是位移列向量
%K是总的刚度矩阵
%f是位移列向量
E=210e9;%杨氏模量
h=0.02;%厚度
v=0.3;%泊松比
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%写入题目信息文件
p=fopen('nodes_coordinates1.txt','r');%写入有信息的文件
q=fopen('elements1.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL]=sqaoffinput2020(p,q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%总刚度矩阵组装
NDF=NF*NP;%维度
K=zeros(NDF,NDF);%总刚度矩阵的开始，零矩阵
for i=1:NE
    [bb,k]=sibianxing(h,E,v,ME(i,:),MP,i);%生成单位刚度矩阵%名字后面再改%给该单元的节点编号和所有节点坐标
    K=jiaherect(K,k,ME(i,:));%加到总刚度阵里%名字后面再改
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%调用求解函数，求解位移、力列向量
[u,F]=testofsolve(NP,NL,NR,NRR,K,LL);
u=100*u;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%绘制变形图，sigmaX，sigamY，sigmaXY应力图
U=zeros(NP,2);
sigma=[];
sigmaX=[];
sigmaY=[];
sigmaXY=[];
X0=[];%每个单元4个节点变形前的横坐标。
Y0=[];%每个单元4个节点变形前的纵坐标。
X=[];%每个单元4个节点变形后的横坐标。
Y=[];%每个单元4个节点变形后的纵坐标。
XXX=[];YYY=[];

for i=1:NP
    U(i,1)=u(2*i-1,1);
    U(i,2)=u(2*i,1);
end%位移矩阵

MUU=MP+U;
%形变后的点坐标


for i=1:NE
    ML=ME(i,1);  %单元1节点的序号
    MR=ME(i,2);  %单元2节点的序号
    MT=ME(i,3);  %单元3节点的序号
    MU=ME(i,4);  %单元4节点的序号
    
    MPX=[MP(ML,1);MP(MR,1);MP(MT,1);MP(MU,1)];
    MPY=[MP(ML,2);MP(MR,2);MP(MT,2);MP(MU,2)];
    X0=[X0 MPX];
    Y0=[Y0 MPY];
    %变形前，把第i个单元的四个节点的横纵坐标分别存入X,Y中。
    
    MUUX=[MUU(ML,1);MUU(MR,1);MUU(MT,1);MUU(MU,1)];
    MUUY=[MUU(ML,2);MUU(MR,2);MUU(MT,2);MUU(MU,2)];
    X=[X MUUX];
    Y=[Y MUUY];
    %变形后，把第i个单元的四个节点的横纵坐标分别存入X,Y中。
    sigma=[];
    Z=[];
    for j=1:4
        [bb,Z0]=zuobiao(E,v,ME,MP,i,j);
        %输出第i个单元的第j个点的D*B矩阵和形函数。
        UU=[U(ML,1);U(ML,2);U(MR,1);U(MR,2);U(MT,1);U(MT,2);U(MU,1);U(MU,2)];
        sigma0=bb*UU;
        sigma=[sigma sigma0];
        Z=[Z Z0];
    end
    sigmaX=[sigmaX sigma(1,:)'];
    sigmaY=[sigmaY sigma(2,:)'];
    sigmaXY=[sigmaXY sigma(3,:)'];
    XXX=[XXX Z(1,:)'];
    YYY=[YYY Z(2,:)'];%4个高斯点坐标。
end
xx0=[X0;X0(1,:)];yy0=[Y0;Y0(1,:)];
xx=[X;X(1,:)];yy=[Y;Y(1,:)];
%形成首尾相连。

subplot (2,2,1);
plot(xx0,yy0,'b.--');hold on;plot(xx,yy,'r.-');title('变形图');
subplot (2,2,2);
patch(XXX,YYY,sigmaX);title('应力x');
colorbar;%显示色彩表。
shading interp;   %色彩平滑 
subplot (2,2,3);
patch(XXX,YYY,sigmaY);title('应力y');
colorbar;%显示色彩表。
subplot (2,2,4);
patch(XXX,YYY,sigmaXY);title('应力xy');
colorbar;%显示色彩表。