%%��̬������루����ָ��������
clear;
best_accuracy=0;
for n = 1:55
[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData('SHFE', 'ag0000', 'day', 1, 20110101, 20131231,false, 'FWard');
%%��ʼ�����ݵı�ǩ������Ϊ1������Ϊ0�� 
A=double(0);
close_yesterday=[A(1,1);close(1:size(close)-1,1)];
static_trend=close(1:size(close))-close_yesterday(1:size(close_yesterday));
% trend=trend(2:end);
static_trend(static_trend>=0)=1;
static_trend(static_trend<0)=0;
%% �ü���ָ���������з���
[Technical_data] = Technical_indicators();
%% 
%�������ɷַ��������
after_princomp=Technical_princomp(Technical_data);
[Rows1,Column1]=size(after_princomp);
[Rows2,Column2]=size(static_trend);
static_trend=static_trend((Rows2-Rows1+1):Rows2,:);
%% 
%Ԥ����̬Ԥ������
[dynamic_data,dynamic_trend]=dynamic_data_initialization(n,after_princomp,static_trend);
%% ��̬����
%ͨ��������֤��ȡѵ�����Ͳ��Լ�����������Ϊ8:2��
[train, test] = crossvalind('holdOut',dynamic_trend,0.2); 

%���ɶ�̬Ԥ��ѵ�����Ͳ��Լ�
train_result = dynamic_data(train,:);
train_result_labels = dynamic_trend(train,:);
train_result_labels = double( train_result_labels );

test_result = dynamic_data(test,:);
test_result_labels = dynamic_trend(test,:);
test_result_labels = double( test_result_labels );
%% 
%"1"����the data x to [0,1]       "2"����normalize the data x to [-1,1]
%�������ֹ淶���ķ�ʽ�����ϲ��淶��һ�����ַ�ʽ������һ��һ����׼ȷ��
train_result = normalization(train_result',2);
test_result = normalization(test_result',2);
train_result = train_result';
test_result = test_result';
%
%% 
% ����GA����Ѱ�ź���(��������|�Ŵ��㷨):gaSVMcgForClass
 [bestCVaccuracy,bestc,bestg,ga_option]=gaSVMcgForClass(train_result_labels,train_result);
% ���룺
% train_result_labels:ѵ�����ı�ǩ����ʽҪ����svmtrain��ͬ��
% train_result:ѵ��������ʽҪ����svmtrain��ͬ��
% ga_option:GA�е�һЩ�������ã��ɲ����룬��Ĭ��ֵ����ϸ�뿴����İ���˵����
% �����
% bestCVaccuracy:����CV�����µ���ѷ���׼ȷ�ʡ�
% bestc:��ѵĲ���c��
% bestg:��ѵĲ���g��
% ga_option:��¼GA�е�һЩ������
 tem=[n,bestCVaccuracy];
 if(21==n)
     paint=tem;
 else
    paint=[paint;tem];
 end
  if(best_accuracy<bestCVaccuracy(1))
   best_accuracy=bestCVaccuracy(1,:);
   best_n=n;
   best_n_c=bestc;
   best_n_g=bestg;
end
end
% ��ͼ
% figure 
% plot(paint(:,1),paint(:,2));
% xlabel('���ڳ���(day)');ylabel('׼ȷ��(%)');
% xlim( [1,55] );
% title('���׼ȷ��Ϊ��73.08%   ���Ŵ��ڳ���Ϊ��5��'); 
%% 
