%% Call scikit-learn GMM clustering function from Matlab.

% Reload module.
% Matlab does not automatically reload Python modules after
% they have been changed. We need to explicit reload the module.
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
clf = py.sklearn.mixture.GaussianMixture(pyargs( ...
   'n_components', int32(2), ...
   'covariance_type', 'full'))
Y = matpy.mat2nparray(X);
gmm_res = clf.fit(Y);

% Convert result to Matlab types
gmm_means = matpy.nparray2mat(gmm_res.means_)
gmm_covs = matpy.nparray2mat(gmm_res.covariances_)

% Plot results
hold on
plot(X(:,1), X(:, 2), 'x')
plot(gmm_means(1,1), gmm_means(1,2), 'ro')
plot(gmm_means(2,1), gmm_means(2,2), 'bo')

% No plotting of the covariances, I can't be bothered
% to deal with Matlab's way to plot an ellipse.


% Add the current directory to the search path of Python modules.
function set_module_path()
   if count(py.sys.path, '') == 0
       insert(py.sys.path, int(0), '')
   end
end % function

% Reload the Python module after changes. 
function reload_module()
   mod = py.importlib.import_module('gmm_demo');
   py.reload(mod);
end % function

