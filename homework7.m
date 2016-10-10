% Phero, Kelsey, Adam R21
% ENGR 16, M, W, 6:00-7:50
% Kovacs
% 10/10/16
% 


clc
clear
close all

% This lets the whole thing allows you to loop the program
repeat ='y';
while (repeat =='y');
    
% Asks the user to pull which file and error checks
filename=input('Please enter a filename ', 's');

while (exist(filename) == 0 )
   filename = input('Please enter a real file ' , 's'); 
end

% This gets the names for the X and Y Axis along with the title
xAxis = input('Please input a X Axis title ' , 's');
yAxis = input('Please input a Y Axis title ' , 's');
top = input('Please input a Title ' , 's');

% loads the file and puts the numbers into 'file'
data=load(filename);

% Basically checks to see how the data is stored and puts it accordingly
[rows,cols]=size(data);
if (cols > rows);
    transpose(data);
    x = data(1,:);
    y = data(2, :);
else
x=data(:,1);
y=data(:,2); 
end

% Just a switch case with a menu to choose the color for the plot
colorChoice = menu('Please select a color', 'blue', 'green', 'red', 'cyan', 'magenta' , 'yellow', 'black', 'white');
switch colorChoice
    case 1
        colorChoice = 'b';
    case 2 
        colorChoice = 'g';
    case 3
        colorChoice = 'r';
    case 4
        colorChoice = 'c';
    case 5
        colorChoice = 'm';
    case 6 
        colorChoice = 'y';
    case 7
        colorChoice = 'k';
    case 8
        colorChoice = 'w';
    otherwise
        colorChoice = 'k';     
end

% A menu and switch case to choose a symbol for the plot
symbolChoice = menu('Please select a symbol', '.' , 'o' , 'x' , '+', '*', 's' , 'd');
switch symbolChoice;
    case 1
        symbolChoice = '.';
    case 2
        symbolChoice = 'o';
    case 3
        symbolChoice = 'x';
    case 4
        symbolChoice = '+';
    case 5
        symbolChoice = '*';
    case 6
        symbolChoice = 'S';
    case 7
        symbolChoice = 'd';
    otherwise
        symbolChoice = 'o';
end

% This plots the first set of data
subplot(1,2,1)
plot(x , y , [colorChoice, symbolChoice])
xlabel(xAxis)
ylabel(yAxis)
title(top)

disp('A pause has occured, press a key to continue to line of best fit')
pause


% This asks the user to see how they would like to calculate line of best
% fit
lineChoice = menu('How would you like to calculate line of best fit?','Linear','Polynomial','Spline','Semi-log', 'Log-Log');

switch lineChoice
    case 1
        lineChoice = 'l';
    case 2 
        lineChoice = 'p';
    case 3
        lineChoice = 's';
    case 4
        lineChoice = 'e';
    case 5 
        lineChoice = 'o';
    otherwise
        lineChoice = 'p';
end




% this is used if they click the log log button on the menu
if(lineChoice =='o')
    
    
%     This is used to filter out zeros in both x and y, j is a counter
%     variable
    xfilter=[];
    yfilter=[];
    j=1;
    
    for q = 1:length(x);
        if( x(q) > 0 && y(q) > 0)
            xfilter(j) = y(q);
            yfilter(j) = x(q);
            
           j=j+1;
        end
    end
     
%     converting the new filtered numbers into log numbers
    logvaluey = log(yfilter);
    logvaluex = log(xfilter);
    
%     This gets the coefficient for the line of best fits in coeffll and
%     then calculates new y values into newyll
    coeffll = polyfit(logvaluex,logvaluey,1);
    newyll = polyval(coeffll,logvaluex); 
    
       %    gets the color for the line of best fit
       color = menu('Please select a color for the line of best fit', 'blue', 'green', 'red', 'cyan', 'magenta' , 'yellow', 'black', 'white');

switch color
    case 1
        color = 'b';
    case 2 
        color = 'g';
    case 3
        color = 'r';
    case 4
        color = 'c';
    case 5
        color = 'm';
    case 6 
        color = 'y';
    case 7
        color = 'k';
    case 8
        color = 'w';
    otherwise
        color = 'k';
        
end

% Chooses a symbol
    symbolChoicep = menu('Please select a symbol', 'point' , 'circle' , 'x-mark' , 'plus', 'star', 'square' , 'diamond','triangle down','triangle up', 'triangle left', 'triangle right', 'pentagram','hexagram');
