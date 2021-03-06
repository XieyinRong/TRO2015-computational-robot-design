function bnds = CTRCreateMinimizationBounds(ctr, base_workspace, mopts)
%
% FUNCTION
%   CTRCREATEMINIMIZATIONBOUNDS creates a vector with the minimization
%   boundaries for the CTROptimize function, based on what to minimize
%   (MOPTS), and the given parameters.
%
% USAGE
%   BNDS = CTRCREATEMINIMIZATIONBOUNDS(CTR, BASE_WORKSPACE, MOPTS).
%
% INPUT
%   CTR: A (simple) concentric tube robot structure.
%   BASE_WORKSPACE: The are where the base is allowed to move in.
%   MOPTS: A cell of strings describing what to minimize for.
%
% OUTPUT
%   BNDS: A 2xN vector containining the bounds. First row containts the
%   minimimum values, second row the maximum values. Values are arranged in
%   order 'lenghts', 'curvatures', 'base'.
%
% AUTHOR
%   Christos Bergeles
%
% DATE
%   2012.06.19
%

  if nargin < 2
    error('CTRCreateMinimizationBounds: Two input arguments are required.');
  end
  
  mopts = sort(mopts);
  
  for i = length(mopts):-1:1
    
    switch mopts{i}
      
      case 'lengths'
        
        x_min.lengths = zeros(1, 2*length(ctr));
        x_max.lengths = 60e-3*ones(1, 2*length(ctr));
        
      case 'lengths_curved'
        
        x_min.lengths_curved = [ctr(:).c_len_min];
        x_max.lengths_curved = [ctr(:).c_len_max];
        
      case 'curvatures'
        
        x_min.curvatures = [ctr(:).u_min];
        x_max.curvatures = [ctr(:).u_max];
        
      case 'base'
        
        x_min.base = [min(base_workspace(:, 1)) ...
                      min(base_workspace(:, 2)) ...
                      min(base_workspace(:, 3))];
        x_max.base = [max(base_workspace(:, 1)) ...
                      max(base_workspace(:, 2)) ...
                      max(base_workspace(:, 3))];
                    
    end
  end
  
  % Vectorize
  bnds = [];
  if isfield(x_min, 'lengths')
    bnds = [bnds [x_min.lengths; x_max.lengths]];
  end
  if isfield(x_min, 'lengths_curved')
    bnds = [bnds [x_min.lengths_curved; x_max.lengths_curved]];
  end
  if isfield(x_min, 'curvatures')
    bnds = [bnds [x_min.curvatures; x_max.curvatures]];
  end
  if isfield(x_min, 'base')
    bnds = [bnds [x_min.base; x_max.base]];
  end

end                                                                                                                                                                                                                                                                                                                                                                                                                                                                           