% move to start %
x_start = 4   *25;
y_start = 0   *25;
z_start = 100;
pose_start = 180;

% move to pen %
x_p = 0   *25;
y_p = 0   *25;
z_p = 0;
pose_p = 180;

% before 1st line %
x_1 = 5   *25;
y_1 = 5   *25;
z_1 = 60;
pose_1 = 180;

% end of 1st line %
x_2 = 5   *25;
y_2 = -1   *25;
z_2 = z_1;
pose_2 = pose_1;

% end of 2nd line %
x_3 = 2   *25;
y_3 = -1   *25;
z_3 = z_1;
pose_3 = pose_1;

% end of 3rd line (diagonal before circle) %
x_4 = 4   *25;
y_4 = -3   *25;
z_4 = z_1;
pose_4 = pose_1;

% end of circle %
x_5 = 4   *25;
y_5 = -5   *25;
z_5 = z_1;
pose_5 = pose_1;



% code %
pose = [180, 180, 180];
x = [100, 125, 125];
y = [0, 125, -25];
z = [100, 63, 63];
% gripper = [];


% pose = [pose_start, pose_p, pose_1,pose_2,pose_3,pose_4,pose_5];
% x = [x_start,x_p,x_1,x_2,x_3,x_4,x_5];
% y = [y_start, y_p, y_1, y_2, y_3, y_4, y_5];
% z = [z_start, z_p, z_1, z_2, z_3, z_4, z_5];


Move_to_Start(pose(1), x(1), y(1), z(1));

Linear_Movement(pose, x, y, z);

Move_to_Home();







