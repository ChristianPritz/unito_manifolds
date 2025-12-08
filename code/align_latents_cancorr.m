function aligned_latents = align_latents_procrustes(latents, ref_idx, varargin)
% Align latent trajectories across animals to a reference using orthogonal Procrustes.
% Preserves magnitude by default (no scaling).
%
% latents{a} : 3 x n_a   (columns = matched timepoints/conditions; some columns may be NaN)
% ref_idx    : index of reference animal in 'latents'
%
% Options (name/value):
%   'AllowScaling'    (false|true) default false  -> if true, allow a single uniform scale
%   'AllowReflection' (false|true) default false  -> if true, allow mirror flip
%   'MinPairs'        integer      default 3      -> min shared (non-NaN) columns to fit transform

p = inputParser;
addParameter(p,'AllowScaling',false,@islogical);
addParameter(p,'AllowReflection',false,@islogical);
addParameter(p,'MinPairs',3,@(x) isnumeric(x) && isscalar(x));
parse(p,varargin{:});
allowScaling    = p.Results.AllowScaling;
allowReflection = p.Results.AllowReflection;
minPairs        = p.Results.MinPairs;

n_animals = numel(latents);
aligned_latents = latents; % initialize
Xref_all = latents{ref_idx}'; % n_ref x 3 (rows are samples)

for a = 1:n_animals
    if a == ref_idx, continue; end
    Xa_all = latents{a}';      % n_a x 3

    % shared, fully observed columns
    valid = all(~isnan(Xref_all),2) & all(~isnan(Xa_all),2);
    if sum(valid) < minPairs
        warning('Animal %d: not enough shared points to fit transform. Leaving unchanged.', a);
        aligned_latents{a} = latents{a};
        continue;
    end

    Xr = Xref_all(valid,:);   % n_shared x 3
    Xa = Xa_all(valid,:);     % n_shared x 3

    % Compute Procrustes transform (manual, to control scaling/reflection)
    muX = mean(Xa,1);
    muY = mean(Xr,1);
    Xc = Xa - muX;            % center
    Yc = Xr - muY;

    C = Xc' * Yc;             % 3x3 cross-covariance
    [U,S,V] = svd(C);
    R = U*V';                  % rotation (possibly reflection)

    % optionally forbid reflection
    if ~allowReflection && det(R) < 0
        U(:,end) = -U(:,end);
        R = U*V';
    end

    if allowScaling
        % uniform scale (least-squares)
        s = trace(S) / sum(Xc(:).^2);
    else
        s = 1;
    end

    t = muY - s*(muX*R);       % translation row vector 1x3

    % Apply to all columns (preserves NaNs)
    Xall_centered = Xa_all - muX;         % NaN rows stay NaN
    Zall = s*(Xall_centered * R) + muY;   % n_a x 3

    aligned_latents{a} = Zall';           % back to 3 x n_a
end
end