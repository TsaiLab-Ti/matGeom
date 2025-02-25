function varargout = drawLine(varargin)
%DRAWLINE Draw a straight line clipped by the current axis.
%
%   drawLine(LINE);
%   Draws the line LINE on the current axis, by using current axis to clip
%   the line. 
%
%   drawLine(LINE, PARAM, VALUE);
%   Specifies drawing options.
%
%   H = drawLine(...)
%   Returns a handle to the created line object. If clipped line is not
%   contained in the axis, the function returns -1.
%   
%   Example
%     figure; hold on; axis equal;
%     axis([0 100 0 100]);
%     drawLine([30 40 10 20]);
%     drawLine([30 40 20 -10], 'Color', 'm', 'LineWidth', 2);
%     drawLine([-30 140 10 20]);
%
%   See also 
%     lines2d, createLine, drawEdge, clipLine
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2022 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% retrieve line
lin = varargin{1};
varargin(1) = [];

% default style for drawing lines
if length(varargin) ~= 1
    varargin = [{'color', 'b'}, varargin];
end

% extract bounding box of the current axis
xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');

% clip lines with current axis box
clip = clipLine(lin, [xlim ylim]);
ok   = isfinite(clip(:,1));

% initialize result array to invalide handles
h = -1 * ones(size(lin, 1), 1);

% draw valid lines
h(ok) = plot(ax, clip(ok, [1 3])', clip(ok, [2 4])', varargin{:});

% return line handle if needed
if nargout > 0
    varargout = {h};
end
