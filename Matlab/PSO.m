function PSO()
    function res=Func(x)   % function to find maxima for 
        res=-sum(x.^2+25*(sin(x).^2));
    end
    n=50; % Number of particles
    lb=-4; % lowerbound
    ub=4; % upper bound
    dim=2; % dimentions
    pos=lb+(ub-lb)*rand(dim,n); % Positions of bats Dimention x Number of particles
    velocity=zeros(dim,n); % initilize velocities of each particles
    alpha=1.5;
    beta=1.5;
    theta=.75;
    x_=pos(1,:);
    y_=pos(2,:);
    z_=Func(pos);
    scatter(x_,y_,'filled','DisplayName','Initial');
    hold on 
    T=10; %Number of iterations
    Fitness=Func(pos);
    [value,I]=max(Fitness);
    historical_best=pos;
    ii=1;
    while ii<=T
        for jj=1:n
            velocity(:,jj)=theta*velocity(:,jj)+rand*alpha*(historical_best(:,jj)-pos(:,jj))+rand*beta*(pos(:,I)-pos(:,jj));
            newpos=pos(:,jj)+velocity(:,jj);
            Fnew=Func(newpos);
            if Fnew>=Fitness(jj)
                historical_best(:,jj)=newpos;
            end
            if Fnew>=value
                I=jj;
                value=Fnew;
            end
            pos(:,jj)=newpos;
            Fitness(jj)=Fnew;
        end
        ii=ii+1;
    end
x_=pos(1,:);
y_=pos(2,:);
z_=Func(pos);
scatter(x_,y_,'filled','DisplayName','Final');
hold on 
x=-4:.1:4;
y=-4:.1:4;
length=size(x);
length=length(2);
z=zeros(length);
for ii=1:length
    z(ii,:)=Func([x(ii)*ones(1,length);y]);
end
% surf(x,y,z)
contour(x,y,z)
legend
end
