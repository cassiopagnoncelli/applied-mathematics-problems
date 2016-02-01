function [R] = geosum3(M)
  R = matrixgeosum(M, length(M)) - eye(length(M));
end
