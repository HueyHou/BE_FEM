clear all
clc
syms v  f E A L 
%v��λ��������
%K���ܵĸնȾ���
%f��λ��������
p=fopen('text.txt','r');%д������Ϣ���ļ�
NF=3;%�ڵ����ɶ�
NP=fscanf(p,'%d',1)%�ڵ���
MP=zeros(NP,2);
for i=1:NP
    MP(i,:)=fscanf(p,'%d',2);
end%д��ڵ�����
MP
NE=fscanf(p,'%d',1)%��Ԫ��
ME=zeros(NE,2);
for i=1:NE
    ME(i,:)=fscanf(p,'%d',2);
end%д�����Ԫ�Ķ�Ӧ�ڵ�
NR=fscanf(p,'%d',1)%λ��Լ������
NRR=zeros(NR,2);
for i=1:NR
    NRR(i,:)=fscanf(p,'%d',2)
end%д��Լ��λ�ƺż���Ӧ��С
NL=fscanf(p,'%d',1)%L��Լ������
LL=zeros(NL,2);
for i=1:NL
    LL(i,:)=fscanf(p,'%d',2);
end%д��Լ�����ż���Ӧ��С
E=zeros(NE,3)%����ÿ����Ԫ��EAI
% for i=1:NE
%     E(i,:)=fscanf(p,'%d',3);
% end%д�����Ԫ��EAI
E=[  200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.009          0.0006
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004
             200000000000         0.006          0.0004]
              
NDF=NF*NP;%ά��
K=zeros(NDF,NDF)%�ܸնȾ���Ŀ�ʼ�������
n=2*NF
for i=1:NE
    k=fehes(E,ME(i,:),MP,i);%���ɵ�λ�նȾ���%���ֺ����ٸ�%���õ�Ԫ�Ľڵ��ź����нڵ�����
    K=jiahe(K,k,ME(i,:),n);%�ӵ��ܸն�����%���ֺ����ٸ�
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
filename = 'OUTCOME.xlsx';
xlswrite(filename,u)  