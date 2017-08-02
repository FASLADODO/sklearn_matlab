#!/usr/bin/env python3
# -*- coding: utf-8 -*-

""" Interface between Matlab and scikit-learn GMM clustering functions.
Based on scikit-learn example sphx-glr-auto-examples-mixture-plot-gmm-pdf-py
"""
import numpy as np
from sklearn import mixture

def cluster_gmm(X):
    """Fit a Gaussian Mixture Model  on the input data, assuming two classes.
    X: 2xN array of input data
    """
    clf = mixture.GaussianMixture(n_components=2, covariance_type='full')
    clf.fit(X)
    return clf

def score(X, clf):
    """Calculate the classification probability of each input data point.
    X: input data points
    clf: GMM classifier results
    """
    x = np.linspace(-20., 30.)
    y = np.linspace(-20., 40.)
    X, Y = np.meshgrid(x, y)
    XX = np.array([X.ravel(), Y.ravel()]).T
    Z = -clf.score_samples(XX)
    Z = Z.reshape(X.shape)
    return X,Y,Z

def say_hello():
    return 'hello'

