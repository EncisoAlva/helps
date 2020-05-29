%% PARAMETERS
dm = (pi/3)*(t-1);
%dt = 1-t;

%% INITIALIZATION
%
% consistent random numbers
rng(200523)

% nodes of polygon
V  = zeros(6,2);
om = 2*pi*[0 1 2]/3-pi/6;
V(1:3,:) = [cos(om)'     sin(om)'];
V(4:6,:) = [cos(om+dm)' sin(om+dm)'];

% points
P = zeros(N,2);
P(1,:) = V(1,:);

%% ITERATION OF THE SYSTEM
for n = 2:N
    r = rand(1);
        for i = 1:6
            if r <= i/6
                P(n,:) = ( P(n-1,:) + V(i,:) )/2;
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

