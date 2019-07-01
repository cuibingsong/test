function y=match(data)
s=zeros(1,11);
if sum(sum(abs(ones(size(data))-data)))<2;
    y=0;
else
    for i=1:11
        name=[num2str(i-1),'.mat'];
        load(name);
        s(i)=sum(sum(abs(a-data)));
    end
    minVal = min(s);
    y= find(s==minVal,1)-1;
end
end
