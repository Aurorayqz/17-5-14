%��ʼ������ָ������
function [final_technical_data]=Technical_indicators()
% clc,clear;
Market='SHFE'; 
Code='ag0000';
%% 
% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ�1��K�ߵļ��ƶ�ƽ����
[ma]=traderMA(20,Market, Code, 'day', 1, 20110101, 20131231,false,'FWard');

% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ�1��K�ߵ�ָ��ƽ���ƶ�ƽ����
[ema] =traderEMA(5,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ�1��K�߼�������Ϊ24�Ĺ�����
[bias] =traderBIAS(24,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ�1��K�ߵ�OBV������ָ��
[obv]=traderOBV(Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ���ǰ��Ȩ��1��K�ߵ�˳��ָ��
[cci] =traderCCI(14,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ����ǿ��ָ��rsiָ��ֵ
[rsi]=traderRSI(5,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');

% �������ΪCode�Ĺ�Ʊ�Ĵ�2011��01��01�յ�2013��12��31�յ����ָ��kdjָ��ֵ
[k,d,j]=traderKDJ(9, 3, 3,Market, Code, 'day', 1,  20110101, 20131231,false,'FWard');
%% 
%�������õ��ļ���ָ��������������ϲ�
%˳��Ϊ�����ƶ�ƽ����->ָ��ƽ���ƶ�ƽ����->������->OBV������ָ�� 
%        ->˳��ָ��->���ǿ��ָ��rsi->���ָ��k->���ָ��d->���ָ��j
technical_data=[ma(:,1), ema(:,1),bias(:,1), obv(:,1),cci(:,1), rsi(:,1),k(:,1), d(:,1),j(:,1)];

%ȡ��technical_data��������
[Rows,Column]=size(technical_data);

%��technical_data�е�NULL���������޳�
final_technical_data=technical_data(24:Rows,:);
