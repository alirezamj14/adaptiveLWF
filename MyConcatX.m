function [D1X,D2X,C]=MyConcatX(A,B)
sA = size(A);
sB = size(B);
temp = max(sA(1),sB(1));
D1X=[ A ; zeros( abs( [ temp , 0 ] - sA ) ) ];
D2X=[ B ; zeros( abs( [ temp , 0 ] - sB ) ) ];
C = [ D1X , D2X ];
end