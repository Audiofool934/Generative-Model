% FactorMarginalization Sums given variables out of a factor.
%   B = FactorMarginalization(A,V) computes the factor with the variables
%   in V summed out. The factor data structure has the following fields:
%       .var    Vector of variables in the factor, e.g. [1 2 3]
%       .card   Vector of cardinalities corresponding to .var, e.g. [2 2 2]
%       .val    Value table of size prod(.card)
%
%   The resultant factor should have at least one variable remaining or this
%   function will throw an error.
% 
%   See also FactorProduct.m, IndexToAssignment.m, and AssignmentToIndex.m

function B = FactorMarginalization(A, V)

% Check for empty factor or variable list
if (isempty(A.var) || isempty(V)), B = A; return; end; % 边界情况

% Construct the output factor over A.var \ V (the variables in A.var that are not in V)
% and mapping between variables in A and B
[B.var, mapB] = setdiff(A.var, V); % setdiff(A,B) 返回在A中但不在B中的元素，最后输出向量的元素；mapB是B.var在A.var中的位置；

% Check for empty resultant factor
if isempty(B.var)
  error('Error: Resultant factor has empty scope');
end;

% Initialize B.card and B.val
B.card = A.card(mapB);
B.val = zeros(1, prod(B.card));

% Compute some helper indices
% These will be very useful for calculating B.val
% so make sure you understand what these lines are doing
assignments = IndexToAssignment(1:length(A.val), A.card);
  % This function (which is assumed to be defined elsewhere) converts each linear index in the range 1 to length(A.val) into an assignment of values to the variables in A.var. The A.card vector provides the cardinalities of these variables. The result, assignments, is a matrix where each row represents a unique assignment, and each column corresponds to a variable in A.var.
indxB = AssignmentToIndex(assignments(:, mapB), B.card);
  % AssignmentToIndex(assignments(:, mapB), B.card): This function (also assumed to be defined elsewhere) takes the assignments for the variables in B.var (obtained by selecting the appropriate columns from the assignments matrix using mapB) and converts them back into linear indices. These indices, stored in indxB, represent the positions in B.val where the corresponding values from A.val need to be accumulated.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Correctly populate the factor values of B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B.val = accumarray(indxB(:), A.val(:), [prod(B.card), 1])';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