switch symbolChoicep;
    case 1
        symbolChoicep = '.';
    case 2
        symbolChoicep = 'o';
    case 3
        symbolChoicep = 'x';
    case 4
        symbolChoicep = '+';
    case 5
        symbolChoicep = '*';
    case 6
        symbolChoicep = 's';
    case 7
        symbolChoicep = 'd';
    case 8
        symbolChoicep = 'v';
    case 9
        symbolChoicep = '^';
    case 10
        symbolChoicep = '<';
    case 11
        symbolChoicep = '>';
    case 12
        symbolChoicep = 'p';
    case 13
        symbolChoicep = 'h';
    otherwise
        symbolChoicep = 'o';
end
    
% Chooses the line type if any
    lineChoicep = menu('If you desire, select a line type', 'solid','dotted','dashdot','dashed','no line');
    
    switch lineChoicep;
        case 1 
            lineChoicep = '-';
        case 2
            lineChoicep = ':';
        case 3
            lineChoicep = '-.';
        case 4 
            lineChoicep = '--';
        case 5
            lineChoicep = '';
        otherwise 
            lineChoicep = '';
    
    end
%     combines all the choices above to one variable
    tripleChoice= [color,symbolChoicep,lineChoicep];
    
%     plots the log log graph
    subplot(1,2,2)
    plot(logvaluex,logvaluey,[colorChoice,symbolChoice],logvaluex,newyll,tripleChoice)

    absErrorll = abs(logvaluey-newyll);
    [absell,locall] = max(absErrorll);
    disp(['The maximum absolute error is :' ,num2str(absell)])
    disp(['The x coordinate is :', num2str(xfilter(locall))])
    
%     This filter is used to find any values of 'logvaluey' is equal to y
%     and ignores those numbers by putting it into filter2
    xfilter2=[];
    yfilter2=[];
    k=1;
    for i = 1:length(logvaluey);
        if(logvaluey(i) ~= 0 );
            yfilter2(k) = logvaluey(i);
            xfilter2(k) = logvaluex(i);
            k = k+1;
        end
    end
    
%     calculates the new coefficients of line of best fit into coefffilter
%     and gets new y values along with it to find.
    coefffilter = polyfit(xfilter2,yfilter2,1);
    newyll2 = polyval(coefffilter,xfilter2);
    
%     we use the numbers that we got just above to find the relative error
    relErrorll = abs(yfilter2-newyll2)./yfilter2;
    [relell, locrll] = max(relErrorll);
    disp(['The maximum absolute error is :', num2str(relell)])
    disp(['The x coordinate is :', num2str(xfilter2(locrll))])
        
%     prints out line of best fit
   gtext(['Ln(y)= ',num2str(coeffll(1)),'x + ',num2str(coeffll(2))]) 
    
%    This is used to find the rsquared value and prints it out afterwards
    SSE = 0;
    SST = 0;
    
    for p = 1:length(logvaluey)
        SSE = SSE + (logvaluey(p)-newyll(p))^2;
        SST = SST + (logvaluey(p)- mean(logvaluey))^2;
    end
    rval = 1 - (SSE/SST);
    gtext(['r^2 = ',num2str(rval)])
    
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%         % %           % %     % % % % %     % %           % 
%   % % % % %   % % % % % %   %   % % %   %   % % % %   % % % 
%   % % % % %   % % % % % %   % %   %   % %   % % % %   % % %
%         % %           % %   % % %   % % %   % % % %   % % % 
% % % %   % %   % % % % % %   % % % % % % %   % % % %   % % % 
% % % %   % %   % % % % % %   % % % % % % %   % % % %   % % % 
%         % %           % %   % % % % % % %   % %           %
% % % % % % % % % % % % % % % % % % % % % %   % % % % % % % %
% This is used when they click the semi log option
if (lineChoice =='e')
    
    xfilter=[];
    yfilter=[];
    j=1;
    
    for k = 1:length(y)
        if (y(k) > 0)
            yfilter(j)=y(k);
            xfilter(j)=x(k);
            j=j+1;
        end
    end
    
    
   logvaluey=log(yfilter);
   
%    puts the coefficients of the line into coeffsl
   coeffsl = polyfit(xfilter,logvaluey,1);
   newysl = polyval(coeffsl,xfilter);
   
   
   
   %    gets the color for the line of best fit
       color = menu('Please select a color for the line of best fit', 'blue', 'green', 'red', 'cyan', 'magenta' , 'yellow', 'black', 'white');

switch color
    case 1
        color = 'b';
    case 2 
        color = 'g';
    case 3
        color = 'r';
    case 4
        color = 'c';
    case 5
        color = 'm';
    case 6 
        color = 'y';
    case 7
        color = 'k';
    case 8
        color = 'w';
    otherwise
        color = 'k';
        
