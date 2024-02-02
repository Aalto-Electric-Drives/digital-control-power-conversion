# Advanced Control in Electrical Energy Conversion
[![CC BY-NC 4.0][cc-by-nc-shield]][cc-by-nc]

This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License][cc-by-nc].

[![CC BY-NC 4.0][cc-by-nc-image]][cc-by-nc]

[cc-by-nc]: http://creativecommons.org/licenses/by-nc/4.0/
[cc-by-nc-image]: https://i.creativecommons.org/l/by-nc/4.0/88x31.png
[cc-by-nc-shield]: https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg

This repository contains the core material of an intensive PhD course held in Politecnico di Torino, Turin, Italy, in 2017. The course deals with model-based control in electrical energy conversion. Apparently simple generic systems are used as examples, which, however, are nontrivial to control due to either nonlinearities or discrete-time effects or both. The control challenges are essentially the same as those in more complicated three-phase systems (motor drives and grid converters), but the simpler example systems allow to focus on control challenges with less mathematical complexity.

Material is divided into six modules:

1. State feedback current control: continuous-time design 
2. Switched-mode conversion: full bridge and unipolar PWM
3. Discrete-time control design
4. Magnetic saturation and gain-scheduling
5. Resonance damping: converter equipped with an LCL filter
6. Observer-based state feedback current control

The key control challenges to be considered are:

1. Good reference tracking and disturbance rejection at the same time
2. Converter voltage saturation (actuator saturation)
3. Robustness against the digital delays in the system 
4. Effect of the magnetic saturation (motor drives)
5. Resonance damping of an LCL filter (grid converters)
6. Automatic tuning based on the known model parameters, taking the above aspects into account

The lecture slides contain some exercises. To solve them, the Simulink models included in the repository can be used as starting point. 

This course is partly built on doctoral theses of Jarno Kukkola (https://urn.fi/URN:ISBN:978-952-60-7179-4) and Hafiz Asad Ali Awan (https://urn.fi/URN:ISBN:978-952-60-8765-8).
