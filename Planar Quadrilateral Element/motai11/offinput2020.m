function[NF,NP,MP,NE,ME,NR,NRR,NL,LL,E]=offinput2020(p,q)
NF=3;%�ڵ����ɶ�
NP=fscanf(p,'%d',1);%�ڵ���
MP=zeros(NP,2);
for i=1:NP
    MP(i,:)=fscanf(p,'%d',2);
end%д��ڵ�����
NE=fscanf(p,'%d',1);%��Ԫ��
ME=zeros(NE,2);
for i=1:NE
    ME(i,:)=fscanf(p,'%d',2);
end%д�����Ԫ�Ķ�Ӧ�ڵ�
NR=fscanf(p,'%d',1);%λ��Լ������
NRR=zeros(NR,2);
for i=1:NR
    NRR(i,:)=fscanf(p,'%d',2);
end%д��Լ��λ�ƺż���Ӧ��С
NL=fscanf(p,'%d',1);%L��Լ������
LL=zeros(NL,2);
for i=1:NL
    LL(i,:)=fscanf(p,'%d',2);
end%д��Լ�����ż���Ӧ��С
E=zeros(NE,3);%����ÿ����Ԫ��EAI
for i=1:NE
    E(i,:)=fscanf(q,'%f',3);
end%д�����Ԫ��EAI
end