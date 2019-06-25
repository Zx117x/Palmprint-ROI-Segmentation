function res = get_rect(ref,x,y,width,height,flag)
% 获取原图的局部矩形区域，并返回
im = ref(y:y+height-1,x:x+width-1,:); 
figure;
set (gcf,'Position',[300,300,width,height]);
imshow(im,'border','tight','initialmagnification','fit'); 
text(width-15,height-10,flag,'Color', 'y','fontsize',15);
frame=getframe(gcf);
res=frame2im(frame);
end
