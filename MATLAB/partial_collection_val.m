%Function calculating the min-entropy for the input bitstrings 
%with the cut of values for The Partial Collection Test.
function [min_ent_result] = partial_collection_val(biased_bitsets)

    cut_offs = [-1,693,1186,1543,1792,1957,2056,2103];
    min_entropy_values = [0,0.13,0.26,0.39,0.52,0.65,0.78,0.91];
    min_ent_result = [];

    counter_values = [];
    
    %Count the 2-bit segments with 2 distinct values
    for i = 1:length(biased_bitsets(:,1))
        j = 1;
        counter = 0;
        while (j < (length(biased_bitsets) - 1))
            if biased_bitsets(i,j) ~= biased_bitsets(i,j+1)
                counter = counter + 1;
            end
            j = j + 2;
        end
        counter_values(i) = counter;
    end
    
    
    %Determine the entropy based on cut-offs
    for i = 1:length(counter_values)
        for j = length(cut_offs):-1:1
            if abs(counter_values(i)) > cut_offs(j)
                min_ent_result(i) = min_entropy_values(j);
                break;
            end
        
        end
    
    end
end

