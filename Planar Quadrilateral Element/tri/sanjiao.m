function[bb,k]=sanjiao(t,E,v,mm,MP,i)
k=zeros(6,6);
        mi=mm(1,1);  
        mj=mm(1,2);  %��Ԫj,j,k�ڵ�����
        mk=mm(1,3);  
        xi=MP(mi,1);yi=MP(mi,2);
        xj=MP(mj,1);yj=MP(mj,2);  %�ڵ�����
        xk=MP(mk,1);yk=MP(mk,2);
      Bi=yj-yk; Bj=yk-yi; Bk=yi-yj;
      Yi=xk-xj; Yj=xi-xk; Yk=xj-xi;  
    
    A=0.5*(xi*yj-xi*yk+xj*yk-xj*yi+xk*yi-xk*yj);  %��Ԫ���
    
    B=0.5/A*[Bi 0 Bj 0 Bk 0
             0 Yi 0 Yj 0 Yk
             Yi Bi Yj Bj Yk Bk];
   
    D=E/(1-v^2)*[1 v 0;v 1 0;0 0 (1-v)/2]; % Dƽ��Ӧ��
    
 k=t*A*(B')*D*B;
 bb=D*B;

end