%h = figure;
%axis tight manual % this ensures that getframe() returns a consistent size
filename = 'Sierpinsky01.gif';

N  = 10000000;
%N  = 10000;

t = 0;
animation1
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.5);
delete(gca)

for t = 0:(1/100):1
    animation1
    fr = getframe(gca); 
    im = frame2im(fr); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1,...
        'DisposalMethod','restoreBG');
    delete(gca)
end

animation1
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.5,...
    'DisposalMethod','restoreBG');
delete(gca)

for t = 0:(1/100):1
    animation0b
    fr = getframe(gca); 
    im = frame2im(fr); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1,...
        'DisposalMethod','restoreBG');
    delete(gca)
end

animation0b
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.5,...
    'DisposalMethod','restoreBG');
delete(gca)

for t = 0:(1/100):1
    animation2
    fr = getframe(gca); 
    im = frame2im(fr); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1,...
        'DisposalMethod','restoreBG');
    delete(gca)
end

animation2
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.5,...
    'DisposalMethod','restoreBG');
delete(gca)

for t = 0:(1/100):1
    animation1inv
    fr = getframe(gca); 
    im = frame2im(fr); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1,...
        'DisposalMethod','restoreBG');
    delete(gca)
end

animation1inv
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.5,...
    'DisposalMethod','restoreBG');
delete(gca)

for t = 0:(1/100):1
    animation6b
    fr = getframe(gca); 
    im = frame2im(fr); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1,...
        'DisposalMethod','restoreBG');
    delete(gca)
end

animation6b
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.5,...
    'DisposalMethod','restoreBG');
delete(gca)

for t = 0:(1/100):1
    animation5
    fr = getframe(gca); 
    im = frame2im(fr); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1,...
        'DisposalMethod','restoreBG');
    delete(gca)
end

animation5
fr = getframe(gca); 
im = frame2im(fr); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.5,...
    'DisposalMethod','restoreBG');
delete(gca)


