clear all
clc
syms v  f E A L 
%v��λ��������
%K���ܵĸնȾ���
%f��λ��������
p=fopen('textofbeans.txt','r');%д������Ϣ���ļ�
q=fopen('EAL.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q);

NDF=NF*NP;%ά��
K=zeros(NDF,NDF);%�ܸնȾ���Ŀ�ʼ�������
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%���ɵ�λ�նȾ���%���ֺ����ٸ�%���õ�Ԫ�Ľڵ��ź����нڵ�����
    K=jiahe(K,k,ME(i,:));%��װ�ܸն���
end
P=zeros(3*NP,1);%������
for i=1:NL
    P(LL(i,1))=LL(i,2);
end%д���غ�
q=0;
for i=1:NDF
    for j=1:NDF
        o=abs(K(i,j));
        if q<=o;
            q=o;
        end
    end
end%������һ����
aa=q*10^4;%�ԽǴ����Ĵ���
Z=K;%��������ն���
for i=1:NR
    f=NRR(i,1);
    K(i,i)=aa*K(i,i);
end%�ԽǴ�����
for i=1:NR
    P(i)=K(i,i)*NRR(i,2);
end%�ԽǴ�����������
u=K^(-1)*P;
fprintf('λ������\n');
fprintf('%1.4f\n',u);%����4λС��
F=Z*u;
fprintf('��������\n');
fprintf('%1.4f\n',F);%����4λС��