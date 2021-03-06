% X = [x, y, z, vx, vy, vz, q0, q1, q2, q3, gx_bias, gy_bias, gz_bias, az_bias]
X = [0; 0; 0; 0; 0; 0; 1; 0; 0; 0; 0; 0; 0; 0];
X = single(X);
% U = [gx, gy, gz, ax, ay, az]
U = [0; 0; 0; 0; 0; 0];
U = single(U);
% Z = [x, y, z, vx, vy, vz, ax, ay, az, mx, my]
Z = [0; 0; 0; 0; 0; 0; 0; 0; -1; 1; 0];
Z = single(Z);
% observer delay in ms
Delay = [120; 120; 10; 120; 120; 20; 10; 10; 10; 10; 0; 0; 0; 0;];
HistIndex = Delay/double(LogHeader.log_perid);

NUM_X = length(X);
NUM_Z = length(Z);
NUM_W = 10;
F = zeros(NUM_X, NUM_X);
H = zeros(NUM_Z, NUM_X);
G = zeros(NUM_X, NUM_W);
P = zeros(NUM_X, NUM_X);
Q = zeros(NUM_W, NUM_W);
R = zeros(NUM_Z, NUM_Z);
I = eye(NUM_X, NUM_X);
% change to single type
F = single(F);
H = single(H);
G = single(G);
P = single(P);
Q = single(Q);
R = single(R);
I = single(I);
% init Q
Q(1,1) = q_gx^2;
Q(2,2) = q_gy^2;
Q(3,3) = q_gz^2;
Q(4,4) = q_ax^2;
Q(5,5) = q_ay^2;
Q(6,6) = q_az^2;
Q(7,7) = q_gx_bias^2;
Q(8,8) = q_gy_bias^2;
Q(9,9) = q_gz_bias^2;
Q(10,10) = q_az_bias^2;
% init R
R(1,1) = r_x^2;
R(2,2) = r_y^2;
R(3,3) = r_z^2;
R(4,4) = r_vx^2;
R(5,5) = r_vy^2;
R(6,6) = r_vz^2;
R(7,7) = r_ax^2;
R(8,8) = r_ay^2;
R(9,9) = r_az^2;
R(10,10) = r_mx^2;
R(11,11) = r_my^2;
% init P
P(1,1) = 1;
P(2,2) = 1;
P(3,3) = 1;
P(4,4) = 0.2;
P(5,5) = 0.2;
P(6,6) = 0.2;
P(7,7) = 1e-5;
P(8,8) = 1e-5;
P(9,9) = 1e-5;
P(10,10) = 1e-5;
P(11,11) = 1e-9;
P(12,12) = 1e-9;
P(13,13) = 1e-9;
P(14,14) = 1e-8;
% init state
X(ID_Q0) = LogField(1,qw_col);
X(ID_Q1) = LogField(1,qx_col);
X(ID_Q2) = LogField(1,qy_col);
X(ID_Q3) = LogField(1,qz_col);
X(ID_X) = LogField(1,gps_x_col);
X(ID_Y) = LogField(1,gps_y_col);
X(ID_Z) = LogField(1,baro_z_col);
X(ID_VX) = LogField(1,gps_vx_col);
X(ID_VY) = LogField(1,gps_vy_col);
X(ID_VZ) = LogField(1,baro_vz_col);