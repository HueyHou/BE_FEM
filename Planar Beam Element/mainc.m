clear all
clc
syms v  f E A L 
%v��λ��������
%K���ܵĸնȾ���
%f��λ��������
p=fopen('textofbeans.txt','r');%д������Ϣ���ļ�
q=fopen('EAL.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q);
%����ڵ�������ڵ����꣬��Ԫ��������Ԫ�ڵ��ţ�λ��Լ��������λ��Լ���������غ��������غ����������ϵ�E��A��L
NDF=NF*NP;%ά��
K=zeros(NDF,NDF);%�ܸնȾ���Ŀ�ʼ�������
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%���ɵ�λ�նȾ���%���ֺ����ٸ�%���õ�Ԫ�Ľڵ��ź����нڵ�����
    K=jiahe(K,k,ME(i,:),NF*2);%�ӵ��ܸն�����%���ֺ����ٸ�
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
end%�ԽǴ�����
for i=1:NR
    f=NRR(i,1);
%    P(f)=K(f,f)*NRR(i,2)
    P(f)=0;
end%�ԽǴ�����������
u=K^(-1)*P
u=inv(K)*P;
fprintf('λ������\n');
fprintf('%1.9f\n',u);%����4λС��
Z;
F=Z*u;
fprintf('��������\n');
fprintf('%1.9f\n',F);%����4λС��