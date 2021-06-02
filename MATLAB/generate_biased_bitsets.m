function [biased_bitsets] = generate_biased_bitsets(percent_biased)

    biased_bitsets = [];

    temp_bitset = [];
    x = 0;
    for i=1:length(percent_biased)
        for j = 1:2^13
            x = rand;
            if x < percent_biased(i)
                temp_bitset(j) = 0;
            else
                temp_bitset(j) = 1;
            end
        end
        biased_bitsets = [biased_bitsets;temp_bitset];   
    end

end

