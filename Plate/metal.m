targetList(1).Market='SHFE';
targetList(1).Code='AU0000';
targetList(2).Market='SHFE';
targetList(2).Code='AG0000';%400
targetList(3).Market='SHFE';
targetList(3).Code='CU0000';
targetList(4).Market='SHFE';
targetList(4).Code='AL0000';
targetList(5).Market='SHFE';
targetList(5).Code='PB0000';%673
targetList(6).Market='SHFE';
targetList(6).Code='RB0000';
%% 
for i=1:length(targetList)
[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData(targetList(i).Market, targetList(i).Code, 'day', 1, 20110101, 20131231,false,'NA');
%[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData('SHFE','RB0000', 'day', 1, 20110101, 20131231,false,'NA');
% % (�˴��ɸ��ݻ�õ�������һЩ��Ӧ�ļ���)
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
    m=min(size(all_predict_label,1),size(predict_label,1));%ȷ����С����
%     n=min(size(A,2),size(B,2));%ȷ����С����

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
set(gca,'xtick',[1 2 3 4 5 6 7],'xticklabel',{'                        �ƽ�','                            ����','                            ͭ','                            ��','                            Ǧ','                            ���Ƹ�',' '});
title('�������������Լ�ڹ��н������ڵ��ʽ��������ɫ������������ɫ�������룩')  ;
ylabel('��y��������');

