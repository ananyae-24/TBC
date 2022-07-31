function Bat_algorithm()
    function res=Func(x)   % function to find maxima for 
        res=-sum(x.^2+25*(sin(x).^2));
    end
    % Initilize every bat
    fmin=0; % minimum frequency
    fmax=2; % maximum frequency
    n=50; % Number of bats
    lb=-4; % lowerbound
    ub=4; % upper bound
    dim=2; % dimentions
    pos=lb+(ub-lb)*rand(dim,n); % Positions of bats Dimention x Number of bats
    velocity=zeros(dim,n); % initilize velocities of each bat
    frequency=fmin+(fmax-fmin)*rand(1,n); % initial frequency of each bat
    r=zeros(1,n); %
    A=ones(1,n); % Amplitude
    alpha=.9; 
    Fitness=zeros(1,n);
    x_=pos(1,:);
    y_=pos(2,:);
    z_=Func(pos);
    scatter(x_,y_,'filled','DisplayName','Initial');
    hold on 
    for ii=1:n
        Fitness(ii)=Func(pos(:,ii));
    end
    [value,I]=max(Fitness); % fing the best solution
    T=10; % Number of iterations
    ii=1; 
    while ii<=T
        for jj=1:n  % Loop to update each bat
            frequency(jj)=fmin+(fmax-fmin)*rand; % Find new frequency
            velocity(:,jj)=velocity(:,jj)+(-pos(:,jj)+pos(:,I))*frequency(jj); % update the velocity
            newpos=pos(:,jj)+velocity(:,jj); % Find new position
            if rand<r(jj) % if r is near 1 then just find local solution near the best solution
                newpos=pos(:,I)+.01*randn(dim,1);
            end
            Fnew=Func(newpos);
            if Fnew>Fitness(jj) && A(jj)>rand % Search only if Fnew is more and Amplitude is high
                pos(:,jj)=newpos; % assign new position
                Fitness(jj)=Fnew; % assign new Fitness values 
                A(jj)=alpha*A(jj); % decrease the Amplitude
                r(jj)=(1-exp(-alpha*ii)); % increaase the r
            end
            if Fnew>=value % Update the best solution
                I=jj;
                value=Fnew;
            end
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

