clearvars;
open = 88;
close = 230;
% SETUP FUNCTION
port_num = setup();

% % % Ring Bell
% Create an empty struct to hold the bell data
bellData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);

% Go to above bell
bellData.x(end+1) = 0;
bellData.y(end+1) = -150;
bellData.z(end+1) = 130;
bellData.p(end+1) = 180;
bellData.g(end+1) = open;
bellData.speed(end+1) = 30;

% Go down to bell
bellData(end+1).x = bellData(end).x;
bellData(end).y = bellData(end-1).y;
bellData(end).z = 80;
bellData(end).p = bellData(end-1).p;
bellData(end).g = bellData(end-1).g;
bellData(end).speed = 30;


% Grab bell
bellData(end+1).x = bellData(end).x;
bellData(end).y = bellData(end-1).y;
bellData(end).z = bellData(end-1).z;
bellData(end).p = bellData(end-1).p;
bellData(end).g = close;
bellData(end).speed = 30;

% Pick up bell
bellData(end+1).x = bellData(end).x;
bellData(end).y = bellData(end-1).y;
bellData(end).z = 130; % When it was above pen
bellData(end).p = bellData(end-1).p;
bellData(end).g = bellData(end-1).g;
bellData(end).speed = 20;

% % Ring bell loop - it will just go between 2 poses n times
for i = 1:2
    % Ring bell position 1
    bellData(end+1).x = bellData(end).x;
    bellData(end).y = bellData(end-1).y;
    bellData(end).z = bellData(end-1).z;
    bellData(end).p = 60;
    bellData(end).g = bellData(end-1).g;
    bellData(end).speed = 10;
    
    % Ring bell position 2
    bellData(end+1).x = bellData(end).x;
    bellData(end).y = bellData(end-1).y;
    bellData(end).z = bellData(end-1).z;
    bellData(end).p = 130;
    bellData(end).g = bellData(end-1).g;
    bellData(end).speed = 10;
end
% % End loop

% Put bell down - this puts it back down
bellData(end+1).x = bellData(3).x;
bellData(end).y = bellData(3).y - 4;
bellData(end).z = bellData(3).z+10;
bellData(end).p = 180;
bellData(end).g = bellData(3).g;
bellData(end).speed = 20;

% Release bell
bellData(end+1).x = bellData(end).x;
bellData(end).y = bellData(end-1).y;
bellData(end).z = bellData(end-1).z;
bellData(end).p = bellData(end-1).p;
bellData(end).g = open;
bellData(end).speed = 10;

% Go back above bell
bellData(end+1).x = bellData(end).x;
bellData(end).y = bellData(end-1).y;
bellData(end).z = 160;
bellData(end).p = bellData(end-1).p;
bellData(end).g = bellData(end-1).g;
bellData(end).speed = 20;

disp(bellData)
% % % End of bell
len_x = (bellData(1).y);
disp(len_x);

for i = 1:11
    if i >= 5 && i <=8
        move_joints_no_cubic(bellData(i).p, bellData(i).x, bellData(i).y, bellData(i).z, bellData(i).g, bellData(i).speed, port_num);
        pause(0.3)
    else
        move_cube_task_2(bellData(i).p, bellData(i).x, bellData(i).y, bellData(i).z, bellData(i).g, bellData(i).speed, port_num);
    end
    pause(0.2)
end
% % % Take order
% % % % % % % % % % choice = input('What would you like to order? ' ,
% 's');/
% % % End of Take Order
% % % Pick up pen

% Create an empty struct to hold the pen data
penData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);
close = 215;
% move to pen above
penData(end).x = 0;
penData(end).y = 212;
penData(end).z = 210;
penData(end).p = 90;
penData(end).g = open;
penData(end).speed = 50;

% move to pen actual
penData(end+1).x = penData(end).x;
penData(end).y = penData(end-1).y;
penData(end).z = 120;
penData(end).p = 90;
penData(end).g = open;
penData(end).speed = 30;

