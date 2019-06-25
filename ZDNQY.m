%% ����ͼ��ͨ��Ѱ���������Բ�������н�ȡ ������ɣ�
%% Step1 ����ͼ��
tic
image=imread('0001_m_l_01.jpg');
img=imbinarize(image,50/255);%%��ֵ��,��ֵ50

%% Step2 ����ͼ����ÿһ�㣬�����Ըõ�Ϊ���ĵ��������Բ�뾶
[i1,i2]=size(img);
radius=50; %% ��С��ʼ�뾶��Ϊ50
x=0;
y=0;
for i=50:i1-50
    for j=50:i2-50
        if(img(i,j)==1) %% �жϸõ��Ƿ�������������
            for a=1:360
%                 count=0;
%                 count=count+1;
                y1=j+radius*cos(a*pi/180);    %% ��ȡԲ���ϵĵ�  
                x1=i-radius*sin(a*pi/180);    %% ��ȡԲ���ϵĵ�  
                y1=int16(y1); %% ȡ��
                x1=int16(x1); %% ȡ��
                if(x1<1||x1>i1||y1<1||y1>i2||img(x1,y1)==0) %% �ж�Բ���ϵĵ��Ƿ��������
                    break;
                end           
            end
            if(a==360) %% ��Բ���ϵĵ�ȫ���������������Ӱ뾶
                radius=radius+10;%%  �뾶��10Ϊ����
                x=i; %% x,yΪԲ��λ��
                y=j;
            end
            
        end
    end
end

%% Step3 �õ�Բ�ĺͰ뾶����л�Բ
radius=radius-10;%% �뾶-10
figure
imshow(image);
hold on;
x0=y-sqrt(2)*radius/2; %% �ڽӾ������Ͻǵ�
x0=int16(x0);
y0=x-sqrt(2)*radius/2; %% �ڽӾ������Ͻǵ�
y0=int16(y0);
wsize=sqrt(2)*radius;  %% �ڽӾ��ο�ȣ�ӦΪ�����Σ�
wsize=int16(wsize);
% rectangle('position',[x-sqrt(2)*radius/2,y-sqrt(2)*radius/2,sqrt(2)*radius,sqrt(2)*radius]);

%% Step4 �������κ�Բ�󣬽����ν�ȡ���б���ΪROI
rectangle('Position',[x0,y0,wsize,wsize],'LineWidth',2,'EdgeColor','r');
rectangle('Position',[y-radius,x-radius,2*radius,2*radius],'Curvature',[1,1],'linewidth',1)
% ROI = get_rect(image,x0,y0,wsize,wsize,'I');
% imwrite(ROI,'1.jpg');
hold off;
A = imcrop(image,[x0,y0,wsize,wsize]); 
imwrite(A,'A.jpg');
toc
