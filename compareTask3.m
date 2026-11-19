function [errorFE,errorSI] = compareTask3(x,uFE,uSI,T,epsilon)
T=10;
epsilon=0.01;
% Find the wave speed
syms z c
q = 1/(1+exp(z/(sqrt(2)*epsilon)));

% u_t = -c*q' and u_xx = q''
eq = -c*diff(q,z) - epsilon^2*diff(q,z,2) + q^3-q;
c = double(solve(simplify(eq) == 0,c));

% Exact solution
uExact = 0.5*(1-tanh((x-c*T)/(2*sqrt(2)*epsilon)));

% Make all vectors column vectors
x = x(:);
uExact = uExact(:);
uFE = uFE(:);
uSI = uSI(:);

% Maximum absolute errors
errorFE = max(abs(uFE-uExact));
errorSI = max(abs(uSI-uExact));

fprintf('Forward Euler error: %.4e\n',errorFE);
fprintf('Semi-implicit Euler error: %.4e\n',errorSI);

% Compare the solutions
figure;
plot(x,uExact,'k-','LineWidth',1.5);
hold on;
plot(x,uFE,'b--','LineWidth',1.2);
plot(x,uSI,'r-.','LineWidth',1.2);
xlabel('x');
ylabel('u');
title(['Solutions at t = ',num2str(T)]);
legend('Exact','Forward Euler','Semi-implicit','Location','best');
grid on;

print(gcf,'task3_comparison.png','-dpng','-r300');

end