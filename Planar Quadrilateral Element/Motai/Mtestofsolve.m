function[w,d]=Mtestofsolve(NP,NR,NRR,K,M,nub)
%�����������������/�ı��ε�Ԫ��ѧ����
%NP:�ڵ���
%NR��λ��Լ������
%NRR��λ��Լ������
%K���ܸնȾ���
%M:��������
%nub:��Ƶ����Ҫ����

NF=3;
%һ���ڵ�����ɶ�

NDF=NF*NP;%ά��

for i=1:NR
    f=NRR(i,1);
    
    if NRR(i,2)==0
         K(f,:)=0;
         K(:,f)=0;
         K(f,f)=1;
         
         M(f,:)=0;
         M(:,f)=0;
    
    end%����ն����������
    
end

syms d w ww dd

[dd,ww]=eig(K,M);

w=zeros(nub,1);

d=zeros(NDF,nub);


for i=1:nub
    w(i,1)=(ww(i,i))^0.5;
    d(:,i)= dd(:,i);
end

%w=[w1;w2;w3]  Ƶ��
%d=[d1;d2;d3]  �ڵ�ģ̬
%d1=[u1;v1;u2;v2] һ��Ƶ�ʵĽڵ�ģ̬

end