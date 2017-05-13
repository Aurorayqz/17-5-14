function [dynamic_data,dynamic_trend]=dynamic_data_initialization(n,after_princomp,static_trend)
%% 
data_Rows=size(after_princomp,1);
[data_Rows,Column]=size(after_princomp);
%% 生成动态仿真的输入向量
for i = n:(data_Rows-1)
    train_example=after_princomp((i-n+1):i,:); 
    tem=sum(train_example);
    if i == n
        dynamic_data=tem;
    else
        dynamic_data=[dynamic_data;tem];
    end
end
%% 生成动态仿真的输出向量
dynamic_trend=static_trend((n+1):data_Rows,:); 