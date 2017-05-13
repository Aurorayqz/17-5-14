
function BackTest(freq,N,stop_rate)
% 交易逻辑
% variables: x(0),y(0),z(0);
% if average(c,5)>average(c,10) then x=1;
% if average(c,5)<average(c,10) then x=-1;
% IF average(c,2)<average(c,5)then y=1;
% if average(c,2)>average(c,5)then y=-1;
% if highestbar(c,50)>lowestbar(c,50) then z=1;
% if highestbar(c,50)<lowestbar(c,50) then z=-1;
% if x+y+z>0 then buy next bar at market;
% if x+y+z<0 then sell short next bar at market;
%出场使用止盈止损出场。3：1的比例



targetList  =  traderGetTargetList();
HandleList  =  traderGetHandleList();
global entryP;%跟踪价格
global key0;%用来记录进场价格的开关
if isempty(entryP)||isempty(key0)
    entryP=zeros(length(targetList),1);
    key0=zeros(length(targetList),1);
end
sharenum=50*[1,50];
for  i=1:length(targetList)
    lags=N+2;%策略中每次取数据的长度
    [position,Frozen,AvgPrice] = traderGetAccountPosition(HandleList(1),targetList(i).Market,targetList(i).Code);
    %开仓
    [time,open,high,low,close,volume,turnover,openinterest]  =  traderGetKData(targetList(i).Market,targetList(i).Code,'day',freq,  0-lags,0,false,'FWard');
    if  length(close)<lags
        continue;
    end
    close=close(end-N+1:end);
    x = (mean(close(end-4:end))>mean(close(end-10+1:end)));
    y = (mean(close(end-1:end))<mean(close(end-4:end)));
    z = (mean(find(close==min(close)))>mean(find(close==max(close))));
    if key0(i)==1
        entryP(i)=AvgPrice;
        key0(i)=0;
    end
    
    if position>0
        
        if close(end)>  entryP(i)*(1+3*stop_rate)   || close(end)<entryP(i)*(1-stop_rate)
            traderPositionTo(HandleList(1),targetList(i).Market,targetList(i).Code,0 ,0,'market','stopLong');
        end
        if close(end)>  entryP(i)*(1+3*stop_rate)
            entryP(i)=close(end);
        end
    elseif position<0
        if  close(end)<entryP(i)*(1-3*stop_rate) || close(end)>entryP(i)*(1+stop_rate)
            traderPositionTo(HandleList(1),targetList(i).Market,targetList(i).Code,0 ,0,'market','stopLong');
        end
        if close(end)<  entryP(i)*(1-3*stop_rate)
            entryP(i)=close(end);
        end
    else
        %开仓
        
        if  x+y+z<=1 && close(end)<mean(close(end-N+1:end))
            order=traderSellShort(HandleList(1),targetList(i).Market,targetList(i).Code,sharenum(i),0,'market','short');
            if  order~=0
                key0(i)=1;
            end
        end
        if  x+y+z>1 && close(end)>mean(close(end-N+1:end))
            order= traderBuy(HandleList(1),targetList(i).Market,targetList(i).Code,sharenum(i),0,'market','long1');
            if  order~=0
                key0(i)=1;
            end
        end
    end
end
end