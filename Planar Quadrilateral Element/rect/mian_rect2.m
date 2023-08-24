clear all
clc
syms u f E A L 
%u��λ��������
%K���ܵĸնȾ���
%f��λ��������
E=210e9;%����ģ��
h=0.02;%���
v=0.3;%���ɱ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%д����Ŀ��Ϣ�ļ�
p=fopen('nodes_coordinates1.txt','r');%д������Ϣ���ļ�
q=fopen('elements1.txt','r');
[NF,NP,MP,NE,ME,NR,NRR,NL,LL]=sqaoffinput2020(p,q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�ܸնȾ�����װ
NDF=NF*NP;%ά��
K=zeros(NDF,NDF);%�ܸնȾ���Ŀ�ʼ�������
for i=1:NE
    [bb,k]=sibianxing(h,E,v,ME(i,:),MP,i);%���ɵ�λ�նȾ���%���ֺ����ٸ�%���õ�Ԫ�Ľڵ��ź����нڵ�����
    K=jiaherect(K,k,ME(i,:));%�ӵ��ܸն�����%���ֺ����ٸ�
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%������⺯�������λ�ơ���������
[u,F]=testofsolve(NP,NL,NR,NRR,K,LL);
u=100*u;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%���Ʊ���ͼ��sigmaX��sigamY��sigmaXYӦ��ͼ
U=zeros(NP,2);
sigma=[];
sigmaX=[];
sigmaY=[];
sigmaXY=[];
X0=[];%ÿ����Ԫ4���ڵ����ǰ�ĺ����ꡣ
Y0=[];%ÿ����Ԫ4���ڵ����ǰ�������ꡣ
X=[];%ÿ����Ԫ4���ڵ���κ�ĺ����ꡣ
Y=[];%ÿ����Ԫ4���ڵ���κ�������ꡣ
XXX=[];YYY=[];

for i=1:NP
    U(i,1)=u(2*i-1,1);
    U(i,2)=u(2*i,1);
end%λ�ƾ���

MUU=MP+U;
%�α��ĵ�����


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
    Z=[];
    for j=1:4
        [bb,Z0]=zuobiao(E,v,ME,MP,i,j);
        %�����i����Ԫ�ĵ�j�����D*B������κ�����
        UU=[U(ML,1);U(ML,2);U(MR,1);U(MR,2);U(MT,1);U(MT,2);U(MU,1);U(MU,2)];
        sigma0=bb*UU;
        sigma=[sigma sigma0];
        Z=[Z Z0];
    end
    sigmaX=[sigmaX sigma(1,:)'];
    sigmaY=[sigmaY sigma(2,:)'];
    sigmaXY=[sigmaXY sigma(3,:)'];
    XXX=[XXX Z(1,:)'];
    YYY=[YYY Z(2,:)'];%4����˹�����ꡣ
end
xx0=[X0;X0(1,:)];yy0=[Y0;Y0(1,:)];
xx=[X;X(1,:)];yy=[Y;Y(1,:)];
%�γ���β������

subplot (2,2,1);
plot(xx0,yy0,'b.--');hold on;plot(xx,yy,'r.-');title('����ͼ');
subplot (2,2,2);
patch(XXX,YYY,sigmaX);title('Ӧ��x');
colorbar;%��ʾɫ�ʱ�
shading interp;   %ɫ��ƽ�� 
subplot (2,2,3);
patch(XXX,YYY,sigmaY);title('Ӧ��y');
colorbar;%��ʾɫ�ʱ�
subplot (2,2,4);
patch(XXX,YYY,sigmaXY);title('Ӧ��xy');
colorbar;%��ʾɫ�ʱ