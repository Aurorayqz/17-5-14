%������ϸ��
ylim( [-0.5,1.5] );
zlim( [-2.5,3.5] );
xlim([0,7]);

xlabel('��n��������');
ylabel('��̬�����ǵ����');
title('��̬���棨y��ֵΪ0����� ֵΪ1�����ǻ��ƽ��')  

x=1:78;
plot(x,all_predict_label(:,1),'red',x,all_predict_label(:,2),'red',x,all_predict_label(:,3),'red',x,all_predict_label(:,4),'red',x,all_predict_label(:,5),'red',x,all_predict_label(:,6),'red');

set(gca,'XTick',[1:1:7]) %�ı�x����������ʾ ������Ϊ2

set(gca,'ZTick',[-1:1:2]) %�ı�x����������ʾ ������Ϊ2

[M,N]=size(all_predict_label);
true_all_predict_label=[all_predict_label,zeros(M,1)];
[M,N]=size(true_all_predict_label);
true_all_predict_label=[true_all_predict_label;zeros(1,N)];
% �ƽ�
% ����
% ͭ
% ��
% ��
% Ǧ
% ��
% ���Ƹ�

set(gca,'xtick',[1 2 3 4 5 6 7],'xticklabel',{'                        �ƽ�','                            ����','                            ͭ','                            ��','                            Ǧ','                            ���Ƹ�',' '})
title('�������������Լ�ڹ��н������ڵ��ʽ��������ɫ������������ɫ�������룩')  ;
ylabel('��y��������');