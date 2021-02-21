function [D1,D2,D1D2]=SSFN_LwF_adjust(Dataset1, Dataset2, DatasetJ, g, Parameters, LwF, JointTraining)
%%  Name:   SSFN_LwF

%   Description goes here ...

%%

P=size(Dataset1.X_train,1);  %   Data Dimension
Q=size(Dataset1.T_train,1);
VQ=[eye(Q);-eye(Q)];
Q1=Dataset1.Q1;
% if mod(Q,2)==1
    UQ1=[ eye(Q1) , zeros(Q1,Q-Q1) , -eye(Q1) , zeros(Q1,Q-Q1) ];
% else
%     UQ1=[ eye(Q1) , zeros(Q1,Q1) , -eye(Q1) , zeros(Q1,Q1) ];
% end

D1.train_error=[];
D1.test_error=[];
D1.test_accuracy=[];
D1.train_accuracy=[];

D2.train_error=[];
D2.test_error=[];
D2.test_accuracy=[];
D2.train_accuracy=[];

D1.test_accuracy_new=[];
D1D2.test_accuracy=[];

D1.test_accuracy_J=[];
D2.test_accuracy_J=[];
D1D2.test_accuracy_J=[];

%% First layer Block

%   Initializing the algorithm for the first time
Yi=Dataset1.X_train;
Yi_test=Dataset1.X_test;
%%%%%%%%

W(1).Oi=LS(Dataset1.T_train, Yi, Parameters.eta_0);
T_hat_train=W(1).Oi*Yi;
T_hat_test=W(1).Oi*Yi_test;

D1.train_accuracy(1)=Calculate_accuracy(Dataset1.T_train,T_hat_train);
D1.test_accuracy(1)=Calculate_accuracy(Dataset1.T_test,T_hat_test);
D1.train_error(1)=Calculate_error(Dataset1.T_train,T_hat_train);
D1.test_error(1)=Calculate_error(Dataset1.T_test,T_hat_test);

ni=Parameters.NumNodes;
layer=0;
while layer<Parameters.L
    layer=layer+1;
    
    W(layer).Ri=2*rand( ni , size(Yi,1) ) - 1;     %   Generating the random matrix R
    
    Yi=g([ VQ * T_hat_train ; normc( W(layer).Ri * Yi ) ]);
    Yi_test=g([ VQ * T_hat_test ; normc( W(layer).Ri * Yi_test ) ]);
    
    W(layer+1).Oi=LS(Dataset1.T_train, Yi, Parameters.eta_l);
    
    T_hat_train=W(layer+1).Oi*Yi;
    T_hat_test=W(layer+1).Oi*Yi_test;
    
    D1.train_accuracy=[D1.train_accuracy, Calculate_accuracy(Dataset1.T_train, T_hat_train)];
    D1.test_accuracy=[D1.test_accuracy, Calculate_accuracy(Dataset1.T_test, T_hat_test)];
    D1.train_error=[D1.train_error, Calculate_error(Dataset1.T_train, T_hat_train)];
    D1.test_error=[D1.test_error, Calculate_error(Dataset1.T_test, T_hat_test)];
end

switch LwF
    case {'Yes'}
        % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     New Task
        % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        
        %% First layer Block
        
        %   Initializing the algorithm for the first time
        Yi=Dataset2.X_train;
        Yi_old=Yi;