% move to pen squeeze
penData(end+1).x = penData(end).x;
penData(end).y = penData(end-1).y;
penData(end).z = 120;
penData(end).p = 90;
penData(end).g = close;
penData(end).speed = 30;

% move to pen after
penData(end+1).x = 0;
penData(end).y = penData(end-1).y;
penData(end).z = 210;
penData(end).p = 90;
penData(end).g = close;
penData(end).speed = 30;

disp(penData)

% % % % End pick up pen
for i = 1:4
    move_cube_task_2(penData(i).p, penData(i).x, penData(i).y, penData(i).z, penData(i).g, penData(i).speed, port_num);
    pause(0.2)
end
%move_array_joints
% % % Write name on cup
name = input('What size tea would you like? ' , 's');

for i=1:length(name)
    name=upper(name);
end
if name == "SMALL"
    lettersData = letters('O');
elseif name == "LARGE"
    name = 'OO';
    lettersData = letters(name);
end
% % % % % % % % % % % % % 
% % % % % % % % % % % % % disp(name)
% % % End write name on cup
% disp(length(lettersData))
for i = 1:length(lettersData)
    if i ==1
        move_cube_task_2(lettersData(i).p, lettersData(i).x, lettersData(i).y, lettersData(i).z, lettersData(i).g, lettersData(i).speed, port_num);
    else
        Linear_with_steps(lettersData(i).p, lettersData(i).x, lettersData(i).y, lettersData(i).z, lettersData(i).g, lettersData(i).speed, lettersData(i-1).x, lettersData(i-1).y, lettersData(i-1).z, port_num);
    end
    pause(0.2)
end
% % % Put down pen

% Create an empty struct to hold the pen data
pen2Data = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);

% Go up with pen

pen2Data(end).x = lettersData(end).x;
pen2Data(end).y = lettersData(end-1).y;
pen2Data(end).z = 210;
pen2Data(end).p = lettersData(end-1).p;
pen2Data(end).g = lettersData(end-1).g;
pen2Data(end).speed = 20;

% Go to above pen
pen2Data(end+1).x = -2;
pen2Data(end).y = 211;
pen2Data(end).z = 210;
pen2Data(end).p = 90;
pen2Data(end).g = close;
pen2Data(end).speed = 30;

% Go down to pen
pen2Data(end+1).x = pen2Data(end).x;
pen2Data(end).y = pen2Data(end-1).y;
pen2Data(end).z = 120;
pen2Data(end).p = pen2Data(end-1).p;
pen2Data(end).g = close;
pen2Data(end).speed = 20;

% Let go of pen2
pen2Data(end+1).x = pen2Data(end).x;
pen2Data(end).y = pen2Data(end-1).y;
pen2Data(end).z = pen2Data(end-1).z;
pen2Data(end).p = pen2Data(end-1).p;
pen2Data(end).g = open;
pen2Data(end).speed = 20;

% Go back up
pen2Data(end+1).x = pen2Data(end).x;
pen2Data(end).y = pen2Data(end-1).y;
pen2Data(end).z = 210;
pen2Data(end).p = pen2Data(end-1).p;
pen2Data(end).g = open;
pen2Data(end).speed = 20;

% % % End put down pen
for i = 1:5
    move_cube_task_2(pen2Data(i).p, pen2Data(i).x, pen2Data(i).y, pen2Data(i).z, pen2Data(i).g, pen2Data(i).speed, port_num);
    pause(0.2)
end
% % % Put cup upright

% Create an empty struct to hold the cup data
cupData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);
close = 145;
% Go to above cup
cupData(end).x = 190;
cupData(end).y = 15;
cupData(end).z = 130;
cupData(end).p = 180;
cupData(end).g = open;
cupData(end).speed = 20;

% Go down to cup
cupData(end+1).x = cupData(end).x;
cupData(end).y = cupData(end-1).y;
cupData(end).z = 20;
cupData(end).p = cupData(end-1).p;
cupData(end).g = cupData(end-1).g;
cupData(end).speed = 20;

