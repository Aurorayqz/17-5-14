clear;
targetList(1).Market='CZCE';
targetList(1).Code='OI000';%725
targetList(2).Market='CZCE';
targetList(2).Code='OI001';
targetList(3).Market='DCE';
targetList(3).Code='Y0000';
targetList(4).Market='DCE';
targetList(4).Code='Y0001';
targetList(5).Market='DCE';
targetList(5).Code='P0000';
targetList(6).Market='DCE';
targetList(6).Code='P0001';
% targetList(9).Market='CZCE';
% targetList(9).Code='';
% targetList(10).Market='CZCE';
% targetList(10).Code='';
% targetList(11).Market='CZCE';
% targetList(11).Code='';
% targetList(12).Market='CZCE';
% targetList(12).Code='';
% targetList(13).Market='CZCE';
% targetList(13).Code='';
%% 
for i=1:length(targetList)
[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData(targetList(i).Market, targetList(i).Code, 'day', 1, 20110101, 20131231,false,'NA');
% clear;
[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData('DCE','P0001', 'day', 1, 20110101, 20131231,false,'NA');
% % (此处可根据获得的数据做一些相应的计算)
A=double(0);
close_yesterday=[A(1,1);close(1:size(close)-1,1)];
static_trend=close(1:size(close))-close_yesterday(1:size(close_yesterday));
% trend=trend(2:end);
static_trend(static_trend>=0)=1;
static_trend(static_trend<0)=0;
data = [open(:,1), high(:,1),low(:,1), close(:,1),volume(:,1), turnover(:,1),openinterest(:,1)];
[predict_label]=Plate_dynamic_simulation(data,static_trend,close_yesterday);
%% 
if 1==i
    all_predict_label=predict_label;
else
    m=min(size(all_predict_label,1),size(predict_label,1));%确定最小行数
%     n=min(size(A,2),size(B,2));%确定最小列数

    all_predict_label=all_predict_label(1:m,:);
    predict_label=predict_label(1:m,:);
    all_predict_label=[all_predict_label,predict_label];
end

end

for i=1:length(targetList)
true_all_predict_label(:,:,i)=all_predict_label(:,1);
end

[M,N]=size(all_predict_label);
true_all_predict_label=[all_predict_label,zeros(M,1)];
[M,N]=size(true_all_predict_label);
true_all_predict_label=[true_all_predict_label;zeros(1,N)];

pcolor(true_all_predict_label);
% pcolor(true_all_predict_label(1:80,:));
set(gca,'xtick',[1 2 3 4 5 6 7],'xticklabel',{'                        菜籽油主力','                         菜籽油次主力','                           豆油主力','                          豆油次主力','                         棕榈油主力','                             棕榈油次主力 ',' '});
title('油类板块在共有交易日内的资金流向表（黑色代表流出、白色代表流入）')  ; 
ylabel('第y个交易日');

