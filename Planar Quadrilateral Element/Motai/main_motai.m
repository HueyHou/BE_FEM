clear all
clc
syms v f E A L 
%v是位移列向量
%K是总的刚度矩阵
%f是位移列向量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%写入已知条件
p=fopen('textofbeans.txt','r');%打开节点信息文档
q=fopen('EAL2020.txt','r');%打开材料信息文档
[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q);
%输出节点自由度，节点个数，节点坐标，单元个数，单元节点编号，位移约束数量及位移约束向量，载荷数量及载荷向量，材料的E，A，L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%总刚度矩阵组装
NDF=NF*NP;%维度
K=zeros(NDF,NDF);%创建总刚度矩阵的零矩阵
MM=zeros(NDF,NDF);
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%生成单位刚度矩阵，给该单元的节点编号和所有节点坐标
    m=zhiliang(i,ME(i,:),MP,E);
    K=jiahe(K,k,ME(i,:),NF*2);%总体刚度阵组装
    MM=jiaheMM(MM,m,ME(i,:));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%求解30阶
NUM=30;
[w,d]=Mtestofsolve(NP,NR,NRR,K,MM,NUM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%作模态图
for j=1:NUM
    u=d(:,j); 
    for i=1:NE
        ML=ME(i,1); %单元左侧节点的序号
        MR=ME(i,2); %单元右侧节点的序号
        XY=[u(ML*3-2,1);u(ML*3-1,1);u(ML*3,1);u(MR*3-2,1);u(MR*3-1,1);u(MR*3,1)];
        DX=MP(MR,1)-MP(ML,1); %detX
        DY=MP(MR,2)-MP(ML,2); %detY
        L=(DX^2+DY^2)^0.5; %计算每个单元的长度
        a=atan(DY/DX); %单元的角度（弧度制）
        C=cos(a);
        S=sin(a);
        T1=[C -S 0 0 0 0
        S C 0 0 0 0
        0 0 1 0 0 0
        0 0 0 C -S 0
        0 0 0 S C 0
        0 0 0 0 0 1];
        T2=[C -S;S C];
        xy=T1\XY;
        ux0=MP(ML,1);%u(ML*3-2,1);
        uy0=MP(ML,2);%u(ML*3-1,1);
        m=200;
        s=L/m;
        ux=zeros(201,1);
        uy=zeros(201,1); 
        for c=1:201
            X=s*(c-1);
            N_1=1-X/L;
            N_2=X/L;
            N1=(1/(L^3))*(2*X^3-3*X^2*L+L^3);
            N2=(1/(L^3))*(L*X^3-2*X^2*L^2+X*L^3);
            N3=(1/(L^3))*(-2*X^3+3*X^2*L);
            N4=(1/(L^3))*(L*X^3-X^2*L^2);
            N=1*[N_1 0 0 N_2 0 0;0 N1 N2 0 N3 N4];
            x=[X;0];
            uv1=N*xy+x;
            uv2=T2*uv1;
            ux(c)=ux0+uv2(1,1);
            uy(c)=uy0+uv2(2,1);
        end
    figure(j);
    plot(ux,uy,'r.-');
    hold on
    plot([MP(ML,1),MP(MR,1)],[MP(ML,2),MP(MR,2)],'k.--')
    hold on
    end
end