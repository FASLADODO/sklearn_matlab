%% Call scikit-learn GMM clustering function from Matlab.

% Reload module.
% Matlab does not automatically reload Python modules after
% they have been changed. We need to explicit reload the module.
addpath('../lib')
clear classes
reload_module()

% Add the current path to the Python module search paths.
set_module_path()

% Simulate some data
N = 100;
X = vertcat( [5, 5] + randn(N, 2), ...
   [-5, -5] + randn(N, 2));

% Call sklearn
% Note the explicit casting of "2" to an integer. By default
% Matlab casts any Python value into a floating point number,
% which can lead to problems if the value is used as an index
% for example.
X_numpy = matpy.mat2nparray(X);
gmm_res = py.my_gmm.cluster_gmm(X_numpy);
gmm_score_grid = py.my_gmm.score(X_numpy, gmm_res);

% Plotting - to illustrate how to convert numpy arrays to Matlab.
xx = matpy.nparray2mat(gmm_score_grid{1});
yy = matpy.nparray2mat(gmm_score_grid{2});
score = matpy.nparray2mat(gmm_score_grid{3});
hold on
plot(X(:,1), X(:,2), 'x');
contour(xx, yy, score, 30);

%% End of script

% Add the current directory to the search path of Python modules.
function set_module_path()
   if count(py.sys.path, '') == 0
       insert(py.sys.path, int(0), '')
   end
end % function

% Reload the Python module after changes.
function reload_module()
   mod = py.importlib.import_module('my_gmm');
   py.reload(mod);
end % function

