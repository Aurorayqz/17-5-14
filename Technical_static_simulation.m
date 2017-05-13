%%静态仿真代码（技术指标向量）
clear;
%% 
[time,open,high,low,close,volume,turnover,openinterest]=traderGetKData('SHFE', 'ag0000', 'day', 1, 20110101, 20131231,false, 'FWard');
%%初始化数据的标签（涨设为1，跌设为0） 
A=double(0);
close_yesterday=[A(1,1);close(1:size(close)-1,1)];
static_trend=close(1:size(close))-close_yesterday(1:size(close_yesterday));
% trend=trend(2:end);
static_trend(static_trend>=0)=1;
static_trend(static_trend<0)=0;
%% 用技术指标向量进行仿真
[Technical_data] = Technical_indicators();
%% 
%经过主成分分析处理过
after_princomp=Technical_princomp(Technical_data);
[Rows1,Column1]=size(after_princomp);
[Rows2,Column2]=size(static_trend);
static_trend=static_trend((Rows2-Rows1+1):Rows2,:);
%% 静态仿真
%通过交叉验证抽取训练集和测试集（样本比例为1:1）
[train, test] = crossvalind('holdOut',static_trend); 

% 生成静态预测训练集和测试集
train_result = after_princomp(train,:);
train_result_labels = static_trend(train,:);
train_result_labels = double( train_result_labels );

test_result = after_princomp(test,:);
test_result_labels = static_trend(test,:);
test_result_labels = double( test_result_labels );
%% 
%"1"代表the Technical_data x to [0,1]       "2"代表normalize the Technical_data x to [-1,1]
%这是两种规范化的方式，加上不规范化一共三种方式，可以一个一个试准确度
train_result = normalization(train_result',2);
test_result = normalization(test_result',2);
train_result = train_result';
test_result = test_result';
%
%% 
% 利用GA参数寻优函数(分类问题|遗传算法):gaSVMcgForClass
 [bestCVaccuracy,bestc,bestg,ga_option]=gaSVMcgForClass(train_result_labels,train_result);
% 输入：
% train_result_labels:训练集的标签，格式要求与svmtrain相同。
% train_result:训练集，格式要求与svmtrain相同。
% ga_option:GA中的一些参数设置，可不输入，有默认值，详细请看代码的帮助说明。
% 输出：
% bestCVaccuracy:最终CV意义下的最佳分类准确率。
% bestc:最佳的参数c。
% bestg:最佳的参数g。
% ga_option:记录GA中的一些参数。
%% 
