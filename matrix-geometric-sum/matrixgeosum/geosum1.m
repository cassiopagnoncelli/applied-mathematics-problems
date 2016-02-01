% Calculates M + M^2 + M^3 + ... + M^n
function [R] = geosum1(M)
  n = length(M);
  r = M;
  for i = 2:n
      r = r + M^i;
  end
  R = r;
end
