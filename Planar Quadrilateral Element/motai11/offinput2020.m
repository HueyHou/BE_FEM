function[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q)
NF=3;%节点自由度
NP=fscanf(p,'%d',1);%节点数
MP=zeros(NP,2);
for i=1:NP
    MP(i,:)=fscanf(p,'%d',2);
end%写入节点坐标
NE=fscanf(p,'%d',1);%单元数
ME=zeros(NE,2);
for i=1:NE
    ME(i,:)=fscanf(p,'%d',2);
end%写入各单元的对应节点
NR=fscanf(p,'%d',1);%位移约束个数
NRR=zeros(NR,2);
for i=1:NR
    NRR(i,:)=fscanf(p,'%d',2);
end%写入约束位移号及对应大小
NL=fscanf(p,'%d',1);%L力约束个数
LL=zeros(NL,2);
for i=1:NL
    LL(i,:)=fscanf(p,'%d',2);
end%写入约束力号及对应大小
E=zeros(NE,3);%对于每个单元的EAI
for i=1:NE
    E(i,:)=fscanf(q,'%f',3);
end%写入各单元的EAI
end