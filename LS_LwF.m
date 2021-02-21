function O=LS_LwF(T, Y_new, Y_old, O_old, lam, eta)
Q=size(T,1);
Q1=floor(Q/2);

n=size(Y_new,1);
YYT_old=Y_old * Y_old';

% O2=T * Y_new' / (Y_new * Y_new' + eta * 1 *eye(n));
O2=T * Y_new' / (Y_new * Y_new' + eta * lam *eye(n));

O1=O_old * YYT_old / (YYT_old + (eta/lam) * eye(n));

O=[O1(1:Q1,:);O2(Q1+1:end,:)];
end