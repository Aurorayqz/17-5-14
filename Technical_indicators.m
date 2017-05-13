%初始化技术指标向量
function [final_technical_data]=Technical_indicators()
% clc,clear;
Market='SHFE'; 
Code='ag0000';
%% 
% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的1日K线的简单移动平均线
[ma]=traderMA(20,Market, Code, 'day', 1, 20110101, 20131231,false,'FWard');

% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的1日K线的指数平滑移动平均线
[ema] =traderEMA(5,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的1日K线计算周期为24的乖离率
[bias] =traderBIAS(24,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的1日K线的OBV能量潮指标
[obv]=traderOBV(Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的向前复权的1日K线的顺势指标
[cci] =traderCCI(14,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的相对强弱指标rsi指标值
[rsi]=traderRSI(5,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% 计算代码为Code的股票的从2011年01月01日到2013年12月31日的随机指标kdj指标值
[k,d,j]=traderKDJ(9, 3, 3,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');
%% 
%对上述得到的技术指标向量进行列向合并
%顺序为：简单移动平均线->指数平滑移动平均线->乖离率->OBV能量潮指标 
%        ->顺势指标->相对强弱指标rsi->随机指标k->随机指标d->随机指标j
technical_data=[ma(:,1), ema(:,1),bias(:,1), obv(:,1),cci(:,1), rsi(:,1),k(:,1), d(:,1),j(:,1)];

%取得technical_data的行列数
[Rows,Column]=size(technical_data);

%将technical_data中的NULL数据整行剔除
final_technical_data=technical_data(24:Rows,:);
