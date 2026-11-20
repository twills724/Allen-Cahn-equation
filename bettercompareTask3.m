function [errorFE,errorSI] = compareTask3()
% Load the results from Task 1
load('task1_data.mat','x','utime','utimeback','T','eps');
% Use the wave speed
c = 3*eps/sqrt(2);
% Exact solution
uExact = 0.5*(1-tanh((x-c*T)/(2*sqrt(2)*eps)));

% Make all vectors column vectors
x = x(:);
uExact = uExact(:);
utime = utime(:,end);
utimeback = utimeback(:,end);

% Maximum absolute errors
errorFE = max(abs(utime-uExact));
errorSI = max(abs(utimeback-uExact));

fprintf('Forward Euler error: %.4e\n',errorFE);
fprintf('Semi-implicit Euler error: %.4e\n',errorSI);

% Compare the solutions
figure;
plot(x,uExact,'k-','LineWidth',1.5);
hold on;
plot(x,utime,'b--','LineWidth',1.2);
plot(x,utimeback,'r-.','LineWidth',1.2);
xlabel('x');
ylabel('u');
title(['Solutions at t = ',num2str(T)]);
legend('Exact','Forward Euler','Semi-implicit','Location','best');
grid on;

print(gcf,'task3_comparison.png','-dpng','-r300');

end