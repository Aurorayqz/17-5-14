%处理表格细节
ylim( [-0.5,1.5] );
zlim( [-2.5,3.5] );
xlim([0,7]);

xlabel('第n个交易日');
ylabel('动态仿真涨跌情况');
title('动态仿真（y轴值为0代表跌 值为1代表涨或持平）')  

x=1:78;
plot(x,all_predict_label(:,1),'red',x,all_predict_label(:,2),'red',x,all_predict_label(:,3),'red',x,all_predict_label(:,4),'red',x,all_predict_label(:,5),'red',x,all_predict_label(:,6),'red');

set(gca,'XTick',[1:1:7]) %改变x轴坐标间隔显示 这里间隔为2

set(gca,'ZTick',[-1:1:2]) %改变x轴坐标间隔显示 这里间隔为2

[M,N]=size(all_predict_label);
true_all_predict_label=[all_predict_label,zeros(M,1)];
[M,N]=size(true_all_predict_label);
true_all_predict_label=[true_all_predict_label;zeros(1,N)];
% 黄金
% 白银
% 铜
% 铝
% 镍
% 铅
% 锡
% 螺纹钢

set(gca,'xtick',[1 2 3 4 5 6 7],'xticklabel',{'                        黄金','                            白银','                            铜','                            铝','                            铅','                            螺纹钢',' '})
title('金属板块主力合约在共有交易日内的资金流向表（黑色代表流出、白色代表流入）')  ;
ylabel('第y个交易日');