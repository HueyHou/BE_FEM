clear all
clc
syms u f E A L 
%u��λ����������K���ܵĸնȾ���f��λ��������
E=210e9; %����ģ��
h=0.005; %���
v=0.3; %���ɱ�
aa=12.5e-6; %������ϵ��
T=50; %�¶�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%д����Ŀ��Ϣ�ļ�
p=fopen('nodes_coordinateshot.txt','r');%д������Ϣ���ļ�
q=fopen('elementshot.txt','r');
[NF,NP,MP,NE,ME,NR,NRR]=hotsqaoffinput2020(p,q);
%%%%����ڵ����ɶȣ��ڵ�������ڵ����꣬��Ԫ��������Ԫ�ڵ��ţ�λ��Լ��������λ��Լ���������غ��������غ����������ϵ�E��A��L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�ܸնȾ�����װ
NDF=NF*NP;%�ܸն���ά��
K=zeros(NDF,NDF);%�����ܸնȾ��������
HH=zeros(NDF,1);%������Ӧ���������������
for i=1:NE
    [bb,k,heat]=fehes_heat(h,E,v,aa,T,ME(i,:),MP,i);
    K=jiaherect(K,k,ME(i,:));%�ӵ��ܸն�����%���ֺ����ٸ�
    HH=jiaherect_heat(HH,heat,ME(i,:));%�Ӻ���Ӧ��������
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%������⺯�������λ�ơ���������
[u,F]=hottestofsolve(NP,NR,NRR,K,HH);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%���Ʊ���ͼ��sigmaX��sigamY��sigmaXYӦ��ͼ
U=zeros(NP,2);
X0=[];%ÿ����Ԫ4���ڵ����ǰ�ĺ����ꡣ
Y0=[];%ÿ����Ԫ4���ڵ����ǰ�������ꡣ
X=[];%ÿ����Ԫ4���ڵ���κ�ĺ����ꡣ
Y=[];%ÿ����Ԫ4���ڵ���κ�������ꡣ
sigmaX=[];
sigmaY=[];
sigmaXY=[];

for i=1:NP
    U(i,1)=u(2*i-1,1);
    U(i,2)=u(2*i,1);
end%λ�ƾ���

MUU=MP+U*200;%�α��ĵ�����

for i=1:NE
    ML=ME(i,1);  %��Ԫ1�ڵ�����
    MR=ME(i,2);  %��Ԫ2�ڵ�����
    MT=ME(i,3);  %��Ԫ3�ڵ�����
    MU=ME(i,4);  %��Ԫ4�ڵ�����
    
    MPX=[MP(ML,1);MP(MR,1);MP(MT,1);MP(MU,1)];
    MPY=[MP(ML,2);MP(MR,2);MP(MT,2);MP(MU,2)];
    X0=[X0 MPX];
    Y0=[Y0 MPY];
    %����ǰ���ѵ�i����Ԫ���ĸ��ڵ�ĺ�������ֱ����X,Y�С�
    
    MUUX=[MUU(ML,1);MUU(MR,1);MUU(MT,1);MUU(MU,1)];
    MUUY=[MUU(ML,2);MUU(MR,2);MUU(MT,2);MUU(MU,2)];
    X=[X MUUX];
    Y=[Y MUUY];
    %���κ󣬰ѵ�i����Ԫ���ĸ��ڵ�ĺ�������ֱ����X,Y�С�
    sigma=[];
    for j=1:4
        [bb,N]=zuobiao(E,v,ME,MP,i,j);
        %�����i����Ԫ�ĵ�j�����D*B������κ�����
        UU=[U(ML,1);U(ML,2);U(MR,1);U(MR,2);U(MT,1);U(MT,2);U(MU,1);U(MU,2)];
        sigma0=bb*UU-[E*aa*T;E*aa*T;0];
        sigma=[sigma sigma0];
    end
    sigmaX=[sigmaX sigma(1,:)'];
    sigmaY=[sigmaY sigma(2,:)'];
    sigmaXY=[sigmaXY sigma(3,:)'];
end
xx0=[X0;X0(1,:)];yy0=[Y0;Y0(1,:)];
xx=[X;X(1,:)];yy=[Y;Y(1,:)];
%�γ���β������

figure(1)
yy1=plot(xx0,yy0,'b.-');hold on;yy=plot(xx,yy,'r');title('����ͼ');
set(yy,'LineWidth',1.5);
set(yy1,'LineWidth',1);
axis equal
figure(2)
subplot (2,2,1);
patch(X,Y,sigmaX);title('Ӧ��x');
colorbar;%��ʾɫ�ʱ�
axis equal
subplot (2,2,2);
patch(X,Y,sigmaY);title('Ӧ��y');
colorbar;%��ʾɫ�ʱ�
axis equal
subplot (2,2,3);
patch(X,Y,sigmaXY);title('Ӧ��xy');
colorbar;%��ʾɫ�ʱ�
axis equal