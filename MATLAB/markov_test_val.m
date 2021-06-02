
function [min_ent_result] = markov_test_val(bitstrings)

k_vals = [10.9000000000000,5.90000000000000,4.10000000000000,3.30000000000000,2.70000000000000,2.40000000000000,2.10000000000000,-30.9000000000000,-10.5000000000000,-7.20000000000000,-8.20000000000000,-9.90000000000000,-13.7000000000000,-26.8000000000000];
m_vals = [-3685.60000000000,-3899.60000000000,-3971.40000000000,-4015.50000000000,-4030.70000000000,-4043.10000000000,-4074.60000000000,67354.4000000000,25094.1000000000,18748,23531.7000000000,30992.4000000000,47099.1000000000,100679.100000000];


min_entropy_values = [0,0.13,0.26,0.39,0.52,0.65,0.78,0.91];

    for i = 1:length(bitstrings(:,1))
        
        counter_abs = 0;
        counter_01 = 0;
        for j = 1:length(bitstrings(1,:))-1
            if bitstrings(i, j) == 0
                counter_abs = counter_abs+1;
            else
                counter_abs = counter_abs-1;
            end
            if bitstrings(i, j) == 0 && bitstrings(i, j+1) == 1
                counter_01 = counter_01 +1;
            end
        end
        counter_abs = abs(counter_abs);
        
        min_ent = min_entropy_values(8); %% If no match set highest value
        
        if counter_abs - m_vals(1) > counter_01*k_vals(1)
            min_ent = min_entropy_values(1);
        elseif counter_abs - m_vals(2) > counter_01*k_vals(2)
            min_ent = min_entropy_values(2);
        elseif counter_abs - m_vals(3) > counter_01*k_vals(3)
            min_ent = min_entropy_values(3);
        elseif counter_abs - m_vals(4) > counter_01*k_vals(4)
            min_ent = min_entropy_values(4);
        elseif counter_abs - m_vals(5) > counter_01*k_vals(5)
            min_ent = min_entropy_values(5);
        elseif counter_abs - m_vals(6) > counter_01*k_vals(6)
            min_ent = min_entropy_values(6);
            
        elseif counter_abs - m_vals(14) > counter_01*k_vals(14)
            min_ent = min_entropy_values(1);
        elseif counter_abs - m_vals(13) > counter_01*k_vals(13)
            min_ent = min_entropy_values(2);
        elseif counter_abs - m_vals(12) > counter_01*k_vals(12)
            min_ent = min_entropy_values(3);
        elseif counter_abs - m_vals(11) > counter_01*k_vals(11)
            min_ent = min_entropy_values(4);
        elseif counter_abs - m_vals(10) > counter_01*k_vals(10)
            min_ent = min_entropy_values(5);
        elseif counter_abs - m_vals(9) > counter_01*k_vals(9)
            min_ent = min_entropy_values(6);
        elseif counter_abs - m_vals(8) > counter_01*k_vals(8)
            min_ent = min_entropy_values(7);
        elseif counter_abs - m_vals(7) > counter_01*k_vals(7)
            min_ent = min_entropy_values(7);
        end
        min_ent_result(i) = min_ent;
    end
end

