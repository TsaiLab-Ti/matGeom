function varargout = readMesh(fileName, varargin)
%READMESH Read a 3D mesh by inferring format from file name.
%
%   Usage:
%   [V, F] = readMesh(FILENAME)
%   Read the data stored in file FILENAME and return the vertex and face
%   arrays as NV-by-3 array and NF-by-N array respectively, where NV is the
%   number of vertices and NF is the number of faces.
%
%   [V, F] = readMesh(FILENAME, 'trimMesh', false)
%   By default the memory footprint of the mesh is reduced by deleting
%   duplicate vertices and faces, and unreferenced vertices. Set this
%   option to 'false' if this data should be preserved.
%
%   MESH = readMesh(FILENAME)
%   Read the data stored in file FILENAME and return the mesh into a struct
%   with fields 'vertices' and 'faces'.
%
%   Example
%     mesh = readMesh('apple.ply');
%     figure; drawMesh(mesh);
%     view([180 -70]); axis equal;
%
%   See also 
%     meshes3d, writeMesh, readMesh_off, readMesh_ply, readMesh_stl
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2020-11-20, using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020-2022 INRAE - BIA Research Unit - BIBS Platform (Nantes)

parser = inputParser;
addParameter(parser, 'trimMesh', true, @islogical);
parse(parser, varargin{:});

[~, ~, ext] = fileparts(fileName);
switch lower(ext)
    case '.off'
        mesh = readMesh_off(fileName);
    case '.ply'
        mesh = readMesh_ply(fileName);
    case '.stl'
        mesh = readMesh_stl(fileName);
    otherwise
        error('readMesh.m does not support %s files.', upper(ext(2:end)));
end

if parser.Results.trimMesh
    mesh = trimMesh(mesh);
end
    
% format output arguments
varargout = formatMeshOutput(nargout, mesh.vertices, mesh.faces);
