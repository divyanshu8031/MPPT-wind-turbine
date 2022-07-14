clc
clear all
ro=1.22;
R=20;
A=pi*R^2;
V=2;
w=0:0.1:10;
B=0;
for j=1:7
    
     L=w.*R./V;
    Li=((B.^3+1).*(L+0.08.*B))./((B.^3+1)-(0.035.*(L+0.08.*B)));
    Cp=0.5176.*((((116./Li)-(0.6.*B)-5).*exp(-21./Li))+0.0068*L);
    Pm=0.5.*Cp.*ro.*A.*V.^3;
    
    i=4;
    dP=0;
    dP_old=0;
    while sign(dP*dP_old)>=0
        dP=Pm(1,i)-Pm(1,i-1);
        dP_old=Pm(1,i-1)-Pm(1,i-2);
    if dP>0
       if (w(1,i)-w(1,i-1))>0
        i=i+1;
       else
        i=i-1;
       end
    end
    if dP<0
        if (w(1,i)-w(1,i-1))>0
        i=i-1;
       else
        i=i+1;
       end
    end
   end
  V=V+2;
  Pmpp=Pm(1,i);
  wm=w(1,i);
  MPP(j,2)=Pmpp;
  MPP(j,1)=wm;
  plot(w,Pm,'linewidth',1.5)
  ylim([0 1200000])
  hold on
  plot (wm,Pmpp,'ro','linewidth',2)
  hold on
  if j==7
      line(MPP(:,1),MPP(:,2),'linewidth',1.3)
  end
end