% Close gripper
cupData(end+1).x = cupData(end).x;
cupData(end).y = cupData(end-1).y;
cupData(end).z = cupData(end-1).z;
cupData(end).p = cupData(end-1).p;
cupData(end).g = close;
cupData(end).speed = 10;

% Pick up cup
cupData(end+1).x = 160;
cupData(end).y = cupData(end-1).y;
cupData(end).z = 100;
cupData(end).p = cupData(end-1).p;
cupData(end).g = cupData(end-1).g;
cupData(end).speed = 30;

% Rotate cup to be upright
cupData(end+1).x = cupData(end).x;
cupData(end).y = cupData(end-1).y;
cupData(end).z = cupData(end-1).z;
cupData(end).p = 90;
cupData(end).g = cupData(end-1).g;
cupData(end).speed = 30;

% move to position
cupData(end+1).x = 140;
cupData(end).y = -140;
cupData(end).z = 100;
cupData(end).p = cupData(end-1).p;
cupData(end).g = cupData(end-1).g;
cupData(end).speed = 20;

% Gently put cup down
cupData(end+1).x = cupData(end).x;
cupData(end).y = cupData(end-1).y;
cupData(end).z = 35;
cupData(end).p = cupData(end-1).p;
cupData(end).g = cupData(end-1).g;
cupData(end).speed = 60;

% Let go of cup
cupData(end+1).x = cupData(end).x;
cupData(end).y = cupData(end-1).y;
cupData(end).z = cupData(end-1).z;
cupData(end).p = cupData(end-1).p;
cupData(end).g = open;
cupData(end).speed = 20;


% Go back up
cupData(end+1).x = cupData(end).x;
cupData(end).y = cupData(end-1).y;
cupData(end).z = 130;
cupData(end).p = cupData(end-1).p;
cupData(end).g = cupData(end-1).g;
cupData(end).speed = 10;

% % % End put cup upright
%move_array_joints(cupData.p, cupData.x, cupData.y, cupData.z, cupData.g, cupData.speed);
for i = 1:9
    move_cube_task_2(cupData(i).p, cupData(i).x, cupData(i).y, cupData(i).z, cupData(i).g, cupData(i).speed, port_num);
    pause(0.5)
end
% % % Pour kettle into cup
%}
% Create empty arrays for pen data
kettleData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);

close = 170;

% Go above kettle
kettleData(end).x = 150;
kettleData(end).y = 150;
kettleData(end).z = 180;
kettleData(end).p = 90;
kettleData(end).g = open;
kettleData(end).speed = 30;

% Go down to kettle
kettleData(end+1).x = 172;
kettleData(end).y = 176;
kettleData(end).z = 30;
kettleData(end).p = 90;
kettleData(end).g = open;
kettleData(end).speed = 30;

% Pick up kettle
kettleData(end+1).x = kettleData(end).x;
kettleData(end).y = kettleData(end-1).y;
kettleData(end).z = kettleData(end-1).z;
kettleData(end).p = kettleData(end-1).p;
kettleData(end).g = close;
kettleData(end).speed = 20;

% Go up with kettle
kettleData(end+1).x = kettleData(end).x;
kettleData(end).y = kettleData(end-1).y;
kettleData(end).z = 130;
kettleData(end).p = kettleData(end-1).p;
kettleData(end).g = kettleData(end-1).g;
kettleData(end).speed = 20;

% Bring kettle to cup
kettleData(end+1).x = 115;
kettleData(end).y = -115;
kettleData(end).z = 130;
kettleData(end).p = kettleData(end-1).p;
kettleData(end).g = kettleData(end-1).g;
kettleData(end).speed = 30;

% Pour into cup
kettleData(end+1).x = 135;
kettleData(end).y = -135;
kettleData(end).z = 130;
kettleData(end).p = 145;
kettleData(end).g = kettleData(end-1).g;
kettleData(end).speed = 50;

