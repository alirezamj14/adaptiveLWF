function MyPlot(x, y)   
figure(1)

xlabel('Old task performance')
ylabel('New task performance')
grid on
n=length(x);
dx=4/(n-1);
A=1:dx:5;
% A=[2 4 6 8]; %sizes
hold on
for k=1:numel(A)
  h=scatter(x(k),y(k),'r','marker','o','linewidth',A(k));
end

plot(x,y,'r','linewidth',2)

end
