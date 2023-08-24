function[bb,N]=zuobiao(E,v,ME,MP,i,n)
   

            m1=ME(i,1);  m2=ME(i,2); m3=ME(i,3); m4=ME(i,4);
            x1=MP(m1,1);y1=MP(m1,2);
            x2=MP(m2,1);y2=MP(m2,2);  %节点坐标
            x3=MP(m3,1);y3=MP(m3,2);
            x4=MP(m4,1);y4=MP(m4,2);
          X=[x1;x2;x3;x4]; Y=[y1;y2;y3;y4];
          st=[-1 -1;1 -1;1 1;-1 1];
          % 高斯积分的四个高斯点坐标
          D=E/(1-v^2)*[1 v 0;v 1 0;0 0 (1-v)/2]; % D平面应力
            s=st(n,1);  %依次取4个中第n个高斯点
            t=st(n,2);
          q=[0 1-t t-s s-1;t-1 0 s+1 -s-t;s-t -s-1 0 t+1;1-s s+t -t-1 0];
          J=0.125*(X')*q*Y; % 贾柯比行列式数值的计算
        N1=(1-s)*(1-t)/4;
        N2=(1+s)*(1-t)/4;
        N3=(1+s)*(1+t)/4;
        N4=(1-s)*(1+t)/4;
        N=[N1 0 N2 0 N3 0 N4 0;0 N1 0 N2 0 N3 0 N4];
        
        ns1=(t-1)/4;  nt1=(s-1)/4;
        ns2=(1-t)/4;  nt2=-(1+s)/4;  %四个型函数对 s 与 t 的偏导数
        ns3=(1+t)/4;  nt3=(1+s)/4;
        ns4=-(1+t)/4; nt4=(1-s)/4;
       a=1/4*(y1*(s-1)+y2*(-1-s)+y3*(1+s)+y4*(1-s));
       b=1/4*(y1*(t-1)+y2*(1-t)+y3*(1+t)+y4*(-1-t));
       c=1/4*(x1*(t-1)+x2*(1-t)+x3*(1+t)+x4*(-1-t));
       d=1/4*(x1*(s-1)+x2*(-1-s)+x3*(1+s)+x4*(1-s));
     B1=[a*ns1-b*nt1 0;0 c*nt1-d*ns1;c*nt1-d*ns1 a*ns1-b*nt1];
     B2=[a*ns2-b*nt2 0;0 c*nt2-d*ns2;c*nt2-d*ns2 a*ns2-b*nt2];
     B3=[a*ns3-b*nt3 0;0 c*nt3-d*ns3;c*nt3-d*ns3 a*ns3-b*nt3];
     B4=[a*ns4-b*nt4 0;0 c*nt4-d*ns4;c*nt4-d*ns4 a*ns4-b*nt4];
    B=1/J*[B1 B2 B3 B4];  %  B矩阵的组装
   bb=D*B;
   
    
end