end

% Chooses a symbol
    symbolChoicep = menu('Please select a symbol', 'point' , 'circle' , 'x-mark' , 'plus', 'star', 'square' , 'diamond','triangle down','triangle up', 'triangle left', 'triangle right', 'pentagram','hexagram');
switch symbolChoicep;
    case 1
        symbolChoicep = '.';
    case 2
        symbolChoicep = 'o';
    case 3
        symbolChoicep = 'x';
    case 4
        symbolChoicep = '+';
    case 5
        symbolChoicep = '*';
    case 6
        symbolChoicep = 's';
    case 7
        symbolChoicep = 'd';
    case 8
        symbolChoicep = 'v';
    case 9
        symbolChoicep = '^';
    case 10
        symbolChoicep = '<';
    case 11
        symbolChoicep = '>';
    case 12
        symbolChoicep = 'p';
    case 13
        symbolChoicep = 'h';
    otherwise
        symbolChoicep = 'o';
end
    
% Chooses the line type if any
    lineChoicep = menu('If you desire, select a line type', 'solid','dotted','dashdot','dashed','no line');
    
    switch lineChoicep;
        case 1 
            lineChoicep = '-';
        case 2
            lineChoicep = ':';
        case 3
            lineChoicep = '-.';
        case 4 
            lineChoicep = '--';
        case 5
            lineChoicep = '';
        otherwise 
            lineChoicep = '';
    
    end
%     combines all the choices above to one variable
    tripleChoice= [color,symbolChoicep,lineChoicep];
    
%     plots the semilog with filtered x values and the new calculated y
%     values which are in log form
   subplot(1,2,2);
    plot(xfilter,logvaluey,[colorChoice,symbolChoice] ,xfilter,newysl, tripleChoice);
    title('This is the semilogplot');
    
    
%     finds the absolute error and then finds the max and location and
%     prints it out afterwards
    absErrorsl = abs(logvaluey-newysl);
    [absErrorsly,locmsl] = max(absErrorsl);
    disp(['The maximum absolute error is: ',num2str(absErrorsly)])
    disp(['With the x coordinate of: ',num2str(xfilter(locmsl))])
    
%     finds the relative error and then finds the max witht he location and
%     prints it out
    relErrorsl = abs(logvaluey-newysl)./logvaluey;
    [relErrorsly,locrsl] = max(relErrorsl);
    disp(['The maximum relative error is: ' , num2str(relErrorsly)])
    disp(['With the x coordinate of: ', num2str(xfilter(locrsl))])
    
%     prints out the equation of the line onto the graph
    gtext(['Ln(y) = ',num2str(coeffsl(1)),'x + ',num2str(coeffsl(2))])
    
     
%     calculates the rsquared value of the new equation calculated and then
%     prints it out onto the graph
    SSE = 0;
    SST = 0;
    
    for z = 1:length(yfilter);
       SSE = SSE + ((logvaluey(z) - newysl(z)))^2;
       SST = SST + ((logvaluey(z) - mean(logvaluey)))^2 ;
    end
    
    rval= 1 -(SSE/SST);
    gtext(['r^2 = ' , num2str(rval)])
    
end


% This is used if they click the spline option
if (lineChoice =='s')
%     coeffsp sets up getting the data for spline
%     xnewsp makes the new x values for a smoother line
%     ynewsp calculates the y values
   coeffsp = spline(x,y);
   xnewsp = linspace(min(x),max(x),400);
   ynewsp = ppval(coeffsp,xnewsp);
   
   
%    gets the color for the line of best fit
       color = menu('Please select a color for the line of best fit', 'blue', 'green', 'red', 'cyan', 'magenta' , 'yellow', 'black', 'white');

switch color
    case 1
        color = 'b';
    case 2 
        color = 'g';
    case 3
        color = 'r';
    case 4
        color = 'c';
    case 5
        color = 'm';
    case 6 
        color = 'y';
    case 7
        color = 'k';
    case 8
        color = 'w';
    otherwise
        color = 'k';
        
end

% Chooses a symbol
    symbolChoicep = menu('Please select a symbol', 'point' , 'circle' , 'x-mark' , 'plus', 'star', 'square' , 'diamond','triangle down','triangle up', 'triangle left', 'triangle right', 'pentagram','hexagram');
