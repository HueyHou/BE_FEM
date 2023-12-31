function [z]=jiahetri(KK,k,mm)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%该函数进行单元刚度矩阵的组装
%%%%输入:单元刚度矩阵k，单元的节点编号i,j,k(ME(i,:))，单位单元维数n
%%%%输出:总刚度矩阵KK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=mm(1,1);  %单元1节点的序号（逆时针）
j=mm(1,2);  %单元2节点的序号（逆时针）
l=mm(1,3);  %单元3节点的序号（逆时针）

Dof(1)=2*i-1;
Dof(2)=2*i;  
Dof(3)=2*j-1;
Dof(4)=2*j;
Dof(5)=2*l-1;
Dof(6)=2*l;

for n1=1:6
    for n2=1:6
        KK(Dof(n1),Dof(n2))=KK(Dof(n1),Dof(n2))+k(n1,n2);
    end
end

z=KK;