% Go above cup position
kettleData(end+1).x = kettleData(end).x;
kettleData(end).y = kettleData(end-1).y;
kettleData(end).z = 130;
kettleData(end).p = 90;
kettleData(end).g = kettleData(end-1).g;
kettleData(end).speed = 30;

% Bring kettle back to above it starting point
kettleData(end+1).x = 173;
kettleData(end).y = 176;
kettleData(end).z = 130;
kettleData(end).p = 90;
kettleData(end).g = close;
kettleData(end).speed = 30;

% Put kettle down
kettleData(end+1).x = kettleData(end).x;
kettleData(end).y = kettleData(end-1).y;
kettleData(end).z = 30;
kettleData(end).p = kettleData(end-1).p;
kettleData(end).g = kettleData(end-1).g;
kettleData(end).speed = 30;

% Let go of kettle 
kettleData(end+1).x = kettleData(end).x;
kettleData(end).y = kettleData(end-1).y;
kettleData(end).z = kettleData(end-1).z;
kettleData(end).p = kettleData(end-1).p;
kettleData(end).g = open;
kettleData(end).speed = 10;

% GO UP
kettleData(end+1).x = kettleData(end).x;
kettleData(end).y = kettleData(end-1).y;
kettleData(end).z = 130;
kettleData(end).p = kettleData(end-1).p;
kettleData(end).g = open;
kettleData(end).speed = 10;

% % % End pour kettle into cup
for i = 1:11
    disp(i)
    if i >= 5 && i <= 6
        Linear_with_steps(kettleData(i).p, kettleData(i).x, kettleData(i).y, kettleData(i).z, kettleData(i).g, kettleData(i).speed, kettleData(i-1).x, kettleData(i-1).y, kettleData(i-1).z, port_num);
    else
        move_cube_task_2(kettleData(i).p, kettleData(i).x, kettleData(i).y, kettleData(i).z, kettleData(i).g, kettleData(i).speed, port_num);
    end
    
    pause(0.5)
end 

% % % Dunk tea thing into cup
teaData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);
% close = 
% Go to tea thing
teaData(end).x = 10;
teaData(end).y = 80;
teaData(end).z = 130;
teaData(end).p = 180;
teaData(end).g = open;
teaData(end).speed = 30;

% Go down 
teaData(end+1).x = teaData(end).x;
teaData(end).y = teaData(end-1).y;
teaData(end).z = 5;
teaData(end).p = teaData(end-1).p;
teaData(end).g = teaData(end-1).g;
teaData(end).speed = 30;

% Close gripper
teaData(end+1).x = teaData(end).x;
teaData(end).y = teaData(end-1).y;
teaData(end).z = teaData(end-1).z;
teaData(end).p = teaData(end-1).p;
teaData(end).g = close;
teaData(end).speed = 30;

% Cmove to safe position
teaData(end+1).x = 100;
teaData(end).y = 100;
teaData(end).z = teaData(end-1).z;
teaData(end).p = teaData(end-1).p;
teaData(end).g = close;
teaData(end).speed = 30;

% Go up with tea
teaData(end+1).x = teaData(end).x;
teaData(end).y = teaData(end-1).y;
teaData(end).z = 200;
teaData(end).p = teaData(end-1).p;
teaData(end).g = teaData(end-1).g;
teaData(end).speed = 20;

% Go above cup
teaData(end+1).x = 136;
teaData(end).y = -136;
teaData(end).z = teaData(end-1).z;
teaData(end).p = teaData(end-1).p;
teaData(end).g = teaData(end-1).g;
teaData(end).speed = 15;

% % Dunk tea loop
for i = 1:3

    % Go down with tea into cup
    teaData(end+1).x = teaData(end).x;
    teaData(end).y = teaData(end-1).y;
    teaData(end).z = 115;
    teaData(end).p = 90;
    teaData(end).g = teaData(end-1).g;
    teaData(end).speed = 20;
    
    % Go up above tea
    teaData(end+1).x = teaData(end).x;
    teaData(end).y = teaData(end-1).y;
    teaData(end).z = 190;
    teaData(end).p = 90;
    teaData(end).g = teaData(end-1).g;
    teaData(end).speed = 20;
