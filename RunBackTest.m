clc;
clear all;
targetList(1).Market = 'CFFEX';
targetList(1).Code = 'IF0000';
targetList(2).Market = 'SHFE';
targetList(2).Code = 'al0000';
N=50;
freq=1;
stop_rate =0.02;

%-------ʵʱ������Ҫ�����˺ţ��ز�ط��Ѿ�Ĭ���˺ţ�������Ҫ�����˺�------%  

%�ز�
AccountList(1)  =  {'FutureBackReplay'};
traderRunBacktest('BackTest',@test6,{freq,N,stop_rate},AccountList,targetList,'min',30,20140101,20151231,'FWard');