%% PARAMETERS
%dm = (pi/3)*t;
%dt = 1-t;
pp = t/7;

%% INITIALIZATION
%
% consistent random numbers
rng(200523)

% nodes of polygon
V  = zeros(3,2);
om = 2*pi*[0 1 2]/3-pi/6;
V(1:3,:) = [cos(om)'     sin(om)'];
%V(4:6,:) = [cos(om+dm)' sin(om+dm)'];

% points
P = zeros(N,2);
P(1,:) = V(1,:);

%% ITERATION OF THE SYSTEM
for n = 2:N
    r = rand(1);
    d = rand(1);
    if d <= pp
        P(n,:) = ( P(n-1,:) + [0 0] )/2;
        continue
    else
        for i = 1:3
            if r <= i/3
                P(n,:) = ( P(n-1,:) + V(i,:) )/2;
                break
            end
        end
    end
end

%% PLOTTING
plot(P(:,1),P(:,2),'w.','MarkerSize',1)
xlim([-1.1 1.1])
ylim([-1.1 1.1])
set(gca,'XColor', 'k','YColor','k')
set(gca,'Color','k')