end
% % End loop

% go back up
teaData(end+1).x = teaData(end).x;
teaData(end).y = teaData(end-1).y;
teaData(end).z = 200;
teaData(end).p = teaData(end-1).p;
teaData(end).g = teaData(end-1).g;
teaData(end).speed = 20;

% % % End dunk tea thing into cup
for i = 1:length(teaData)
    disp(i)
    if i >= 6 && i <= 11
        Linear_with_steps(teaData(i).p, teaData(i).x, teaData(i).y, teaData(i).z, teaData(i).g, teaData(i).speed, teaData(i-1).x, teaData(i-1).y, teaData(i-1).z, port_num);
    else
        move_cube_task_2(teaData(i).p, teaData(i).x, teaData(i).y, teaData(i).z, teaData(i).g, teaData(i).speed, port_num);
    end
    if i == 7
        pause(3)
    end
    pause(0.2)
end


% % % THROW tea into bin
throwData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);

% Shift to be in line with bin
throwData(end).x = 140;
throwData(end).y = 0;
throwData(end).z = 130;
throwData(end).p = 180;
throwData(end).g = close;
throwData(end).speed = 30;

% Go back to prepare for throw
throwData(end+1).x = 100;
throwData(end).y = 0;
throwData(end).z = 130;
throwData(end).p = 215;
throwData(end).g = close;
throwData(end).speed = 10;

% Jolt forward and let go of tea bag
throwData(end+1).x = 200;
throwData(end).y = 0;
throwData(end).z = 180;
throwData(end).p = 70;
throwData(end).g = open;
throwData(end).speed = 5;

% % % End of THROW tea into bin
%move_array_joints(throwData.p, throwData.x, throwData.y, throwData.z, throwData.g, throwData.speed);
for i = 1:length(throwData)
    disp(i)
    if i >= length(throwData)
        move_joints_no_cubic(throwData(i).p, throwData(i).x, throwData(i).y, throwData(i).z, throwData(i).g, throwData(i).speed, port_num);
        pause(0.3)
    else
        move_cube_task_2(throwData(i).p, throwData(i).x, throwData(i).y, throwData(i).z, throwData(i).g, throwData(i).speed, port_num);
    end
    pause(0.2)
end

% % % Start stir tea

stirData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);

% Go to above stirrer
stirData(end).x = 100;
stirData(end).y = 100;
stirData(end).z = 130;
stirData(end).p = 180;
stirData(end).g = open;
stirData(end).speed = 20;

% Go down to stirrer
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = 50;
stirData(end).p = stirData(end-1).p;
stirData(end).g = open;
stirData(end).speed = 20;

% Close gripper
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = stirData(end-1).z;
stirData(end).p = stirData(end-1).p;
stirData(end).g = close;
stirData(end).speed = 20;

% Go back up
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = 180;
stirData(end).p = stirData(end-1).p;
stirData(end).g = stirData(end-1).g;
stirData(end).speed = 15;

% Go to above cup
stirData(end+1).x = 150;
stirData(end).y = 0;
stirData(end).z = stirData(end-1).z;
stirData(end).p = stirData(end-1).p;
stirData(end).g = stirData(end-1).g;
stirData(end).speed = 30;

% Stick stirrer into cup
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = 30;
stirData(end).p = stirData(end-1).p;
stirData(end).g = stirData(end-1).g;
stirData(end).speed = 30;

%move_array_joints(stirData.p, stirData.x, stirData.y, stirData.z, stirData.g, stirData.speed);

% % Stir cup loop
for i = 1:3
% Do circle in cup
%     circular_movement(stirData(end-1).p, stirData(end).x, stirData(end-1).y, stirData(end-1).z, stirData(end-1).g, 20, 0, 360);
end
% % End of loop
stirData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);

