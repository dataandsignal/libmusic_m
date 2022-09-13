% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% lm_spectral_subspace_decomposition
% 
% Decompose noisy signal space Vy into pure signal space Vx
% and noise signal space Ve.
%
% date: August 2022

classdef lm_spectral_subspace_decomposition < handle
    properties
        y    % (in) vectpr of N samples
        M    % (in) autocorrelation order
        P2   % (in) dimension of pure signal space (if number of pure signals
        % is P, then for real signals it should be 2P, for complex use P
    end
    methods
        function d = lm_spectral_subspace_decomposition(M, P2)
            if nargin < 2
                error("Err, 2 arguments required: M, P2");
            else
                if M < P2
                    error("Err, M < 2P");
                end
                d.M = M;
                d.P2 = P2;
            end
        end

        function [Vy,Vx,Ve,A,Ry] = decompose(d, y)
            y = y(:).';
            if length(y) <= d.M
                error("Err, N must be > M");
            end
            [~, Ry] = corrmtx(y(:), d.M, 'cov');
            [~, A, Vy] = svd(Ry, 0);
            n = size(Vy,2);
            if n <= d.P2
                error("Computed noisy signal space dimension " + n + ...
                    " too short for required signal space dimension P2 (" ...
                    + d.P2 + "). Consider decreasing signal space dimension " + ...
                    "or increasing autocorrelation order and/or samples count");
            end
            Vx = Vy(:, 1:d.P2);
            Ve = Vy(:, d.P2+1:end);
        end
    end
end