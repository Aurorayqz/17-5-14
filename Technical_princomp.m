function [after_princomp]=Technical_princomp(data)
%% pre-process
stdr = std(data);
sr = data./repmat(stdr,size(data,1),1);
%% use princomp 
[coef,score,latent,t2] = pca(sr);
%% �����������

% coef:9*9
% ���ɷ�ϵ��:��ԭʼ������������������ɷ�������ÿһά����ǰ���ϵ��.
% coef��ÿһ�д���һ�������ɵ����ɷֵ�ϵ��.
% ��������ȡ��ǰ�������ɷֵ�ϵ��,�����¿�ʵ��:pca3 = coef(:,1:3);

% score:329*9
% �������:���ɷֵ÷�
% ��ԭʼ�����������ɵ����ɷֿռ��������ֵ.

% latent:9*1
% һ��������,��sr��Э������������ֵ���.
% �� latent = sort(eig(cov(sr)),'descend');
% ��������:
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
% һ�ж�Ԫͳ�ƾ���,��¼����ÿһ���۲��������ĵľ���
%% �����ȡ���ɷ�,�ﵽ��Ϊ��Ŀ��
% ͨ��latent,����֪����ȡǰ�������ɷ־Ϳ�����.
figure;
percent_explained = 100*latent/sum(latent);
pareto(percent_explained);
xlabel('���ɷ�����');
ylabel('������� (%)');
%coef��ÿһ�д���һ�������ɵ����ɷֵ�ϵ��,coef(:,1:5)����ȡ��ǰ�������ɷֵ�ϵ��
pca3 = coef(:,1:5);
after_princomp=score*pca3;
