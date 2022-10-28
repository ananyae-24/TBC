function plot_check(lamda,mu,c1,c2,delta,N)
function res=Intensity(m)
        if m>0
            rho=lamda/mu;
            pi_0=1;
            fact_k=1;
            for j=1:m
                pi_0=pi_0+(rho^j/fact_k);
                fact_k=fact_k*j;
            end
            t1=0;
            prod0=1;
            for j=1:N % change
                prod0=prod0*(m+j*delta/mu);
                t1=t1+((rho^j)/(prod0));
            end
            fact=fact_k;
        %         for j=1:m
        %             fact=fact*j;
        %         end
            pi_0=1/(pi_0+(rho^m)*t1/fact);
            t2=0;
            prod1=1;
            for j=1:N % change
                prod1=prod1*(m+j*delta/mu);
                t2=t2+(j*(rho^j)/(prod1));
            end
            pi_w=delta*(rho^m)*t2*pi_0/(lamda*fact);
            prod2=1;
            for j=1:N
                prod2=prod2*(m+j*delta/mu);
            end
            pi_mn=rho^(m+N)*pi_0/(fact*prod2);
            pi_l= pi_mn*pi_w;
            res=c1*lamda*(1-pi_l)-c2*(m+N);
        else
            res=0;
        end
end
r=[1:1:50];
y=zeros(50,1);
for ii=1:50
    y(ii)=Intensity(r(ii));
end
max(y)
plot(r,y)
end