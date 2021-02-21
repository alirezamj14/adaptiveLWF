function [Dataset1,Dataset2,DatasetJ]=SplitData(MyData)                    

X_train=MyData.X_train;
T_train=MyData.T_train;
X_test=MyData.X_test;
T_test=MyData.T_test;

Q=size(T_train,1);
Q1=floor(Q/2);

class_ind1=randperm(Q,Q1);
class_ind2=setdiff(1:Q,class_ind1);

ind_train1=find(sum(T_train(class_ind1,:),1));
ind_test1=find(sum(T_test(class_ind1,:),1));
ind_train2=find(sum(T_train(class_ind2,:),1));
ind_test2=find(sum(T_test(class_ind2,:),1));

Dataset1.X_train=X_train(:,ind_train1);
Dataset1.T_train=[T_train(class_ind1,ind_train1);zeros(Q-Q1,length(ind_train1))];
Dataset1.X_test=X_test(:,ind_test1);
Dataset1.T_test=[T_test(class_ind1,ind_test1);zeros(Q-Q1,length(ind_test1))];
Dataset1.Q1=Q1;

Dataset2.X_train=X_train(:,ind_train2);
Dataset2.T_train=[zeros(Q1,length(ind_train2));T_train(class_ind2,ind_train2)];
Dataset2.X_test=X_test(:,ind_test2);
Dataset2.T_test=[zeros(Q1,length(ind_test2));T_test(class_ind2,ind_test2)];

DatasetJ.X_train=[Dataset1.X_train,Dataset2.X_train];
DatasetJ.X_test=[Dataset1.X_test,Dataset2.X_test];
DatasetJ.T_train=[Dataset1.T_train,Dataset2.T_train];
DatasetJ.T_test=[Dataset1.T_test,Dataset2.T_test];
DatasetJ.Q1=Q;

end
