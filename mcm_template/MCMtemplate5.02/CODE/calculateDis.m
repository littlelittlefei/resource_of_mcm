for i=1:14
    for j=1:14
        a(i,j)=distance(ac(1,j),ac(2,j),ac(1,i),ac(2,i))
    end
end

function d = distance(lat1, lng1, lat2, lng2)
EARTH_RADIUS = 6378.137;
a = lat1*pi/180 - lat2*pi/180;
b = lng1*pi/180 - lng2*pi/180;
d = EARTH_RADIUS*2*asin(sqrt(sin(a/2)^2) + cos(lat1*pi/180)*cos(lat2*pi/180)*sin(b/2)^2);