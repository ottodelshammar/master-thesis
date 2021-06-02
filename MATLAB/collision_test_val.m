%Function calculating the min-entropy for the input  bitstrings 
%with the cut of values for The Collision Test.
    
function [min_ent_result] = collision_test_val(bitstrings)

    cut_offs = [-1,658,1046,1304,1476,1584,1648,1678];
    min_entropy_values = [0,0.13,0.26,0.39,0.52,0.65,0.78,0.91];
    min_ent_result = [];

    counter_values = [];
    
    %Count the 3 bit segments
    for i = 1:length(bitstrings(:,1)) 
        j = 1;
        counter = 0;
        l = 0;
        while (j < (length(bitstrings) - 1))
            if bitstrings(i,j) == bitstrings(i,j+1)
                l = 2;
            else
                counter = counter + 1;
                l = 3;
            end
            j = j + l;
        end
        counter_values(i) = counter;
    end
    
    
    for i = 1:length(counter_values)
        for j = length(cut_offs):-1:1
            if abs(counter_values(i)) > cut_offs(j)
                min_ent_result(i) = min_entropy_values(j);
                break;
            end
        
        end
    
    end

end