switch symbolChoicep;
    case 1
        symbolChoicep = '.';
    case 2
        symbolChoicep = 'o';
    case 3
        symbolChoicep = 'x';
    case 4
        symbolChoicep = '+';
    case 5
        symbolChoicep = '*';
    case 6
        symbolChoicep = 's';
    case 7
        symbolChoicep = 'd';
    case 8
        symbolChoicep = 'v';
    case 9
        symbolChoicep = '^';
    case 10
        symbolChoicep = '<';
    case 11
        symbolChoicep = '>';
    case 12
        symbolChoicep = 'p';
    case 13
        symbolChoicep = 'h';
    otherwise
        symbolChoicep = 'o';
end
    
% Chooses the line type if any
    lineChoicep = menu('If you desire, select a line type', 'solid','dotted','dashdot','dashed','no line');
    
    switch lineChoicep;
        case 1 
            lineChoicep = '-';
        case 2
            lineChoicep = ':';
        case 3
            lineChoicep = '-.';
        case 4 
            lineChoicep = '--';
        case 5
            lineChoicep = '';
        otherwise 
            lineChoicep = '';
    
    end
%     combines all the choices above to one variable
    tripleChoice= [color,symbolChoicep,lineChoicep];
   
%     plots the original data and the spline graph
    subplot(1,2,2)
     plot(x , y , [colorChoice, symbolChoice],xnewsp,ynewsp, tripleChoice)
end




% This is the start to find the line of best fit for polynomials
if (lineChoice == 'p')
    
%     asking for the degree and error checking it
    degree = input('Please enter the degree of the line ');
    
    while (degree >= (length(data)-1))
        degree = input('Please enter a better degree ');
    end
    
%     Chooses the color of the line of best fit
    color = menu('Please select a color for the line of best fit', 'blue', 'green', 'red', 'cyan', 'magenta' , 'yellow', 'black', 'white');

switch color
    case 1
        color = 'b';
    case 2 
        color = 'g';
    case 3
        color = 'r';
    case 4
        color = 'c';
    case 5
        color = 'm';
    case 6 
        color = 'y';
    case 7
        color = 'k';
    case 8
        color = 'w';
    otherwise
        color = 'k';
        
end

% Chooses a symbol
    symbolChoicep = menu('Please select a symbol', 'point' , 'circle' , 'x-mark' , 'plus', 'star', 'square' , 'diamond','triangle down','triangle up', 'triangle left', 'triangle right', 'pentagram','hexagram');
switch symbolChoicep;
    case 1
        symbolChoicep = '.';
    case 2
        symbolChoicep = 'o';
    case 3
        symbolChoicep = 'x';
    case 4
        symbolChoicep = '+';
    case 5
        symbolChoicep = '*';
    case 6
        symbolChoicep = 's';
    case 7
        symbolChoicep = 'd';
    case 8
        symbolChoicep = 'v';
    case 9
        symbolChoicep = '^';
    case 10
        symbolChoicep = '<';
    case 11
        symbolChoicep = '>';
    case 12
        symbolChoicep = 'p';
    case 13
        symbolChoicep = 'h';
    otherwise
        symbolChoicep = 'o';
end
    
% Chooses the line type if any
    lineChoicep = menu('If you desire, select a line type', 'solid','dotted','dashdot','dashed','no line');
    
    switch lineChoicep;
        case 1 
            lineChoicep = '-';
        case 2
            lineChoicep = ':';
        case 3
            lineChoicep = '-.';
        case 4 
            lineChoicep = '--';
        case 5
            lineChoicep = '';
        otherwise 
            lineChoicep = '';
    
    end
%     combines all the choices above to one variable
    tripleChoice= [color,symbolChoicep,lineChoicep];
       
%     coeffp stands for coefficients of polynomials
    coeffp = polyfit(x,y,degree);
%     calculates the new y values to plot
    newyp = polyval(coeffp,x);
    
%     plots the old data and the line of best fit together
    subplot (1,2,2)
    plot(x , y , [colorChoice, symbolChoice],x,newyp, tripleChoice)
    
%     calculates and displays absolute error then finds the max and puts it
%     into absep
    absErrorp = abs(y-newyp);
    [absep,locm] = max(absErrorp);
    disp(['The max absolute error is ',num2str(absep)])
    disp(['The x location is :',num2str(x(locm))])
    
%     This filters for any bad relative errors
    xfilt=[];
    yfilt=[];
    j=1;
 for k = 1:length(x);
     if ( y(k) ~=0);
         yfilt(j)=y(k);
         xfilt(j)=x(k);
         j = j+1;       
     end
 end
 
% this is used to calculate new values for the relative error
 coeffp1 = polyfit(xfilt,yfilt,degree);
 newyp1 = polyval(coeffp1,xfilt);
 
    
