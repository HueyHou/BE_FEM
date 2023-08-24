clear all
clc
syms v  f E A L 
%v是位移列向量
%K是总的刚度矩阵
%f是位移列向量
p=fopen('textofbeans.txt','r');%写入有信息的文件
q=fopen('EAL.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q);

NDF=NF*NP;%维度
K=zeros(NDF,NDF);%总刚度矩阵的开始，零矩阵
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%生成单位刚度矩阵%名字后面再改%给该单元的节点编号和所有节点坐标
    K=jiahe(K,k,ME(i,:));%组装总刚度阵
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