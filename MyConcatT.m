function [D1T,D2T,C]=MyConcatT(A,B)
sA = size(A);
sB = size(B);
D1T=[ A ; zeros( [ sB(1) , sA(2) ] ) ];
D2T=[ zeros( [ sA(1) , sB(2) ] ) ; B ];
C = [ D1T , D2T ];
end