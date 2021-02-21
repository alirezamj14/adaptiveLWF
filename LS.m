function W_ls=LS(T_train, X_train, lam)                    
P=size(X_train,1);
N=size(X_train,2);
if P < N
    W_ls=(T_train*X_train')/(X_train*X_train'+lam*eye(size(X_train,1)));
else
    W_ls=(T_train/(X_train'*X_train+lam*eye(size(X_train,2))))*X_train';
end

end
