function[u,F]=testofsolve(NP,NL,NR,NRR,K,LL)
%�����������������/�ı��ε�Ԫ����ѧ����
%NP:�ڵ���
%NL����֪�غ���
%NR��λ��Լ������
%NRR��λ��Լ������
%K���ܸնȾ���
%LL:��֪�غ���Ϣ������

NF=2;
%һ���ڵ�����ɶ�

NDF=NF*NP;%ά��

P=zeros(NDF,1);%����������

for i=1:NL
    P(LL(i,1))=LL(i,2);
end%д���غ�

q=0;

for i=1:NR
    if NRR(i,2)~=0
        for i=1:NDF
            for j=1:NDF
                   o=abs(K(i,j));
                   if q<=o
                       q=o;
                   end
            end
        end
    end
end

%�ж��Ƿ���Ҫ���ɴ���
        
aa=q*10^4;
%�ԽǴ����Ĵ���
        

Z=K;%��������ն���


for i=1:NR
    f=NRR(i,1);
    
    if NRR(i,2)==0
         K(f,:)=0;
         K(:,f)=0;
         K(f,f)=1;
    else
          K(f,f)=aa*K(f,f);
    end%�ԽǴ�����
    
end

for i=1:NR
    f=NRR(i,1);
    
    if NRR(i,2)==0
        P(f)=0;
    else
    P(f)=K(f,f)*NRR(i,2);
    end
   
end%�ԽǴ�����������

u=K^(-1)*P;%λ������

F=Z*u;%������

end



