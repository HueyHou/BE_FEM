function [z]=assemble(KK,k,i,j,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%该函数进行单元刚度矩阵的组装
%%%%输入单元刚度矩阵k，单元的节点编号i、j,刚度矩阵阶数n
%%%%输出整体刚度矩阵KK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % if i>j
% %     a=i,i=j,j=a;
% % end
if n=2
    Dof(1)=i;
    Dof(2)=j;
elseif n=4
    Dof(1)=2*i-1;
    Dof(2)=2*i;
    Dof(3)=2*j-1;
    Dof(4)=2*j;
elseif n=6
    Dof(1)=i*3-2;
    Dof(2)=i*3-1;
    Dof(3)=i*3;
    Dof(4)=j*3-2;
    Dof(5)=j*3-1;
    Dof(6)=j*3;
end
for n1=1:n
    for n2=1:n
        KK(Dof(n1),Dof(n2))=KK(Dof(n1),Dof(n2))+k(n1,n2);
    end
end
z=KK;