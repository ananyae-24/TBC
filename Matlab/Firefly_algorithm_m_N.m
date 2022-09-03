function Firefly_algorithm_m_N(lamda,mu,c1,c2,delta,N)
    function res=Intensity(m)
        rho=lamda/mu;
        pi_0=1;
        fact_k=1;
        for j=1:m
            pi_0=pi_0+(rho^j/fact_k);
            fact_k=fact_k*j;
        end
        t1=0;
        prod0=1;
        for j=1:m+N
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
        for j=1:m+N
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
    end
    n=40;
    lb=0;
    ub=200;
    dim=1; 
    pos=randi([lb,ub],1,n); % Positions of fireflies Dimention x Number of fireflies
    T=150; % Number of iterations
    ii=1;
    beta=.2;
    gamma=1;
    alpha=.2;
    theta=1;
    Fitness=zeros(n,1);
    Best_Fitness=zeros(T+1,1);
    for jj=1:n % Calculate the intensity
        Fitness(jj)=Intensity(pos(jj));
    end
    Best_Fitness(1)=max(Fitness);
    while ii<=T % Run each step till max iteration is reached
        for jj=1:n
            temp=0;
            for kk=1:n
                if (Fitness(kk)>Fitness(jj)) % Move the firefly if the other firefly is brighter
                    r_2=abs(pos(jj)-pos(kk))^2;
                    
                    temp=temp+beta*(1/(1+gamma*r_2))*(pos(kk)-pos(jj)); %exp(-gamma*r_2)*
                end
            end
           %temp
           s=1/(1+exp(-(temp+alpha*(randn(1)))));
           increment=0;
           
           %s
           if .55<s 
               increment=1;
           elseif s<.45
               increment=-1;
           else
               increment=0;
           end
         
           pos(jj)= pos(jj)+increment;% Finally update the overall position of firefly
           Fitness(jj)=Intensity(pos(jj));
        end
        Best_Fitness(ii+1)=max(Fitness);
        alpha=alpha*theta;
        ii=ii+1;
    end
plot(1:T+1,Best_Fitness)
title('Line Plot of current maximum Vs iterations')
xlabel('Number of iteration') 
ylabel('current maximum')
legend({'Global optimum'},'Location','southeast')
[v,idx]=max(Fitness);
pos(idx)
v

%plot(pos,zeros(1,n))
end

