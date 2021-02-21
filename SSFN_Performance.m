%%  Name:   SSFN_Performance
%
%   Generating the performance results of SSFN shown in Table 2 and Table 4
%
%   Data:   Benchmark datasets mentioned in the paper
%
%   Output: Mean and standard deviation and testing accuracy over multiple
%           trials of SSFN for classification
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Paper:              SSFN: Low Complexity Self Size-estimating Feed-forward Neural Network using Layer-wise Convex Optimization
%   Authors:          Saikat Chatterjee, Alireza M. Javid, Mostafa Sadeghi, Shumpei Kikuta, Partha P. Mitra, Mikael Skoglund
%   Organiztion:    KTH Royal Institute of Technology
%   Contact:          Saikat Chatterjee (sach@kth.se), Alireza Javid (almj@kth.se)
%   Website:         www.ee.kth.se/reproducible/
%
%   ***April 2019***

%% begining of the simulation

clc; clear all; %close all;

addpath(genpath('C:\Nobackup\almj\Dropbox\Database\mat files'));
addpath(genpath('Functions'));

a_leaky_RLU=0;      %   set to a small non-zero value if you want to test leaky-RLU
g=@(x) x.*(x >= 0)+a_leaky_RLU*x.*(x < 0);

%%  Choosing a dataset
% Choose one of the following datasets:

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % %       SSFN      % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

Database_name='Vowel';
Parameters.eta_0=1e0;
Parameters.eta_l=1e-3;
Parameters.eta_0_new=1e-3;
Parameters.eta_l_new=1e-2;
Parameters.lam_0=1e-4;
Parameters.lam_l=1e0;
%
% Database_name='ExtendedYaleB';
% Parameters.eta_0=1e5;
% Parameters.eta_l=1e-1;
% Parameters.eta_0_new=1e4;
% Parameters.eta_l_new=1e-3;
% Parameters.lam_0=1e1;
% Parameters.lam_l=Parameters.lam_0;

% Database_name='AR';
% Parameters.eta_0=1e5;
% Parameters.eta_l=1e-1;
% Parameters.eta_0_new=1e4;
% Parameters.eta_l_new=1e-3;
% Parameters.lam_0=1e1;
% Parameters.lam_l=Parameters.lam_0;

% Database_name='Satimage';
% Parameters.eta_0=1e5;
% Parameters.eta_l=1e-2;
% Parameters.eta_0_new=1e5;
% Parameters.eta_l_new=1e1;
% Parameters.lam_0=1e0;
% Parameters.lam_l=Parameters.lam_0;
% 
% Database_name='Caltech101';
% Parameters.eta_0=1e0;
% Parameters.eta_l=1e-8;
% Parameters.eta_0_new=1e-1;
% Parameters.eta_l_new=1e-3;
% Parameters.lam_0=1e1;
% Parameters.lam_l=Parameters.lam_0;


% Dataset1=Load_dataset('ExtendedYaleB');
% Dataset1.Q1=38;
% Dataset2=Load_dataset('AR');
% [ Dataset1.X_train , Dataset2.X_train , DatasetJ.X_train ] = MyConcatX( Dataset1.X_train, Dataset2.X_train );
% [ Dataset1.X_test , Dataset2.X_test , DatasetJ.X_test ] = MyConcatX( Dataset1.X_test, Dataset2.X_test );
% [ Dataset1.T_train , Dataset2.T_train , DatasetJ.T_train ] = MyConcatT( Dataset1.T_train, Dataset2.T_train );
% [ Dataset1.T_test , Dataset2.T_test , DatasetJ.T_test ] = MyConcatT( Dataset1.T_test, Dataset2.T_test );
% DatasetJ.Q1=38;
% 
% Parameters.eta_0=1e4;                       %%%%%%%     For Joint Training -> L=0 gives around 78%          L=10 gives aroung 96.5%
% Parameters.eta_l=1e-1;

%
% Database_name='Letter';
% Parameters.eta_0=1e0;
% Parameters.eta_l=1e-3;
% Parameters.eta_0_new=1e0;
% Parameters.eta_l_new=1e-5;
% Parameters.lam_0=1e0;
% Parameters.lam_l=Parameters.lam_0;


