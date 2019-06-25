%% 手掌图像通过寻找最大内切圆方法进行截取 （已完成）
%% Step1 读入图像
tic
image=imread('0001_m_l_01.jpg');
img=imbinarize(image,50/255);%%二值化,阈值50

%% Step2 遍历图像上每一点，计算以该点为中心的最大内切圆半径
[i1,i2]=size(img);
radius=50; %% 最小初始半径设为50
x=0;
y=0;
for i=50:i1-50
    for j=50:i2-50
        if(img(i,j)==1) %% 判断该点是否在手掌区域内
            for a=1:360
%                 count=0;
%                 count=count+1;
                y1=j+radius*cos(a*pi/180);    %% 获取圆周上的点  
                x1=i-radius*sin(a*pi/180);    %% 获取圆周上的点  
                y1=int16(y1); %% 取整
                x1=int16(x1); %% 取整
                if(x1<1||x1>i1||y1<1||y1>i2||img(x1,y1)==0) %% 判断圆周上的点是否符合条件
                    break;
                end           
            end
            if(a==360) %% 若圆周上的点全符合条件，则增加半径
                radius=radius+10;%%  半径以10为步长
                x=i; %% x,y为圆心位置
                y=j;
            end
            
        end
    end
end

%% Step3 得到圆心和半径后进行画圆
radius=radius-10;%% 半径-10
figure
imshow(image);
hold on;
x0=y-sqrt(2)*radius/2; %% 内接矩形左上角点
x0=int16(x0);
y0=x-sqrt(2)*radius/2; %% 内接矩形左上角点
y0=int16(y0);
wsize=sqrt(2)*radius;  %% 内接矩形宽度（应为正方形）
wsize=int16(wsize);
% rectangle('position',[x-sqrt(2)*radius/2,y-sqrt(2)*radius/2,sqrt(2)*radius,sqrt(2)*radius]);

%% Step4 画出矩形和圆后，将矩形截取进行保存为ROI
rectangle('Position',[x0,y0,wsize,wsize],'LineWidth',2,'EdgeColor','r');
rectangle('Position',[y-radius,x-radius,2*radius,2*radius],'Curvature',[1,1],'linewidth',1)
% ROI = get_rect(image,x0,y0,wsize,wsize,'I');
% imwrite(ROI,'1.jpg');
hold off;
A = imcrop(image,[x0,y0,wsize,wsize]); 
imwrite(A,'A.jpg');
toc
