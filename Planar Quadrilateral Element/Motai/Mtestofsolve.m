function[w,d]=Mtestofsolve(NP,NR,NRR,K,M,nub)
%可以用来求解三角形/四边形单元振动学问题
%NP:节点数
%NR：位移约束个数
%NRR：位移约束向量
%K：总刚度矩阵
%M:总质量阵
%nub:振动频率需要个数

NF=3;
%一个节点的自由度

NDF=NF*NP;%维度

for i=1:NR
    f=NRR(i,1);
    
    if NRR(i,2)==0
         K(f,:)=0;
         K(:,f)=0;
         K(f,f)=1;
         
         M(f,:)=0;
         M(:,f)=0;
    
    end%处理刚度阵和质量阵
    
end

syms d w ww dd

[dd,ww]=eig(K,M);

w=zeros(nub,1);

d=zeros(NDF,nub);


for i=1:nub
    w(i,1)=(ww(i,i))^0.5;
    d(:,i)= dd(:,i);
end

%w=[w1;w2;w3]  频率
%d=[d1;d2;d3]  节点模态
%d1=[u1;v1;u2;v2] 一个频率的节点模态

end