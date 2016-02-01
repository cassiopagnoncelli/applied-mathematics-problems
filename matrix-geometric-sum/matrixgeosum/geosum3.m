% Calculates M + M^2 + M^3 + ... + M^n.
function [R] = geosum4(M)
  d = length(M);
  %R = (eye(d) - M)^(-1) * (eye(d) - M^(d+1)) - eye(d);
  R = (eye(d) - M^(d+1))/(eye(d) - M) - eye(d);
  R = round(R);    % eliminate trailing zeros.
end
