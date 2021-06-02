%This script is used to validate our cut-off values for different tests
%


percent_bit_dependent = (0:0.05:1);

bit_dependent = generate_bit_dependent_bitsets(percent_bit_dependent);


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
    bit_dependent = generate_bit_dependent_bitsets(percent_bit_dependent);
    min_entropy_partial = [min_entropy_partial;partial_collection_val(bit_dependent)];
    min_entropy_collision = [min_entropy_collision;collision_test_val(bit_dependent)];
    min_entropy_fq = [min_entropy_fq;frequency_test_val(bit_dependent)];
    min_entropy_markov = [min_entropy_markov; markov_test_val(bit_dependent)];
end


figure(1);
plot(percent_bit_dependent * 100, mean(min_entropy_fq),'*',x_min*100,y,'-'),...
%title('The Most Common Value Estimate'),...
xlabel('P(switch)[%]'),...
ylabel('Hmin');
set(gca, 'FontSize', 15);


figure(2);
plot(percent_bit_dependent * 100,mean(min_entropy_collision),'*',x_min*100,y,'-'),...
%title('The Collison Estimate'),...
xlabel('P(switch)[%]'),...
ylabel('Hmin');
set(gca, 'FontSize', 15);


figure(3);
plot(percent_bit_dependent * 100,mean(min_entropy_partial),'*',x_min*100,y,'-'),...
%title('The Partial Collection Test'),...
xlabel('P(switch)[%]'),...
ylabel('Hmin'),...
set(gca, 'FontSize', 15);

figure(4);
plot(percent_bit_dependent * 100,mean(min_entropy_markov),'*',x_min*100,y,'-'),...
%title('The Markov Test'),...
xlabel('P(switch)[%]'),...
ylabel('Hmin'),...
set(gca, 'FontSize', 15);