%         Yi_old=randn(size(Yi));
        %%%%%%%%
        
        
        T_hat_train_old=W(1).Oi*Yi_old;
        W(1).Oi=LS_LwF(Dataset2.T_train, Yi ,Yi, W(1).Oi, Parameters.lam_0, Parameters.eta_0_new);
        T_hat_train=W(1).Oi*Yi;
        
        layer=0;
        while layer<Parameters.L
            layer=layer+1;
            
            Yi=g([ VQ * T_hat_train ; normc( W(layer).Ri * Yi ) ]);
            Yi_old=g([ VQ * T_hat_train_old ; normc( W(layer).Ri * Yi_old ) ]);
            
            if layer>5
                W(layer+1).Oi(1:Q1,:)=[ UQ1 , zeros( Q1 , ni ) ];
            end
            T_hat_train_old=W(layer+1).Oi*Yi_old;
            W(layer+1).Oi=LS_LwF(Dataset2.T_train, Yi, Yi, W(layer+1).Oi, Parameters.lam_l, Parameters.eta_l_new);
            %         if layer>=1
            %             W(layer+1).Oi(1:Q1,:)=[ UQ1 , zeros( Q1 , ni ) ];
            %         end
            T_hat_train=W(layer+1).Oi*Yi;
            
        end
        
        % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     Testing Both
        % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        
        %% First layer Block
        
        %   Initializing the algorithm for the first time
        Yi_test_1=Dataset1.X_test;
        Yi_test_2=Dataset2.X_test;
        Yi_test_J=DatasetJ.X_test;
        T_test_Joint=DatasetJ.T_test;
        %%%%%%%%
        
        layer=0;
        while layer<Parameters.L
            layer=layer+1;
            
            %%%%%%%%%%  Test Old
            T_hat_test_1=W(layer).Oi*Yi_test_1;
            Yi_test_1=g([ VQ * T_hat_test_1 ; normc( W(layer).Ri * Yi_test_1 ) ]);
            D1.test_accuracy_new=[D1.test_accuracy_new, Calculate_accuracy(Dataset1.T_test, T_hat_test_1)];
            
            %%%%%%%%%%  Test New
            T_hat_test_2=W(layer).Oi*Yi_test_2;
            Yi_test_2=g([ VQ * T_hat_test_2 ; normc( W(layer).Ri * Yi_test_2 ) ]);
            D2.test_accuracy=[D2.test_accuracy, Calculate_accuracy(Dataset2.T_test, T_hat_test_2)];
            
            %%%%%%%%%%  Test Joint
            T_hat_test_J=W(layer).Oi*Yi_test_J;
            Yi_test_J=g([ VQ * T_hat_test_J ; normc( W(layer).Ri * Yi_test_J ) ]);
            D1D2.test_accuracy=[D1D2.test_accuracy, Calculate_accuracy(T_test_Joint, T_hat_test_J)];
        end
        
        T_hat_test_1=W(layer+1).Oi*Yi_test_1;
        D1.test_accuracy_new=[D1.test_accuracy_new, Calculate_accuracy(Dataset1.T_test, T_hat_test_1)];
        
        T_hat_test_2=W(layer+1).Oi*Yi_test_2;
        D2.test_accuracy=[D2.test_accuracy, Calculate_accuracy(Dataset2.T_test, T_hat_test_2)];
        
        T_hat_test_J=W(layer+1).Oi*Yi_test_J;
        D1D2.test_accuracy=[D1D2.test_accuracy, Calculate_accuracy(T_test_Joint, T_hat_test_J)];
end

switch JointTraining
    case{'Yes'}
% % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     Joint Training
% % % % % % % % % % % % % % % % % % % % % % % % % % % %

%   Initializing the algorithm for the first time
Yi_J=DatasetJ.X_train;
%%%%%%%%

W(1).Oi=LS(DatasetJ.T_train, Yi_J, Parameters.eta_0);
T_hat_train=W(1).Oi*Yi_J;

layer=0;
while layer<Parameters.L
    layer=layer+1;
    
    Yi_J=g([ VQ * T_hat_train ; normc( W(layer).Ri * Yi_J ) ]);
    W(layer+1).Oi=LS(DatasetJ.T_train, Yi_J, Parameters.eta_l);
    T_hat_train=W(layer+1).Oi*Yi_J;
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % %    Testing

%   Initializing the algorithm for the first time
Yi_test_1=Dataset1.X_test;
Yi_test_2=Dataset2.X_test;
Yi_test_J=DatasetJ.X_test;
%%%%%%%%

layer=0;
while layer<Parameters.L
    layer=layer+1;
    
    %%%%%%%%%%  Test Old
    T_hat_test_1=W(layer).Oi*Yi_test_1;
    Yi_test_1=g([ VQ * T_hat_test_1 ; normc( W(layer).Ri * Yi_test_1 ) ]);
    D1.test_accuracy_J=[D1.test_accuracy_J, Calculate_accuracy(Dataset1.T_test, T_hat_test_1)];
    
    %%%%%%%%%%  Test New
    T_hat_test_2=W(layer).Oi*Yi_test_2;
    Yi_test_2=g([ VQ * T_hat_test_2 ; normc( W(layer).Ri * Yi_test_2 ) ]);
    D2.test_accuracy_J=[D2.test_accuracy_J, Calculate_accuracy(Dataset2.T_test, T_hat_test_2)];
    
    %%%%%%%%%%  Test Joint
    T_hat_test_J=W(layer).Oi*Yi_test_J;
    Yi_test_J=g([ VQ * T_hat_test_J ; normc( W(layer).Ri * Yi_test_J ) ]);
    D1D2.test_accuracy_J=[D1D2.test_accuracy_J, Calculate_accuracy(DatasetJ.T_test, T_hat_test_J)];
end

T_hat_test_1=W(layer+1).Oi*Yi_test_1;
D1.test_accuracy_J=[D1.test_accuracy_J, Calculate_accuracy(Dataset1.T_test, T_hat_test_1)];

T_hat_test_2=W(layer+1).Oi*Yi_test_2;
D2.test_accuracy_J=[D2.test_accuracy_J, Calculate_accuracy(Dataset2.T_test, T_hat_test_2)];

T_hat_test_J=W(layer+1).Oi*Yi_test_J;
D1D2.test_accuracy_J=[D1D2.test_accuracy_J, Calculate_accuracy(T_test_Joint, T_hat_test_J)];

end

return
