function line = reverseLine(line)
%REVERSELINE Return same line but with opposite orientation.
%
%   INVLINE = reverseLine(LINE);
%   Returns the opposite line of LINE.
%   LINE has the format [x0 y0 dx dy], then INVLINE will have following
%   parameters: [x0 y0 -dx -dy].
%
%   See also:
%   lines2d, createLine

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-01-20
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

%   HISTORY
%   30/06/2009 rename as reverseLine
%   15/03/2011 simplify code

line(:, 3:4) = -line(:, 3:4);

    
