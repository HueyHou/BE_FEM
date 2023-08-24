clear all
clc
syms u f E A L 
%u��λ��������
%K���ܵĸնȾ���
%f��λ��������
E=210*10^9;%����ģ��
t=0.02;%���
v=0.3;%���ɱ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%д����Ŀ��Ϣ�ļ�
p=fopen('nodes_coordinates.txt','r');
q=fopen('elements.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL]=trioffinput2020(p,q);
%%%%����ڵ����ɶȣ��ڵ�������ڵ����꣬��Ԫ��������Ԫ�ڵ��ţ�λ��Լ��������λ��Լ���������غ��������غ����������ϵ�E��A��L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�ܸնȾ�����װ
NDF=NF*NP;%�ܸն���ά��
K=zeros(NDF,NDF);%�����ܸնȾ���������
for i=1:NE
    [bb,k]=sanjiao(t,E,v,ME(i,:),MP,i);%������λ�ն���
    K=jiahetri(K,k,ME(i,:));%��װ�ܸն���
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%������⺯�������λ�ơ���������
[u,F]=testofsolve(NP,NL,NR,NRR,K,LL);
u=u*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%���Ʊ���ͼ��sigmaX��sigamY��sigmaXYӦ��ͼ

U=zeros(NP,2);

sigmaX=zeros(NE,1);
sigmaY=zeros(NE,1);
sigmaXY=zeros(NE,1);

sigmaX=zeros(NE,1);
sigmaY=zeros(NE,1);
sigmaXY=zeros(NE,1);
X=zeros(3,NE);
Y=zeros(3,NE);
for i=1:NE
    a=ME(i,1);b=ME(i,2);c=ME(i,3);
    sigama=bb*[U(a,1);U(a,2);U(b,1);U(b,2);U(c,1);U(c,2)];
    sigmaX(i,1)=sigmaX(i,1)+sigma(1,1);
    sigmaY(i,1)=sigmaY(i,1)+sigma(2,1);
    sigmaXY(i,1)=sigmaXY(i,1)+sigma(3,1);
    X(1,i)=X(1,i)+MU(a,1);
    X(2,i)=X(2,i)+MU(b,1);
    X(3,i)=X(3,i)+MU(c,1);
    Y(1,i)=Y(1,i)+MU(a,2);
    Y(2,i)=Y(2,i)+MU(b,2);
    Y(3,i)=Y(3,i)+MU(c,2);
end
subplot (1,3,1)
patch(X,Y,sigmaX)
subplot (1,3,2)
patch(X,Y,sigmaY)
subplot (1,3,3)
patch(X,Y,sigmaXY)
colorbar;