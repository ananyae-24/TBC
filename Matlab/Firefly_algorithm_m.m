function Firefly_algorithm_m(lamda,mu,r,c)
    function res=Intensity(m)
        l_mu=lamda/mu;
        t=1;
        fact=1;
        for j=1:m
            fact=fact*j;
            t=t+(l_mu^j/fact);
        end
        res=(r*l_mu*(1-(l_mu)^m/(fact*t)))-c*m;
    end
    n=20;
    lb=0;
    ub=150;
    dim=1; 
    pos=randi([lb,ub],1,n); % Positions of fireflies Dimention x Number of fireflies
    T=50; % Number of iterations
    ii=1;
    beta=.2;
    gamma=1/100;
    alpha=.5;
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
                    r_2=(pos(jj)-pos(kk))^2;
                    
                    temp=temp+beta*exp(-gamma*r_2)*(pos(kk)-pos(jj)); %exp(-gamma*r_2)*
                end
            end
           temp
           s=1/(1+exp(-(temp+alpha*(rand(1)-.5))));
           increment=0;
           
           s
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
[v,idx]=max(Fitness);
title('Line Plot of current maximum Vs iterations')
xlabel('Number of iteration') 
ylabel('current maximum')
legend({"Global optimum"},'Location','southeast')
pos(idx)
v

%plot(pos,zeros(1,n))
end

