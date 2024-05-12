clc; clearvars;
%euler_bunge convention
%taking three consecutive rotaion angle from user
phi_1 =input('Enter the phi_1 value: ');
phi = input('Enter the phi value: ');
phi_2 =input('Enter the phi_2 value: ');

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
c3=cos(t1);  

s1=sin(t1);
s2=sin(t2);
s3=sin(t3);

%Rotation Matrix
R =[ c1*c3-s1*s3*c2    s1*c3+c1*s3*c2    s3*s2;
   -c1*s2-s1*c3*c2   -s1*s3+c1*c3*c2    c3*s2;
         s1*s2            -c1*s2           c2  ]

 
     
     