%静态仿真数据预处理，若当天收盘价比前一天收盘价高或持平，则设为1，否则设为0.
A=double(0);
close_yesterday=[A(1,1);close(1:size(close)-1,1)];
static_trend=close(1:size(close))-close_yesterday(1:size(close_yesterday));
% trend=trend(2:end);
static_trend(static_trend>0)=1;
static_trend(static_trend<=0)=0;

