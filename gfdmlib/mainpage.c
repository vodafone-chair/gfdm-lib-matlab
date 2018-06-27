/**
  @mainpage Common GFDM library function documentation

  @section intro Introduction
  Welcome to the documentation pages of the GFDM Matlab library,
  developed at TU Dresden. These pages contain all functions that
  shall be used by users. Internal functions that are not to be used
  by the end users are not included in this documentation. For a
  complete list of all available functions, go to <a
  href=globals_func.html>Global function list</a>.

  @section usage Usage
  After the git repository at
  https://<yourname>@bitbucket.org/mmatthe/gfdmlib.git has been
  cloned, the library can be used. The following files folders are
  contained:
    - setPath.m: Run this to add the path to the GFDM library to the matlab
                   path.
    - doc:       Contains the bash-script makeDoc.sh that generates
                 this documentation. Also contains various documents that belong to the GFDM library.
    - gfdmlib:   The code for the GFDM functions. Non-public methods are placed in folders named "detail"
    - test:      Unit tests for each function. To run all the tests, navigate into this folder and run "tests.m" file.
    - examples:  Folder containing several example scripts.


  @section ex Examples
  Example files can be found in the <a href=examples.html>Examples
  Page</a>.

  1. How to simulate the SER for ZF and MF receiver in an AWGN channel: ser_in_awgn.m
  2. How to generate a GFDM signal. The demo compares the spectrum with the OFDM spectrum.

  \example ser_in_awgn.m
  \example generate_gfdm_signal.m

 */
