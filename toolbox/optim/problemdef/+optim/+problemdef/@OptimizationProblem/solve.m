function[sol,varargout]=solve(prob,varargin)


































































    if nargout>5
        error(message('MATLAB:TooManyOutputs'));
    end


    [sol,varargout{1:nargout-1}]=solveImpl(prob,varargin{:});

end