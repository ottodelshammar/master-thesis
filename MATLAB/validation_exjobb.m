%This script is used to validate our cut-off values for different tests
%


percent_biased = (0:0.05:1);

biased_bitsets = generate_biased_bitsets(percent_biased);


%------------Generate Hmin theoretical line----------------------------%
x_min = (0:0.05:1);
y = [];

for i = 1:length(x_min)
    
    x_temp = max(x_min(i),1-x_min(i)); 
    y(i) = -log2(x_temp);
    
end

%--------------Calculate min value 100 times for each test--------------%

min_entropy_partial = [];
min_entropy_collision = [];
min_entropy_fq = [];
min_entropy_markov = [];

for i = 1:100
    biased_bitsets = generate_biased_bitsets(percent_biased);
    min_entropy_partial = [min_entropy_partial;partial_collection_val(biased_bitsets)];
    min_entropy_collision = [min_entropy_collision;collision_test_val(biased_bitsets)];
    min_entropy_fq = [min_entropy_fq;frequency_test_val(biased_bitsets)];   
    min_entropy_markov = [min_entropy_markov;markov_test_val(biased_bitsets)];
end


figure(1);
plot(percent_biased * 100, mean(min_entropy_fq),'*',x_min*100,y,'-'),...
%title('The Most Common Value Estimate'),...
xlabel('P(0)[%]'),...
ylabel('Hmin'),...
set(gca, 'FontSize', 15);


figure(2);
plot(percent_biased * 100,mean(min_entropy_collision),'*',x_min*100,y,'-'),...
%title('The Collison Estimate'),...
xlabel('P(0)[%]'),...
ylabel('Hmin'),...
set(gca, 'FontSize', 15);


figure(3);
plot(percent_biased * 100,mean(min_entropy_partial),'*',x_min*100,y,'-'),...
%title('The Partial Collection Test'),...
xlabel('P(0)[%]'),...
ylabel('Hmin'),...
set(gca, 'FontSize', 15);

figure(4);
plot(percent_biased * 100,mean(min_entropy_markov),'*',x_min*100,y,'-'),...
%title('The Markov Test'),...
xlabel('P(0)[%]'),...
ylabel('Hmin'),...
set(gca, 'FontSize', 15);

