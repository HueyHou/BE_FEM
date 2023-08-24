function [z]=assemble(KK,k,i,j,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�ú������е�Ԫ�նȾ������װ
%%%%���뵥Ԫ�նȾ���k����Ԫ�Ľڵ���i��j,�նȾ������n
%%%%�������նȾ���KK
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