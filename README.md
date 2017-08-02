Example of how to call the Python library scikit-learn from Matlab.

Two approaches:
- `direct/`: call the function directly from Matlab. This method is probably fine for a single function call.
- `user_module/`: call a a Python function in a user-defined module. This approach limits the amount of Python calls (`py.*`) from the Matlab code. Easier to debug and read.
