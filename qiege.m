clear;clc;
photo_matrix=imread('3_看图王.png');
photo_matrix=rgb2gray(photo_matrix);
thresh=graythresh(photo_matrix);
photo_matrix=im2bw(photo_matrix,thresh);
[r,c]=size(photo_matrix);
record_y=zeros(1,r);
for i=1:r
    num_0=0;
    for j=1:c
        if photo_matrix(i,j)==0
            num_0=num_0+1;
        end
    end
    if num_0>5
        num_cur=0;
    else
        num_cur=1;
    end
    record_y(i)=num_cur;
end

record_x=zeros(1,c);
for i=1:c
    num_0=0;
    for j=1:r
        if photo_matrix(j,i)==0
            num_0=num_0+1;
        end
    end
    if num_0>5
        num_cur=0;
    else
        num_cur=1;
    end
    record_x(i)=num_cur;
end
%识别边界
edge_x=[];
edge_y=[];
num_edge=1;
for i=2:c
    if record_x(i)==0&&record_x(i-1)==1
        edge_x(num_edge)=i;
        num_edge=num_edge+1;
    elseif record_x(i)==1&&record_x(i-1)==0
        edge_x(num_edge)=i-1;
        num_edge=num_edge+1;
    end
end

num_edge=1;
for i=2:r
    if record_y(i)==0&&record_y(i-1)==1
        edge_y(num_edge)=i;
        num_edge=num_edge+1;
    elseif record_y(i)==1&&record_y(i-1)==0
        edge_y(num_edge)=i-1;
        num_edge=num_edge+1;
    end
end

text_width=round((edge_x(2)-edge_x(1)+1)/4);
text_height=edge_y(2)-edge_y(1)+1;
num_edgex=length(edge_x);
ii=1;
for i=1:2:num_edgex
    num_text=round((edge_x(i+1)-edge_x(i)+1)/text_width);
    if num_text
        edge_x(ii)=edge_x(i+1)-text_width*num_text+1;
        edge_x(ii+1)=edge_x(i+1);
        ii=ii+2;
    end
end
edge_x=edge_x(1:ii-1);
num_edgex=length(edge_x);
ii=2;
for i=2:2:num_edgex-1
    num_text=edge_x(i+1)-edge_x(i);
    if num_text>2
        edge_x(ii)=edge_x(i);
        edge_x(ii+1)=edge_x(i+1);
        ii=ii+2;
    end
end
edge_x(ii)=edge_x(i+2);
edge_x=edge_x(1:ii);
num_c=round(length(edge_x)/4);%总共三列
num_r=round(length(edge_y)/2);
data=zeros(num_r,num_c);
%取样 0
if ~exist('0.mat')&&~exist('9.mat')
    hang=1;
    lie=1;
    num_order=4;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('0.mat','a');
    %1
    hang=5;
    lie=1;
    num_order=2;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('1.mat','a');
    % %2
    hang=5;
    lie=1;
    num_order=3;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('2.mat','a');
    % %3
    hang=2;
    lie=1;
    num_order=3;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('3.mat','a');
    % %4
    hang=2;
    lie=1;
    num_order=4;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('4.mat','a');
    % %5
    hang=5;
    lie=2;
    num_order=1;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('5.mat','a');
    % %6
    hang=3;
    lie=1;
    num_order=3;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('6.mat','a');
    % %7
    hang=4;
    lie=6;
    num_order=1;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('7.mat','a');
    % %8
    hang=3;
    lie=4;
    num_order=2;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('8.mat','a');
    % %9
    hang=2;
    lie=6;
    num_order=1;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('9.mat','a');
    %-
    hang=1;
    lie=9;
    num_order=3;
    position_x=edge_x(lie*2-1)+(num_order-1)*text_width;
    position_y=edge_y(hang*2-1);
    a=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
    save('10.mat','a');
end


for i=1:num_r
    for j=1:num_c
        hang=i;
        lie=2*j-1;
        num=round((edge_x(2*lie)-edge_x(2*lie-1))/text_width);
        number_1=0;
        signal=0;%+
        for h=1:num
            position_x=edge_x(lie*2-1)+(h-1)*text_width;
            position_y=edge_y(hang*2-1);
            data_temp=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
            numb=match(data_temp);
            if numb==10
                numb=0;
                signal=1;%-
            end
            number_1=number_1*10+numb;
        end
        lie=2*j;
        num=round((edge_x(lie*2)-edge_x(lie*2-1))/text_width);
        number_2=0;
        for h=1:num
            position_x=edge_x(lie*2-1)+(h-1)*text_width;
            position_y=edge_y(hang*2-1);
            data_temp=photo_matrix(position_y:position_y+text_height-1,position_x:position_x+text_width-1);
            numb=match(data_temp);
            number_2=number_2*10+numb;
        end
        number=number_1+number_2/100;
        if signal
            number=-number;
        end
        data(i,j)=number;
    end
    
end
