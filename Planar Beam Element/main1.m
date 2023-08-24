clear all
clc
syms v  f E A L 
%v是位移列向量
%K是总的刚度矩阵
%f是位移列向量
p=fopen('text.txt','r');%写入有信息的文件
NF=3;%节点自由度
NP=fscanf(p,'%d',1)%节点数
MP=zeros(NP,2);
for i=1:NP
    MP(i,:)=fscanf(p,'%d',2);
end%写入节点坐标
MP
NE=fscanf(p,'%d',1)%单元数
ME=zeros(NE,2);
for i=1:NE
    ME(i,:)=fscanf(p,'%d',2);
end%写入各单元的对应节点
NR=fscanf(p,'%d',1)%位移约束个数
NRR=zeros(NR,2);
for i=1:NR
    NRR(i,:)=fscanf(p,'%d',2)
end%写入约束位移号及对应大小
NL=fscanf(p,'%d',1)%L力约束个数
LL=zeros(NL,2);
for i=1:NL
    LL(i,:)=fscanf(p,'%d',2);
end%写入约束力号及对应大小
E=zeros(NE,3)%对于每个单元的EAI
% for i=1:NE
%     E(i,:)=fscanf(p,'%d',3);
% end%写入各单元的EAI
E=[  200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004]
              
NDF=NF*NP;%维度
K=zeros(NDF,NDF)%总刚度矩阵的开始，零矩阵
n=2*NF
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%生成单位刚度矩阵%名字后面再改%给该单元的节点编号和所有节点坐标
    K=jiahe(K,k,ME(i,:),n);%加到总刚度阵里%名字后面再改
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
    K(i,i)=aa*K(i,i);
end%对角大数法
for i=1:NR
    P(i)=K(i,i)*NRR(i,2);
end%对角大数的力处理
u=K^(-1)*P;
fprintf('位移向量\n');
fprintf('%1.4f\n',u);%保留4位小数
F=Z*u;
fprintf('力向量：\n');
fprintf('%1.4f\n',F);%保留4位小数
filename = 'OUTCOME.xlsx';
xlswrite(filename,u)  