% Database_name='NORB';
% Parameters.eta_0=1e0;
% Parameters.eta_l=1e-3;
% Parameters.eta_0_new=1e0;
% Parameters.eta_l_new=1e-5;
% Parameters.lam_0=1e0;
% Parameters.lam_l=Parameters.lam_0;

% Database_name='Shuttle';
% Parameters.eta_0=1e0;
% Parameters.eta_l=1e0;
% Parameters.eta_0_new=1e6;
% Parameters.eta_l_new=1e0;
% Parameters.lam_0=1e0;
% Parameters.lam_l=Parameters.lam_0;
% 
% Database_name='MNIST';
% Parameters.eta_0=1e1;
% Parameters.eta_l=1e-2;
% Parameters.eta_0_new=1e1;
% Parameters.eta_l_new=1e-2;
% Parameters.lam_0=1e0;
% Parameters.lam_l=Parameters.lam_0;

% Database_name='CIFAR-10';
% Parameters.eta_0=1e2;
% Parameters.eta_l=1e-3;
% Parameters.eta_0_new=1e0;
% Parameters.eta_l_new=1e-3;
% Parameters.lam=1e1;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

%   Loading the dataset
MyData=Load_dataset(Database_name);
% T_train(T_train<0)=0;
% T_test(T_test<0)=0;
[Dataset1,Dataset2,DatasetJ]=SplitData(MyData);

% Dataset1=Load_dataset('ExtendedYaleB');
% Dataset1.Q1=38;
% Dataset2=Load_dataset('AR');
% [ Dataset1.X_train , Dataset2.X_train , DatasetJ.X_train ] = MyConcatX( Dataset1.X_train, Dataset2.X_train );
% [ Dataset1.X_test , Dataset2.X_test , DatasetJ.X_test ] = MyConcatX( Dataset1.X_test, Dataset2.X_test );
% [ Dataset1.T_train , Dataset2.T_train , DatasetJ.T_train ] = MyConcatT( Dataset1.T_train, Dataset2.T_train );
% [ Dataset1.T_test , Dataset2.T_test , DatasetJ.T_test ] = MyConcatT( Dataset1.T_test, Dataset2.T_test );
% DatasetJ.Q1=38;

trialNum=1;

% The perfomance measures we are interested in
accuracy_Joint=[];
accuracy_Old=[];
accuracy_New=[];

accuracy_Old_adj=[];
accuracy_New_adj=[];
accuracy_Joint_adj=[];

accuracy_Old_J=[];
accuracy_New_J=[];
accuracy_Joint_J=[];

%   Generating the set of nodes in each layer
Parameters.NumNodes=1000;
Parameters.L=10;

Parameters.eta_0=1e0;
Parameters.eta_l=1e-3;
Parameters.eta_0_new=1e0;
Parameters.eta_l_new=1e-3;
Parameters.lam_0=1e0;
Parameters.lam_l=1e0;

JointTraining='No';
LwF='Yes';

sweep=10.^(-10:10);     logScale=1;
% sweep=1:1:(Parameters.L+1);           logScale=0;

for i=1:length(sweep)
        Parameters.eta_l_new=sweep(i);
        
        Parameters.lam_l=Parameters.lam_0;
% MyData=Load_dataset(Database_name);
% % T_train(T_train<0)=0;
% % T_test(T_test<0)=0;
% [Dataset1,Dataset2,DatasetJ]=SplitData(MyData);
    
%     [D1_adj,D2_adj,D1D2_adj]=SSFN_LwF_adjust(Dataset1, Dataset2, DatasetJ, g, Parameters, LwF, 'No');
    
    [D1,D2,D1D2]=SSFN_LwF_adjust2(Dataset1, Dataset2, DatasetJ, g, Parameters, LwF, JointTraining);
    
    switch LwF
        case{'Yes'}
            accuracy_Old=[accuracy_Old,D1.test_accuracy_new(end)];
            accuracy_New=[accuracy_New,D2.test_accuracy(end)];
            accuracy_Joint=[accuracy_Joint,D1D2.test_accuracy(end)];
            
