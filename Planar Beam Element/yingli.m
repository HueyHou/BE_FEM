function[MN]=yingli(NE,mm,NP,MP,F);

syms y o
M=zeros(NP,1);
for n=1:NP
    M(n,1)=F(3*n,1)+M(n,1);%����������е����
end
M
F
ME=mm;
ML=mm(1,1);  %��Ԫ���ڵ�����
      MR=mm(1,2);  %��Ԫ�Ҳ�ڵ�����
    DX=MP(MR,1)-MP(ML,1);  %detX
    DY=MP(MR,2)-MP(ML,2);  %detY
  L=(DX^2+DY^2)^0.5;  %����ÿ����Ԫ�ĳ���
  a=atan(DY/DX);  %��Ԫ�ĽǶȣ������ƣ�
MN=ones(NE,1);%����Ӧ������

MN=y*MN;


syms x;
if a==0%ˮƽ��
   c=0.15;
   I=6*10^-5;
   for i=4:6%4��6�Ÿ�
       m=M(ME(i,1),1)*x/L+M(ME(i,2),1)*(L-x)/L;%��Ԫ��ÿ�����
       o=m*c/I;%����Ӧ����ʽ
       MN(i:1)=o;
   end
   for i=10:12
       m=M(ME(i,1),1)*x/L+M(ME(i,2),1)*(L-x)/L;
       o=m*c/I;
       MN(i:1)=o;
   end
end
if a~=0
   c=0.125;
   I=4*10^-5;
   for i=1:3
       m=M(ME(i,1),1)*x/L+M(ME(i,2),1)*(L-x)/L;
       o=m*c/I;
       MN(i:1)=o;
   end
   for i=7:9
       m=M(ME(i,1),1)*x/L+M(ME(i,2),1)*(L-x)/L;
       o=m*c/I;
       MN(i:1)=o;
   end
   for i=13:15
       m=M(ME(i,1),1)*x/L+M(ME(i,2),1)*(L-x)/L;
       o=m*c/I;
       MN(i:1)=o;
   end
end
y=0;
MN=subs(MN)
end