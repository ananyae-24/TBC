function Eggcrate_plot()
function res=F(x)
        res=sum(x.^2+25*(sin(x).^2));
end
x=-6:.1:6;
y=-6:.1:6;
length=size(x);
length=length(2);
z=zeros(length);
for ii=1:length
    z(ii,:)=F([x(ii)*ones(1,length);y]);
end
surf(x,y,z)
title('Eggcrate function ')
xlabel('-6 < x < 6') 
ylabel('-6 < y < 6') 
zlabel('z') 

end