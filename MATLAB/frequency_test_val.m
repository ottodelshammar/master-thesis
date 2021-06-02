%Function calculating the min-entropy for the input  bitstrings 
%with the cut of values for The Frequency Test.
function [min_ent_result] = frequency_test_val(biased_bitsets)
    cut_offs_fq = [8193,6644,5314,4110,3006,2060,1118,294];
    min_entropy_values = [0,0.13,0.26,0.39,0.52,0.65,0.78,0.91];
    min_ent_result = [];

    counter_values = [];

    counter = 0;
    %Up down counter
    for i = 1:length(biased_bitsets(:,1))
        for j = 1:2^13
            if biased_bitsets(i,j) == 1
                counter = counter + 1;
            else
                counter = counter - 1;
            end
        end
        counter_values(i) = counter;
        counter = 0;
    end

    %Determine min-entropy based on up-down counter
    for i = 1:length(counter_values)
        for j = length(cut_offs_fq):-1:1
            if abs(counter_values(i)) < cut_offs_fq(j)
                min_ent_result(i) = min_entropy_values(j);
                break;
            end
        
        end
    
    end


    end

