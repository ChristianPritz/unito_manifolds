function [Y, eigVals] = neural_ISOMAP(X, n_neighbors, n_components)
% neural_ISOMAP - Perform ISOMAP on neural activity data
%
% Inputs:
%   X            - n_samples x n_neurons matrix (neural activity)
%   n_neighbors  - number of neighbors for k-NN graph
%   n_components - dimensionality of the manifold embedding
%
% Outputs:
%   Y        - n_samples x n_components embedding
%   eigVals  - eigenvalues of the geodesic distance matrix

    if nargin < 3
        n_components = 2; % default 2D manifold
    end
    if nargin < 2
        n_neighbors = 5; % default 5 neighbors
    end

    n_samples = size(X,1);

    %% Step 1: Compute pairwise Euclidean distances
    D = squareform(pdist(X, 'euclidean'));

    %% Step 2: Construct k-NN graph
    INF = 1e10;
    G = INF * ones(n_samples);
    for i = 1:n_samples
        [~, idx] = sort(D(i,:));
        neighbors = idx(2:n_neighbors+1); % exclude self
        G(i, neighbors) = D(i, neighbors);
    end
    G = min(G, G'); % make symmetric

    %% Step 3: Compute shortest paths (geodesic distances)
    % Using Floyd-Warshall algorithm
    for k = 1:n_samples
        disp(k)
        for i = 1:n_samples
            for j = 1:n_samples
                if G(i,j) > G(i,k) + G(k,j)
                    G(i,j) = G(i,k) + G(k,j);
                end
            end
        end
    end

    %% Step 4: Double centering for classical MDS
    H = eye(n_samples) - ones(n_samples)/n_samples;
    K = -0.5 * H * (G.^2) * H;

    %% Step 5: Eigen decomposition
    [V, L] = eig(K);
    [eigVals, idx] = sort(diag(L), 'descend');
    V = V(:, idx);

    %% Step 6: Return low-dimensional embedding
    Y = V(:,1:n_components) .* sqrt(eigVals(1:n_components)');

end