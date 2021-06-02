%Bit dependent bitsets. Percentage corresponds to the likelyhood of switching%

function [bit_dependent_sets] = generate_bit_dependent_bitsets(percent_bit_dependent)

    bit_dependent_sets = [];
    previous = 0;

    temp_bitset = [];
    x = 0;
    for i=1:length(percent_bit_dependent)
        for j = 1:2^13
            x = rand;
            if x < percent_bit_dependent(i)
                if(previous == 1)
                    temp_bitset(j) = 0;
                    previous = 0;
                else
                    temp_bitset(j) = 1;
                    previous = 1;
                end
            else
                temp_bitset(j) = previous;
            end
        end
        bit_dependent_sets = [bit_dependent_sets;temp_bitset];   
    end

end

