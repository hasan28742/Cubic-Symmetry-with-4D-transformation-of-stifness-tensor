 clc
 clearvars
%euler_bunge convention
%taking three consecutive rotaion angle from user
phi_1 =input('Enter the phi_1 value: ');
phi = input('Enter the phi value: ');
phi_2 =input('Enter the phi_2 value: ');

%Getting the cubic symmetric stiffness matrix matrix or Cu
disp('Three Co-efficient of cubic symmetric stiffness matrix matrix of Cu:');
C11 =input('Enter the C11 value: ');
C12 = input('Enter the C12 value: ');
C44 =input('Enter the C44 value: ');

%converting  degree to radian
%matlab don't understand degree mode and neither transform it radian
%automaticly
t1=phi_1*pi/180;  
t2=phi*pi/180;  
t3=phi_2*pi/180;  

%converting trichonomitric angle to suitable formet
%assuming c1,c2,c3, s1,s2,s3 respectively for smooth coding

c1=cos(t1);  
c2=cos(t2);  
c3=cos(t3);  

s1=sin(t1);
s2=sin(t2);
s3=sin(t3);

%Rotation Matrix(3*3)
R =[ c1*c3-s1*s3*c2    s1*c3+c1*s3*c2    s3*s2;
   -c1*s3-s1*c3*c2   -s1*s3+c1*c3*c2    c3*s2;
         s1*s2            -c1*s2           c2  ];
%%creating the material stifness matrix (3*3*3*3) in reference configuration
% Initialize the 4D tensor
C_ref = zeros(3, 3, 3, 3);

    % Populate the tensor according to cubic symmetry rules
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    if i == k && j == l && i == j %c1111
                        C_ref(i, j, k, l) =C_ref(i,j,k,l)+ C11;  % Normal terms along axes
                    elseif i == k && j == l
                        C_ref(i, j, k, l) =C_ref(i,j,k,l)+ C44;  % Shear terms on plane normals
                    elseif i == j && k == l && i ~= k %this will eliminate c1111 from this
                        C_ref(i, j, k, l) =C_ref(i,j,k,l) + C12;  % Coupling between different axes c1122
                    end
                end
            end
        end
    end
    
 
 
%%creating transformation matrix T(3*3*3*3*3*3*3*3) total 8D
%initialize the new Transformation matrix which will be generated from roation matrix
T = zeros(3, 3, 3, 3, 3, 3, 3, 3);
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    for m = 1:3
                        for n = 1:3
                            for o = 1:3
                                for p = 1:3
                                    T(i, j, k, l, m, n, o, p) =  R(i, m) * R(j, n) * R(k, o) * R(l, p);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
%{    
%initialize the new material stifness matrix. for compatable with the code lets assume the it C
C=zeros(3,3,3,3); %4d matrix

% Apply the transformation tensor T to rotate the stiffness tensor C
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    for m = 1:3
                        for n = 1:3
                            for o = 1:3
                                for p = 1:3
                                    C(i, j, k, l) = C(i, j, k, l) + T(i, j, k, l, m, n, o, p) * C(m, n, o, p);
                                        
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    %}
    % Initialize the rotated stiffness tensor C
C = zeros(3, 3, 3, 3);

% Apply the transformation tensor T to rotate the stiffness tensor C_ref
for i = 1:3
    for j = 1:3
        for k = 1:3
            for l = 1:3
                sum = 0; % Initialize sum for the contraction
                for m = 1:3
                    for n = 1:3
                        for o = 1:3
                            for p = 1:3
                                sum = sum + T(i, j, k, l, m, n, o, p) * C_ref(m, n, o, p);
                            end
                        end
                    end
                end
                C(i, j, k, l) = sum; % Assign the computed value to the rotated tensor
            end
        end
    end
end

R
C_ref
C
    

 

