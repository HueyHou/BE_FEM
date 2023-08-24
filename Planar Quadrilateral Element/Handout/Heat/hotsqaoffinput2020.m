function[NF,NP,MP,NE,ME,NR,NRR]=hotsqaoffinput2020(p,q)
%三角形单元输入文件
%NF:节点自由度
%NP:节点数
%MP:节点坐标矩阵
%NE:单元数
%ME：单元节点信息
%NR：位移约束个数
%NRR：位移约束向量

NF=2;%节点自由度
P1=[];
P2=[];

P1=fscanf(p,'%f',inf);
Q1=fscanf(q,'%d',inf);

[m1,n1]=size(P1);
[m2,n2]=size(Q1);

NP=m1/3;%节点数
MP=zeros(NP,2);

for i=1:NP
    a=3*i-1;
    b=3*i;
    MP(i,1)=P1(a,1);
    MP(i,2)=P1(b,1);
end%写入节点坐标

NE=m2/5;%单元数
ME=zeros(NE,4);

for i=1:NE
    a=5*i-3;
    b=5*i-2;
    c=5*i-1;
    d=5*i;
    ME(i,1)=Q1(a,1);
    ME(i,2)=Q1(b,1);
    ME(i,3)=Q1(c,1);
    ME(i,4)=Q1(d,1);
end%写入各单元的对应节点


s=1;
ni=[];
for i=1:NP
    if MP(i,1)==0
        ni(s,1)=i;
        s=s+1;%相当于计数器，不断往下跳
    end
     if MP(i,1)==0.5
        ni(s,1)=i;
        s=s+1;%相当于计数器，不断往下跳
    end
end
%遍历节点坐标，找出x=0（left）的节点是第几个节点，并提取出来
[j1,k1]=size(ni);
%节点有几个
NR=2*j1;
%位移约束个数
ss=1;
NRR=zeros(NR,2);
for i=1:j1
    j=ni(i,1);%一个个去查是第几个节点
    NRR(ss,1)=2*j-1;
    NRR(ss,2)=0;%约束该节点对应的x方向位移
    ss=ss+1;%计数器，不断往下写
    NRR(ss,1)=2*j;
    NRR(ss,2)=0;%约束该节点对应的y方向位移
    ss=ss+1;%计数器，不断往下写
end%写入约束位移信息
end