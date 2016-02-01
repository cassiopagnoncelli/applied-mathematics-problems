% Calculates I + M + M^2 + M^3 + ... + M^(n-1) + M^n.
function [R] = matrixgeosum(M, n)
  l = length(M);
  if n == 0,
      R = eye(l);
  elseif n == 1,
      R = eye(l) + M;
  elseif mod(n, 2) == 0,
      R = M^n + matrixgeosum(M, n-1);
  else
      R = (eye(l) + M) * matrixgeosum(M^2, floor(n/2));
  end 
end
