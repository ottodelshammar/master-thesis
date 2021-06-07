%----------------------Plotting Theoretical Hmin------------------------%

x = (0:0.01:1); % p between 0 and 1
y = [];

for i = 1:length(x)
    x_temp = max(x(i),1-x(i)); 
    y(i) = -log2(x_temp);
    
end

 figure(1);
 plot(x,y),...
 xlabel('p'),...
 ylabel('H');

%-----------------------Partial Collection test--------------------------%
n = 2;
v = 2^12;

sumT1 = (2^12:2^13); %Sum T_i

sumT2 = (2^12:3:2^14); %Sum T_i^2

my = sumT1/v;

omega = sqrt((sumT2./v)-my.^2);

my_st = my - (1.96*omega)/sqrt(v);

p_plus = 0.5 + sqrt((3-2*my_st)/4);

h_min_p = -log2(real(p_plus));

figure(2);

plot(sumT1,h_min_p),...
xlabel('sumT1'),...
ylabel('p');


%------------------------Frequency test-------------------------------%

N = 2^13;
C_ovfl = (0:2:2^13); 

C_max = N/2 + C_ovfl/2;

p_hat = C_max/N;

p_u = min(1,p_hat + 2.576 * sqrt(p_hat.*(1-p_hat)/(N-1)));

h_min = -log2(p_u);

figure(3);

plot(C_ovfl,h_min),...
xlabel('C_{ovfl}'),...
ylabel('H_{min}');


%------------------------Collision test---------------------%

i = 1;
val = 2^12;
tv = 2^12*4;
while(v > 2730) %2^13/3
    v(i) = val;
    sumtvSq(i) =  tv;
    i=i+1;
    if(mod(i,2) == 0)
        val = val-1;
        tv = tv+5;
    else
        tv = tv+1;
    end
end

fliplr(v);

sumtv = 2^13;
ZALPHA = 2.576;

Xmean = sumtv./v; % X is mean value here
s = real(sqrt((sumtvSq - (sumtv.*Xmean))./(v-1)));
Xlow = Xmean - ZALPHA.*s/sqrt(v); % X is recalulated to lowerbound confidence interval
p = real(0.5 + sqrt(1.25 - 0.5.*Xlow));
hmin = -log2(p);

