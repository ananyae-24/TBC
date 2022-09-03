function res=Firefly_algorithm()
    function res=Intensity(x)
        res=-sum(x.^2+25*(sin(x).^2));
    end
    n=50;
    lb=-4;
    ub=4;
    dim=2; 
    pos=lb+(ub-lb)*rand(dim,n); % Positions of fireflies Dimention x Number of fireflies
    x_=pos(1,:);
    y_=pos(2,:);
    z_=Intensity(pos);
    scatter(x_,y_,'filled','DisplayName','Initial');
    hold on 
    T=20; % Number of iterations
    ii=1;
    beta=.5;
    gamma=1;
    alpha=.2;
    theta=.95;
    List_of_ans=zeros(dim,n,T);
    List_of_ans(:,:,1)=pos;
    Fitness=Intensity(pos); % Calculate the intensity
    while ii<=T % Run each step till max iteration is reached
        for jj=1:n
            temp=zeros(dim,1);
            for kk=1:n
                if (Fitness(kk)>Fitness(jj)) % Move the firefly if the other firefly is brighter
                    r_2=sum((pos(:,jj)-pos(:,kk)).^2);
                    temp=temp+beta*exp(-gamma*r_2)*(pos(:,kk)-pos(:,jj));
                end
            end
           pos(:,jj)=pos(:,jj)+temp+alpha*randn(dim,1);% Finally update the overall position of firefly
        end
        Fitness=Intensity(pos);
        List_of_ans(:,:,ii+1)=pos;
        alpha=alpha*theta;
        ii=ii+1;
    end
  %  Visulization of result 
x_=pos(1,:);
y_=pos(2,:);
z_=Intensity(pos);
[val,index]=max(z_);
res=[x_(index),y_(index)];
scatter(x_,y_,'filled','DisplayName','Final');
hold on 
x=-4:.1:4;
y=-4:.1:4;
length=size(x);
length=length(2);
z=zeros(length);
for ii=1:length
    z(ii,:)=Intensity([x(ii)*ones(1,length);y]);
end
% surf(x,y,z)
contour(x,y,-z)
legend({'initial','final'},"Location","southeast")
colorbar('eastoutside')
end

