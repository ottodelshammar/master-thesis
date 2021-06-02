%--------------------Markov Test--------------------%

% C_10 = C_01
% C_0 + C_1 = N
% C_01 + C_00 = C_0
% C_11 + C_10 = C1
% C_01 <= min(C_0, C_1)
% C01 = C10 = N/2 - C_abs/2 (negative for the minor value)

N = 2^13;
C_0 = 0:1:2^13;
C_1 = 2^13 - C_0;

C_abs = abs(C_1-C_0);
C_01 = N/2 - C_abs/2;

w = waitbar(0,'Please wait...');

for i = 1:1:2^12+1 %range C_abs halfway
    for j = 1:1:C_01(i)+1
        
        C0 = C_0(i);
        C1 = C_1(i);
        C01 = C_01(j);
        C10 = C01;
        C00 = C0 - C01;
        C11 = C1 - C10;
        
        if C0 > 0
            P00 = C00/C0;
            P01 = 1 - P00;
        else
            P00 = 0;
            P01 = 0;
        end
        
        if C1 > 0
            P10 = C10/C1;
            P11 = 1 - P10;
        else
            P10 = 0;
            P11 = 0;
        end
        
        P0 = C0/N;
        P1 = 1 - P0;
        
        H_min(i,j) = 128;
        
        %Find min entropy
        if P00 > 0
            tmp_min_ent = -log2(P0) - 127*log2(P00);
            if tmp_min_ent < H_min(i,j)
                H_min(i,j) = tmp_min_ent;
            end
        end
        
        if P01 > 0 && P10 > 0
            tmp_min_ent = -log2(P0) - 64*log2(P01) - 63*log2(P10);
            if tmp_min_ent < H_min(i,j)
                H_min(i,j) = tmp_min_ent;
            end
        end
        
        if P01 > 0 && P11 > 0
            tmp_min_ent = -log2(P0) - log2(P01) - 126*log2(P11);
            if tmp_min_ent < H_min(i,j)
                H_min(i,j) = tmp_min_ent;
            end
        end
        
        if P10 > 0 && P00 > 0
            tmp_min_ent = -log2(P1) - log2(P10) - 126*log2(P00);
            if tmp_min_ent < H_min(i,j)
                H_min(i,j) = tmp_min_ent;
            end
        end
        
        if P10 > 0 && P01 > 0
            tmp_min_ent = -log2(P1) - 64*log2(P10) - 63*log2(P01);
            if tmp_min_ent < H_min(i,j)
                H_min(i,j) = tmp_min_ent;
            end
        end
        
        if P11 > 0
            tmp_min_ent = -log2(P1) - 127*log2(P11);
            if tmp_min_ent < H_min(i,j)
                H_min(i,j) = tmp_min_ent;
            end
        end
        
        H_min(i,j) = min(H_min(i,j)/128, 1);
        
        %Create segments in heatmap
        if H_min(i,j) < 0.13, H_min(i,j) = 0;
            else if H_min(i,j) < 0.26, H_min(i,j) = 0.13;
                else if H_min(i,j) < 0.39, H_min(i,j) = 0.26;
                        else if H_min(i,j) < 0.52, H_min(i,j) = 0.39;
                                else if H_min(i,j) < 0.65, H_min(i,j) = 0.52;
                                        else if H_min(i,j) < 0.78, H_min(i,j) = 0.65;
                                                else if H_min(i,j) < 0.91, H_min(i,j) = 0.78;
                                                    else H_min(i,j) = 0.91;
                                                    end
                                            end
                                    end
                            end
                    end
            end
        end
    end
    
    waitbar(i/(2^12+1), w, 'Processing');
end

close(w)

clf;
figure(1)
h = heatmap(H_min, 'GridVisible', 'Off', 'CellLabelColor','none');
h.XDisplayLabels = nan(size(h.XDisplayData));
h.YDisplayLabels = nan(size(h.YDisplayData));
xlabel("C_01")
ylabel("C_abs")
set(gca, 'FontSize', 15);

%Caclulate index lower breakpoints
p = 0;
for i = 1:1:4097-1
    if H_min(4097,i) ~= H_min(4097,i+1)
        p = p+1;
        if p < 8
        C01_vals(2,p)=i+1;
        else
        C01_vals(2,p)=i;
        end
        Cabs_vals(2,p)=4097;
    end
end

% Index for upper breakpoints - manually read
C01_vals(1,1) = 652; Cabs_vals(1,1) = 652;
C01_vals(1,2) = 1162; Cabs_vals(1,2) = 1162;
C01_vals(1,3) = 1572; Cabs_vals(1,3) = 1572;
C01_vals(1,4) = 1907; Cabs_vals(1,4) = 1907;
C01_vals(1,5) = 2185; Cabs_vals(1,5) = 2185;
C01_vals(1,6) = 2264; Cabs_vals(1,6) = 2784;
C01_vals(1,7) = 2164; Cabs_vals(1,7) = 3572;
C01_vals(1,8) = 2164; Cabs_vals(1,8) = 3572;
C01_vals(1,9) = 2264; Cabs_vals(1,9) = 2784;
C01_vals(1,10) = 2376; Cabs_vals(1,10) = 2377;
C01_vals(1,11) = 2693; Cabs_vals(1,11) = 2692;
C01_vals(1,12) = 3029; Cabs_vals(1,12) = 3030;
C01_vals(1,13) = 3383; Cabs_vals(1,13) = 3384;
C01_vals(1,14) = 3748; Cabs_vals(1,14) = 3749;

figure(2); % plot all graphs and calculate k and m vals
C01_vals = [652,1162,1572,1907,2185,2264,2164,2164,2264,2376,2693,3029,3383,3748;337,663,961,1234,1482,1709,1917,2181,2389,2616,2864,3137,3435,3761];
Cabs_vals = [652,1162,1572,1907,2185,2784,3572,3572,2784,2377,2692,3030,3384,3749;4097,4097,4097,4097,4097,4097,4097,4097,4097,4097,4097,4097,4097,4097];

for i = 1:14
Cabs_vals(2,i) = Cabs_vals(2,i)-4097; % Flip to adapt index/axes
Cabs_vals(1,i) = Cabs_vals(1,i)-4097;

C01_vals(2,i) = -C01_vals(2,i); % Flip to adapt index/axes
C01_vals(1,i) = -C01_vals(1,i);

k = (Cabs_vals(2,i)-Cabs_vals(1,i))/(C01_vals(2,i)-C01_vals(1,i)); % gradient
m = k*C01_vals(1,i)-Cabs_vals(1,i); % constant

K_vals_shift4(i) = round(k*16); %shift binary value three steps for VHDL implementation
M_vals_shift4(i) = round(m*16);

K_vals(i) = k; %save values
M_vals(i) = m;

x = 0:1:4096;
y = k*x+m; %multiply by two, to change from index to abs_val

legends(i) = "Line " + i;
plot(x,y)
hold on
end

legends(i+1) = "Diagonal";
plot(0:4096,4096:-1:0) %Diagonal
hold on
legend(legends);
ylim([0 2^12])
xlim([0 2^12])
xlabel("C_{01}")
ylabel("C_{abs}")
%set(gca, 'FontSize', 15);