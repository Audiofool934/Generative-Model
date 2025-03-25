%ComputeMarginal Computes the marginal over a set of given variables
%   M = ComputeMarginal(V, F, E) computes the marginal over variables V
%   in the distribution induced by the set of factors F, given evidence E
%
%   M is a factor containing the marginal over variables V
%   V is a vector containing the variables in the marginal e.g. [1 2 3] for
%     X_1, X_2 and X_3.
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%   E is an N-by-2 matrix, each row being a variable/value pair. 
%     Variables are in the first column and values are in the second column.
%     If there is no evidence, pass in the empty matrix [] for E.


function M = ComputeMarginal(V, F, E)

% Check for empty factor list
if (numel(F) == 0)
      warning('Warning: empty factor list');
      M = struct('var', [], 'card', [], 'val', []);      
      return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% M should be a factor
% Remember to renormalize the entries of M!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step 1: Apply evidence to all factors
F_with_evidence = ObserveEvidence(F, E);

% Step 2: Calculate joint distribution by multiplying all factors
joint = F_with_evidence(1);
for i = 2:length(F_with_evidence)
    joint = FactorProduct(joint, F_with_evidence(i));
end

% Step 3: Marginalize out variables not in V
vars_to_marginalize = setdiff(joint.var, V);
if ~isempty(vars_to_marginalize)
    M = FactorMarginalization(joint, vars_to_marginalize);
else
    M = joint;
end

% Step 4: Normalize the factor
M.val = M.val / sum(M.val);

% M = struct('var', [], 'card', [], 'val', []); % Returns empty factor. Change this.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
