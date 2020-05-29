%% PARAMETERS
%dm = (pi/3)*(1-t);
dt = t;

%% INITIALIZATION
%
% consistent random numbers
rng(200523)

% nodes of polygon
V  = zeros(12,2);
om = 2*pi*(0:5)/6-pi/6;
V(1:6 ,:) = [cos(om)'     sin(om)'];
%V(7:12,:) = [cos(om+dm)' sin(om+dm)'];
V(7:12,:) = [cos(om)'*dt  sin(om)'*dt];

% points
P = zeros(N,2);
P(1,:) = V(1,:);

%% ITERATION OF THE SYSTEM
for n = 2:N
    r = rand(1);
    d = rand(1);
    if d <= 6/7
        u=0;
    else
        u=6;
    end
    for i = 1:6
        if r <= i/6
            P(n,:) = ( P(n-1,:) + 2*V(i+u,:) )/3;
            break
        end
    end
end

%% PLOTTING
plot(P(:,1),P(:,2),'w.','MarkerSize',1)
xlim([-1.1 1.1])
ylim([-1.1 1.1])
set(gca,'XColor', 'k','YColor','k')
set(gca,'Color','k')

