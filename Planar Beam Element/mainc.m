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
%  K[1,:]=0;
%  K[:,1]=0;
%  K[2,:]=0;
%  K[:,2]=0;
%  K[13,:]=0;
%  K[:,13]=0;
%  K[14,:]=0;
%  K[:,14]=0;
%  K[25,:]=0;
%  K[:,25]=0;
%  K[26,:]=0;
%  K[:,26]=0;
%  
            
for i=1:NR
    f=NRR(i,1);
%      K(f,f)=aa*K(f,f);
    K(f,:)=0;
    K(:,f)=0;
    K(f,f)=1;
end%对角大数法
for i=1:NR
    f=NRR(i,1);
%    P(f)=K(f,f)*NRR(i,2)
    P(f)=0;
end%对角大数的力处理
u=K^(-1)*P
u=inv(K)*P;
fprintf('位移向量\n');
fprintf('%1.9f\n',u);%保留4位小数
Z;
F=Z*u;
fprintf('力向量：\n');
fprintf('%1.9f\n',F);%保留4位小数