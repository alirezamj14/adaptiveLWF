function [MyData]=Load_dataset(Dataset)
%%  NOTE:
%
%   In case you want to test your own dataset, note that the arrangment of
%   the output of this function must be as follows:
%
%   training_feats: A matrix with N columns and P rows, where N is the number of
%                   the training samples and P is the dimension of each sample
%
%   H_train:        A matrix with N columns and Q rows, where N is the number of
%                   the training samples and Q is the dimension of the target
%                   (In classification: each columns has only one element "1"
%                   indicating the class and the rest of the elements are "0")
%
%   testing_feats:  A matrix with M columns and P rows, where M is the number of
%                   the testing samples and P is the dimension of each sample
%
%   H_test:        A matrix with M columns and Q rows, where M is the number of
%                   the testing samples and Q is the dimension of the target
%                   (In classification: each columns has only one element "1"
%                   indicating the class and the rest of the elements are "0")
%
%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % %           Classification Datasets         % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

switch Dataset
    
    case {'Vowel'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %   Vowel database
        % %   Data_dimension=10, Sample_number=990, Label_number=11
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('Vowel.mat')
        Train_num=48*11;
        Test_num=42*11;
        MyData.X_train=featureMat(:,1:Train_num);
        MyData.T_train=labelMat(:,1:Train_num);
        MyData.X_test=featureMat(:,1+Train_num:Train_num+Test_num);
        MyData.T_test=labelMat(:,1+Train_num:Train_num+Test_num);
        
    case {'ExtendedYaleB'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %   Extended YaleB database
        % %   Data_dimension=504, Sample_number=2414, Label_number=38
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        load('ExtendedYaleB.mat')
        Train_num=1600;
        Test_num=800;
        Rand_index=randperm(size(featureMat,2));
        featureMatR=featureMat(:,Rand_index);
        labelMatR=labelMat(:,Rand_index);
        MyData.X_train=featureMatR(:,1:Train_num);
        MyData.T_train=labelMatR(:,1:Train_num);
        MyData.X_test=featureMatR(:,1+Train_num:Train_num+Test_num);
        MyData.T_test=labelMatR(:,1+Train_num:Train_num+Test_num);
        
    case {'AR'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %   AR database
        % %   Data_dimension=540, Sample_number=2600, Label_number=100
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('AR.mat')
        Train_num=1800;
        Test_num=800;
        Rand_index=randperm(size(featureMat,2));
        featureMatR=featureMat(:,Rand_index);
        labelMatR=labelMat(:,Rand_index);
        MyData.X_train=featureMatR(:,1:Train_num);
        MyData.T_train=labelMatR(:,1:Train_num);
        MyData.X_test=featureMatR(:,1+Train_num:Train_num+Test_num);
        MyData.T_test=labelMatR(:,1+Train_num:Train_num+Test_num);
        
    case {'Satimage'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Satimage database
        %   Data_dimension=36, Sample_number=4435(train)+2000(test), Label_number=7
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('Satimage.mat')
        Train_num=4435;
        Test_num=2000;
        MyData.X_train=train_x(:,1:Train_num);
        MyData.X_test=test_x(:,1:Test_num);
        MyData.T_train=train_y(:,1:Train_num);
        MyData.T_test=test_y(:,1:Test_num);
        
    case {'Caltech101'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %   Caltech101 database
        % %   Data_dimension=3000, Sample_number=9144, Label_number=102
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('Caltech101.mat')
        Train_num=6000;
        Test_num=3144;
        Rand_index=randperm(size(featureMat,2));
        featureMatR=featureMat(:,Rand_index);
        labelMatR=labelMat(:,Rand_index);
        MyData.X_train=featureMatR(:,1:Train_num);
        MyData.T_train=labelMatR(:,1:Train_num);
        MyData.X_test=featureMatR(:,1+Train_num:Train_num+Test_num);
        MyData.T_test=labelMatR(:,1+Train_num:Train_num+Test_num);
        
    case {'Letter'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Letter database
        %   Data_dimension=16, Sample_number=20000, Label_number=26
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('Letter.mat')
        Train_num=13333;
        Test_num=6667;
        Rand_index=randperm(size(featureMat,2));
        featureMatR=featureMat(:,Rand_index);
        labelMatR=labelMat(:,Rand_index);
        MyData.X_train=featureMatR(:,1:Train_num);
        MyData.T_train=labelMatR(:,1:Train_num);
        MyData.X_test=featureMatR(:,1+Train_num:Train_num+Test_num);
        MyData.T_test=labelMatR(:,1+Train_num:Train_num+Test_num);
        
    case {'NORB'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   NORB database
        %   Data_dimension=2048, Sample_number=24300(train)+24300(test), Label_number=5
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('NORB.mat')
        Train_num=24300;
        Test_num=24300;
        MyData.X_train=train_x(1:Train_num,:)';
        MyData.X_test=test_x(1:Test_num,:)';
        MyData.T_train=train_y(1:Train_num,:)';
        MyData.T_test=test_y(1:Test_num,:)';
        
    case {'Shuttle'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Shuttle database
        %   Data_dimension=9, Sample_number=43500(train)+14500(test), Label_number=7
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('Shuttle.mat')
        Train_num=43500;
        Test_num=14500;
        MyData.X_train=train_x(:,1:Train_num);
        MyData.X_test=test_x(:,1:Test_num);
        MyData.T_train=train_y(:,1:Train_num);
        MyData.T_test=test_y(:,1:Test_num);
        
    case {'MNIST'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   MNIST database
        %   Data_dimension=784, Sample_number=60000(train)+10000(test), Label_number=10
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('MNIST.mat')
        Train_num=60000;
        Test_num=10000;
        MyData.X_train=train_x(:,1:Train_num);
        MyData.X_test=test_x(:,1:Test_num);
        MyData.T_train=train_y(:,1:Train_num);
        MyData.T_test=test_y(:,1:Test_num);
        
    case {'CIFAR-10'}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   CIFAR-10 database
        %   Data_dimension=3072, Sample_number=50000(train)+10000(test), Label_number=10
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        load('CIFAR-10.mat')
        Train_num=50000;
        Test_num=10000;
        MyData.X_train=train_x(:,1:Train_num);
        MyData.X_test=test_x(:,1:Test_num);
        MyData.T_train=train_y(:,1:Train_num);
        MyData.T_test=test_y(:,1:Test_num);
        
end
end