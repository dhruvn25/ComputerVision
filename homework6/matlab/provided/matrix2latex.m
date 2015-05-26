function out = matrix2latex(mat, precision, col_labels)
    % Helper to convert a matrix to latex formated array
    % Author: Arun Venkatraman
    
    if nargin < 2
        precision = 3; % number of digits in the output
    end
    
    d1 = digits(precision); % records and sets accuracy
    sym_mat = sym(mat);
    if (nargin >= 3)
        sym_full = [sym(col_labels); sym_mat];
    else
        sym_full = sym_mat;
    end
    
    out = latex(vpa(sym_full));
    digits(d1);
end