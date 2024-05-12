% 2.1: Transform6*6
function K= transform_six_by_six(phi_1, phi, phi_2)
%converting  degree to radian
%matlab don't understand degree mode and neither transform it radian automaticly
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

%Rotation Matrix
R =[ c1*c3-s1*s3*c2    s1*c3+c1*s3*c2    s3*s2;
   -c1*s3-s1*c3*c2   -s1*s3+c1*c3*c2    c3*s2;
         s1*s2            -c1*s2           c2  ];
disp('Rotaiton matrix(euler_bunge) R is:');
disp(R);

% Construct the 6x6 transformation matrix T from R
K = zeros(6,6); %initialization of K
%we can use that mod functin mentioned in that reading matterial

K(1,1) = R(1,1)^2;
K(1,2) = R(1,2)^2;
K(1,3) = R(1,3)^2;
K(1,4) = 2*R(1,2)*R(1,3);
K(1,5) = 2*R(1,1)*R(1,3);
K(1,6) = 2*R(1,1)*R(1,2);

K(2,1) = R(2,1)^2;
K(2,2) = R(2,2)^2;
K(2,3) = R(2,3)^2;
K(2,4) = 2*R(2,2)*R(2,3);
K(2,5) = 2*R(2,1)*R(2,3);
K(2,6) = 2*R(2,1)*R(2,2);

K(3,1) = R(3,1)^2;
K(3,2) = R(3,2)^2;
K(3,3) = R(3,3)^2;
K(3,4) = 2*R(3,2)*R(3,3);
K(3,5) = 2*R(3,1)*R(3,3);
K(3,6) = 2*R(3,1)*R(3,2);

K(4,1) = R(2,1)*R(3,1);
K(4,2) = R(2,2)*R(3,2);
K(4,3) = R(2,3)*R(3,3);
K(4,4) = R(2,2)*R(3,3) + R(2,3)*R(3,2);
K(4,5) = R(2,1)*R(3,3) + R(2,3)*R(3,1);
K(4,6) = R(2,1)*R(3,2) + R(2,2)*R(3,1);

K(5,1) = R(1,1)*R(3,1);
K(5,2) = R(1,2)*R(3,2);
K(5,3) = R(1,3)*R(3,3);
K(5,4) = R(1,2)*R(3,3) + R(1,3)*R(3,2);
K(5,5) = R(1,1)*R(3,3) + R(1,3)*R(3,1);
K(5,6) = R(1,1)*R(3,2) + R(1,2)*R(3,1);

K(6,1) = R(1,1)*R(2,1);
K(6,2) = R(1,2)*R(2,2);
K(6,3) = R(1,3)*R(2,3);
K(6,4) = R(1,2)*R(2,3) + R(1,3)*R(2,2);
K(6,5) = R(1,1)*R(2,3) + R(1,3)*R(2,1);
K(6,6) = R(1,1)*R(2,2) + R(1,2)*R(2,1);

%displaying the transformatino matrix
disp('Transformation matrix K is:');
%disp(K);