function [after_princomp]=Technical_princomp(data)
%% pre-process
stdr = std(data);
sr = data./repmat(stdr,size(data,1),1);
%% use princomp 
[coef,score,latent,t2] = pca(sr);
%% 输出参数讲解

% coef:9*9
% 主成分系数:即原始数据线性组合生成主成分数据中每一维数据前面的系数.
% coef的每一列代表一个新生成的主成分的系数.
% 比如你想取出前三个主成分的系数,则如下可实现:pca3 = coef(:,1:3);

% score:329*9
% 字面理解:主成分得分
% 即原始数据在新生成的主成分空间里的坐标值.

% latent:9*1
% 一个列向量,由sr的协方差矩阵的特征值组成.
% 即 latent = sort(eig(cov(sr)),'descend');
% 测试如下:
% sort(eig(cov(sr)),'descend') =
%     3.4083
%     1.2140
%     1.1415
%     0.9209
%     0.7533
%     0.6306
%     0.4930
%     0.3180
%     0.1204
% latent =
%     3.4083
%     1.2140
%     1.1415
%     0.9209
%     0.7533
%     0.6306
%     0.4930
%     0.3180
%     0.1204

% t2:329*1
% 一中多元统计距离,记录的是每一个观察量到中心的距离
%% 如何提取主成分,达到降为的目的
% 通过latent,可以知道提取前几个主成分就可以了.
figure;
percent_explained = 100*latent/sum(latent);
pareto(percent_explained);
xlabel('主成分因子');
ylabel('方差贡献率 (%)');
%coef的每一列代表一个新生成的主成分的系数,coef(:,1:5)代表取出前两个主成分的系数
pca3 = coef(:,1:5);
after_princomp=score*pca3;