%             accuracy_Old_adj=[accuracy_Old_adj,D1_adj.test_accuracy_new(end)];
%             accuracy_New_adj=[accuracy_New_adj,D2_adj.test_accuracy(end)];
%             accuracy_Joint_adj=[accuracy_Joint_adj,D1D2_adj.test_accuracy(end)];
%             
%             accuracy_Old_J=[accuracy_Old_J,D1.test_accuracy_J(end)];
%             accuracy_New_J=[accuracy_New_J,D2.test_accuracy_J(end)];
%             accuracy_Joint_J=[accuracy_Joint_J,D1D2.test_accuracy_J(end)];

            figure(1)
            plot(sweep(1:length(accuracy_Old)),accuracy_Old,'r--','LineWidth',2)
            hold on
            plot(sweep(1:length(accuracy_New)),accuracy_New,'g:','LineWidth',2)
            plot(sweep(1:length(accuracy_Joint)),accuracy_Joint,'b','LineWidth',2)
            set(gca, 'XScale', 'log')
            grid on
            hold off
            drawnow
            
            accuracy_OldS=[D1.test_accuracy_new];
            accuracy_NewS=[D2.test_accuracy];
            accuracy_JointS=[D1D2.test_accuracy];
            figure(2)
            plot(1:length(accuracy_OldS),accuracy_OldS,'r','LineWidth',2)
            hold on
            plot(1:length(accuracy_NewS),accuracy_NewS,'g','LineWidth',2)
            plot(1:length(accuracy_JointS),accuracy_JointS,'b','LineWidth',2)
            grid on
            hold off
            drawnow
            
%             accuracy_OldS=[D1_adj.test_accuracy_new];
%             accuracy_NewS=[D2_adj.test_accuracy];
%             accuracy_JointS=[D1D2_adj.test_accuracy];
%             figure(3)
%             plot(1:length(accuracy_OldS),accuracy_OldS,'r','LineWidth',2)
%             hold on
%             plot(1:length(accuracy_NewS),accuracy_NewS,'g','LineWidth',2)
%             plot(1:length(accuracy_JointS),accuracy_JointS,'b','LineWidth',2)
%             grid on
%             hold off
%             drawnow
            
        case{'No'}
                        accuracy_Old=[accuracy_Old,D1.test_accuracy(end)];
%             accuracy_Old=[D1.test_accuracy];
            figure(1)
            plot(sweep(1:length(accuracy_Old)),accuracy_Old,'r','LineWidth',2)
            hold on
            if logScale==1
                set(gca, 'XScale', 'log')
            end
            grid on
            hold off
            drawnow
    end
end


My_accuracyO=mean(accuracy_Old);
My_accuracyN=mean(accuracy_New);
My_accuracyJ=mean(accuracy_Joint);

My_accuracyO_J=mean(accuracy_Old_J);
My_accuracyN_J=mean(accuracy_New_J);
My_accuracyJ_J=mean(accuracy_Joint_J);

My_accuracyO_adj=mean(accuracy_Old_adj);
My_accuracyN_adj=mean(accuracy_New_adj);
My_accuracyJ_adj=mean(accuracy_Joint_adj);

% Displaying the results of SSFN
disp(['Joint training performance results of "',Database_name,'" dataset:'])
disp([ 'Test accuracy old = ',num2str(100*My_accuracyO_J),...
    ', Test accuracy new = ',num2str(100*My_accuracyN_J),...
    ', Test accuracy joint= ',num2str(100*My_accuracyJ_J)])

disp(['LwF performance results of "',Database_name,'" dataset:'])
disp([ 'Test accuracy old = ',num2str(100*My_accuracyO),...
    ', Test accuracy new = ',num2str(100*My_accuracyN),...
    ', Test accuracy joint= ',num2str(100*My_accuracyJ)])

disp(['UQ LwF performance results of "',Database_name,'" dataset:'])
disp([ 'Test accuracy old = ',num2str(100*My_accuracyO_adj),...
    ', Test accuracy new = ',num2str(100*My_accuracyN_adj),...
    ', Test accuracy joint= ',num2str(100*My_accuracyJ_adj)])

% MyPlot( accuracy_Old , accuracy_New )
% Caltech_accuracy_Old=accuracy_Old;
% Caltech_accuracy_New=accuracy_New;
