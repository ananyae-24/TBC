function res=eggcrate(x,y)
    res=x'*x+y'*y+25*(sin(x)'*sin(x)+sin(y)'*sin(y));
end