%     calculates the relative error in puts in into relErrorp and then
%     finds the max of that and puts it into relep and displays it and the
%     x location
    relErrorp = abs(yfilt-newyp1)./yfilt;
    [relep,loc] = max(relErrorp);
    disp(['The max relative error is ', num2str(relep)])
    disp(['With the x coordinate of ', num2str(xfilter(loc))])
end


        
%         This is for the linear option
        if (lineChoice == 'l')
    
            % A switch case and menu to choose the color for line of beset fit
color = menu('Please select a color', 'blue', 'green', 'red', 'cyan', 'magenta' , 'yellow', 'black', 'white');

switch color
    case 1
        color = 'b';
    case 2 
        color = 'g';
    case 3
        color = 'r';
    case 4
        color = 'c';
    case 5
        color = 'm';
    case 6 
        color = 'y';
    case 7
        color = 'k';
    case 8
        color = 'w';
    otherwise
        color = 'k';
        
end
  
            
% This set is used for calculating the slope and y intercept of Line of
% best fit
n=length(x);
sumX = 0;
sumY = 0;

xsqrd = 0;
xy = 0;

for i = 1:length(x);
    sumX = sumX + x(i);
    sumY = sumY + y(i);
    
    xsqrd = xsqrd + (x(i))^2;
    xy = xy + x(i)*y(i);
    
end
    
A = [sumX , n ; xsqrd , sumX];
B = [sumY ; xy];
    
% This gives the slope ; y intercept
coeff = inv(A)*B;
    
% Is the equation of the line
newY = coeff(1)*x + coeff(2);
    

%     Plots both the first graph and line of best fit
    subplot(1,2,2)
    plot(x,y,[colorChoice,symbolChoice],x,newY,color)
    xlabel(xAxis)
    ylabel(yAxis)
    title(top)

%     This is used to sort out if there are any bad numbers for Y(Y=0) and
%     finds out which specific data point is bad
%     the bad point is then set to keeper
    keeper=0;
    for t = 1:length(y);
    if (y(t) == 0);
           keeper = t;
    end
    end
    
%     If there was a number that needs to be ignored, we use ind to find
%     which data set needs to be deleted and then resets y and x
%     accordingly. It then calculates relative error and abs error

    if (keeper ~= 0);
      ind = [keeper];
       y(ind) = [];
       x(ind) = [];
       filtery = coeff(1)*x + coeff(2);
       relError = abs(y-filtery./y);
       absError = (y-filtery);

    else
%         If there are no bad data points, it will do this normally

            relError = abs(y-newY)./y;
            absError = (y-newY);
    end
    
    
    
%     This is used to find out which is the max absolute error along with
%     the x coordinate and then displays it
    absE = absError(1);
    absp = 0;
    for k = 1:length(y+1);
        if (absError(k) > absE);
            absE = absError(k);
            absp = x(k);
        end
    end
    
    disp(['The absolute max error is : ' , num2str(absE)])
    disp(['With the x coordinate of : ', num2str(absp)])
    
    
%     I used count as a way to cycle through the array. This then is is
%     used to find out if there is a max relative and then displays it
 count = 1;
 relE = (relError(1));
 relP = x(1);
 while (count <= length(y));
     
     if (relE < relError(count));
         
         relE = relError(count);
         relP = x(count);
     end
     count = count + 1;
 end

 disp(['The max relative error is ' , num2str(relE)])
 disp(['The x coordinate of it is ' , num2str(relP)])
 
    
% All of this is used to find r^2
    SSE = 0;
    SST = 0;
    
for j=1:length(y);
    SSE = SSE + (y(j)-newY(j))^2;
    SST = SST + (y(j)-mean(y))^2;
    
    
end
r2=(1-(SSE/SST));
disp(['The r^2 value is : ' , num2str(r2)])
disp('Please click to place equation' )
gtext(['y = ', num2str(coeff(1)), '*x +', num2str(coeff(2))])
disp('Please click to place the r-squared value ' )
gtext(['r^','2 =', num2str(r2)])

% This is used to calculate a y value from a user input.
xEst = input('Enter a value to make an estimate of ');
yEst = coeff(1)*xEst + coeff(2);
disp(['Your estimated Y value is :' , num2str(yEst)])


% allows the looping of the program
    repeat = input('Would you like to enter a new file to get new data? y/n', 's');
    repeat=lower(repeat(1));
    
    while (repeat ~='y' && repeat ~='n');
        repeat = input('Please enter y/n for a new file');
        repeat = lower(repeat(1));
    
    end
        end
end
