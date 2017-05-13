%%��̬������루����k��������
clear;
%% 
[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData('SHFE', 'ag0000', 'day', 1, 20110101, 20131231,false, 'FWard');
%%��ʼ�����ݵı�ǩ������Ϊ1������Ϊ0�� 
A=double(0);
close_yesterday=[A(1,1);close(1:size(close)-1,1)];
static_trend=close(1:size(close))-close_yesterday(1:size(close_yesterday));
% trend=trend(2:end);
static_trend(static_trend>=0)=1;
static_trend(static_trend<0)=0;
%% �û���k���������з���
data = [open(:,1), high(:,1),low(:,1), close(:,1),volume(:,1), turnover(:,1),openinterest(:,1)];
%% 
%�������ɷַ��������
after_princomp=princomp(data);
%% ��̬����
%ͨ��������֤��ȡѵ�����Ͳ��Լ�����������Ϊ1:1��
[train, test] = crossvalind('holdOut',static_trend,0.2); 

% ���ɾ�̬Ԥ��ѵ�����Ͳ��Լ�
train_result = after_princomp(train,:);
train_result_labels = static_trend(train,:);
train_result_labels = double( train_result_labels );

test_result = after_princomp(test,:);
test_result_labels = static_trend(test,:);
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
%% 
