% Define a 3x3x3x3 tensor Cijkl (for simplicity, using random values)
%{
%Cijkl = rand(3,3,3,3);

% Initialize the 9x9 matrix
C = zeros(9,9);
C11=225
C12=153
C44=115

% Map tensor to matrix
C = zeros(9,9);  % Initialize a 9x9 zero matrix
for i = 1:3
    for j = 1:3
        for k = 1:3
            for l = 1:3
                row_index = 3*(i-1) + j;
                col_index = 3*(k-1) + l;
                C(row_index, col_index) = Cijkl(i, j, k, l);
            end
        end
    end
end

% Normal stresses
for i = 1:3
    for j = 1:3
        % Mapping tensor (i,i,j,j)
        index_ii_jj = 3*(i-1) + j;
        C(index_ii_jj, index_ii_jj) = C11;
    end
end

% Shear and cross-coupling
for i = 1:3
    for j = 1:3
        if i ~= j
            % Shear components (i,j,i,j)
            index_ij_ij = 3*(i-1) + j;
            index_ji_ji = 3*(j-1) + i;
            C(index_ij_ij, index_ji_ji) = C44;  % Shear components are filled here
            C(index_ji_ji, index_ij_ij) = C44;  % Ensuring symmetry
        end
        
        for k = 1:3
            for l = 1:3
                if i ~= k || j ~= l
                    index_ij_kl = 3*(i-1) + j;
                    index_kl_ij = 3*(k-1) + l;
                    
                    % Cross coupling components (i,j,k,l)
                    if i == j && k == l
                        C(index_ij_kl, index_kl_ij) = C12;
                    elseif i == k && j == l
                        C(index_ij_kl, index_kl_ij) = C12;
                    end
                end
            end
        end
    end
end
%}
%function C = generateCubicStiffnessMatrix()
    % Elastic constants for cubic symmetry
    C11 = 168;  % Normal stiffness
    C12 = 121;  % Coupling between normal stresses
    C44 = 75;   % Shear stiffness

    % Initialize the 9x9 stiffness matrix
    C = zeros(9,9);

    % Fill in the matrix according to the rules for cubic symmetry
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    row_index = 3*(i-1) + j;
                    col_index = 3*(k-1) + l;

                    % Normal components
                    if i == k && j == l
                        C(row_index, col_index) = C11;
                    end

                    % Shear components
                    if i == l && j == k && i ~= j
                        C(row_index, col_index) = C44;
                    end

                    % Coupling components
                    if i == j && k == l && i ~= k
                        C(row_index, col_index) = C12;
                    end
                end
            end
        end
    end

    % Display the matrix
    disp(C);
