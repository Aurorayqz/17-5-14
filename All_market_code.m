% A 代表获取的上海商品期货交易所的所有主力合约
% B 代表获取的郑州商品期货交易所的所有主力合约
% C 代表获取的大连商品期货交易所的所有主力合约
A=traderGetCodeList('SHFE000');
B=traderGetCodeList('CZCE000');
C=traderGetCodeList('DCE000');
%% 上海商品期货交易所
SHFE_row=size(A,1);
for n = 1:SHFE_row
    
end
%% 郑州商品期货交易所
CZCE_row=size(B,1);
for n = 1:CZCE_row
    
end

%% 大连商品期货交易所
DCE_row=size(C,1);
for n = 1:DCE_row
    
end