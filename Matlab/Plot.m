function Plot()
    x=-2*pi:.1:2*pi;
    y=-2*pi:.1:2*pi;
    z=eggcrate(x,y);
    surf(x,y,z)
end