% % Go up with stirrer
stirData(end).x = 150;
stirData(end).y = 0;
stirData(end).z = 180;
stirData(end).p = 180;
stirData(end).g = 180;
stirData(end).speed = 20;

% Go to stirrer put down location
stirData(end+1).x = 100;
stirData(end).y = 100;
stirData(end).z = stirData(end-1).z;
stirData(end).p = stirData(end-1).p;
stirData(end).g = stirData(end-1).g;
stirData(end).speed = 20;

% Put stirrer down
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = 50;
stirData(end).p = stirData(end-1).p;
stirData(end).g = stirData(end-1).g;
stirData(end).speed = 20;

% Let go of stirrer
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = stirData(end-1).z;
stirData(end).p = stirData(end-1).p;
stirData(end).g = open;
stirData(end).speed = 10;

% Go up
stirData(end+1).x = stirData(end).x;
stirData(end).y = stirData(end-1).y;
stirData(end).z = 130;
stirData(end).p = stirData(end-1).p;
stirData(end).g = stirData(end-1).g ;
stirData(end).speed = 15;
% % % End of stirring
%move_array_joints(stirData.p, stirData.x, stirData.y, stirData.z, stirData.g, stirData.speed);
% RING BELL AGAIN
%}
for i = 1:11
    if i >= 5 && i <=8
        move_joints_no_cubic(bellData(i).p, bellData(i).x, bellData(i).y, bellData(i).z, bellData(i).g, bellData(i).speed, port_num);
        pause(0.3)
    else
        move_cube_task_2(bellData(i).p, bellData(i).x, bellData(i).y, bellData(i).z, bellData(i).g, bellData(i).speed, port_num);
    end
    pause(0.2)
end
% % % Give cup to customer
giveData = struct('x', [], 'y', [], 'z', [], 'p', [], 'g', [], 'speed', []);
close = 150;
% Go to above cup
giveData(end).x = 130;
giveData(end).y = -130;
giveData(end).z = 130;
giveData(end).p = 90;
giveData(end).g = open;
giveData(end).speed = 20;

% Go down to cup
giveData(end+1).x = giveData(end).x;
giveData(end).y = giveData(end-1).y;
giveData(end).z = 25;
giveData(end).p = giveData(end-1).p;
giveData(end).g = giveData(end-1).g;
giveData(end).speed = 20;

% Grab cup
giveData(end+1).x = giveData(end).x;
giveData(end).y = giveData(end-1).y;
giveData(end).z = giveData(end-1).z;
giveData(end).p = giveData(end-1).p;
giveData(end).g = close;
giveData(end).speed = 20;

% Go up with cup
giveData(end+1).x = giveData(end).x;
giveData(end).y = giveData(end-1).y;
giveData(end).z = 130;
giveData(end).p = giveData(end-1).p;
giveData(end).g = giveData(end-1).g;
giveData(end).speed = 20;

% Extend outwards towards person
giveData(end+1).x = 350;
giveData(end).y = 0;
giveData(end).z = giveData(end-1).z;
giveData(end).p = giveData(end-1).p;
giveData(end).g = giveData(end-1).g;
giveData(end).speed = 20;


% Drop cup?
giveData(end+1).x = giveData(end).x;
giveData(end).y = giveData(end-1).y;
giveData(end).z = giveData(end-1).z;
giveData(end).p = giveData(end-1).p;
giveData(end).g = open;
giveData(end).speed = 20;

% % % End give cup
%move_array_joints(giveData.p, giveData.x, giveData.y, giveData.z, giveData.g, giveData.speed);
for i = 1:length(giveData)
        if i == length(giveData)
            for j = 1:10
            disp("--------------------------YOUR TEA IS READY :D--------------------------")

            end
            pause(5)

        end
        move_cube_task_2(giveData(i).p, giveData(i).x, giveData(i).y, giveData(i).z, giveData(i).g, giveData(i).speed, port_num);
    
    pause(0.2)
end





Move_to_Home(port_num);






