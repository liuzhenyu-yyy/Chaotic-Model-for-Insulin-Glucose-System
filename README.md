# Chaotic Model for Insulin Glucose System
 A chaotic model for the insulin-glucose regulatory system. Using this model, we could mimic several common metabolic disorders related to the system and identify key parameters responsible for the initiation of these disease.
 
## Description
 This is my final project in "Mathematical Modeling in the Life Sciences"  Course of [Prof. Louis Tao](http://www.bio.pku.edu.cn/enhomes/news/teacher_dis/68.html) in the spring semaster of 2020. Here a novel mathematical model based on [Lotka–Volterra equations](https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations) was developed to mimic the behaviors of the insulin-glucose system. Numerical simulation indicates that the model has various different dynamic behaviors under different conditions, including chaos. Using this model, we could mimic several common metabolic disorders related to the system and identify key parameters responsible for the initiation of these disease.
 
 ## Model presentation
 Alfred Lotka and Vito Volterra proposed the two-dimension ordinary differential equation model to describe the population dynamics of prey and predator in 1926. Prompted by their model, the relationship of glucose and insulin is also like prey and predator. It’s reasonable to model the insulin-glucose system by making some adjustments to the Lotka–Volterra model.
 The mathematical relationships for the model are formulated as follows:
 
 $$ \frac{dx}{dt} =-a_1 x+a_2 xy+a_3 y^2+a_4 y^3+a_5 z+a_6 z^2+a_7 z^3+a_{20} $$
 
 $$ \frac{dy}{dt} =-a_8 xy-a_9 x^2-a_{10} x^3+a_{11} y(1-y)-a_{12} z-a_{13} z^2-a_{14} z^3+a_{21} $$
 
 $$ \frac{dz}{dt} =a_{15} y+a_{16} y^2+a_{17} y^3-a_{18} z-a_{19} yz $$
 
 Where x(t) is the concentration of insulin, y(t) is the population of glucose and z(t) is the population density of β-cells. There are 21 distinct model parameters, each has specific biological meaning, as discussed in project report, and could be adjusted to simulate both normal condition and metabolic disorders.

## Model behavior 

### 1. Time series and state space

- Normal conditions:
Stable state of periodic orbits
 <img align="center" src="https://raw.githubusercontent.com/liuzhenyu-yyy/Chaotic-Model-for-Insulin-Glucose-System/main/figure/TimeSeries1.jpg" width=400/>
 
- Metabolic disorders:
Time series exhibit chaotic behavior. No stable points or periodic orbits, as confirmed by trajectory analysis of the system.
 <img align="center" src="https://raw.githubusercontent.com/liuzhenyu-yyy/Chaotic-Model-for-Insulin-Glucose-System/main/figure/Trajectory.jpg" width=800/>
 
 ### 2. Stability analysis
 
 The dynamical behavior of the ODE system can be determined by evaluation the eigenvalues of corresponding Jacobian matrix at each of the equilibrium points. The Jacobian matrix of the proposed system is given by:
 
$$
J = \left|\begin{array}
  (-a_1+a_2 y & a_2 x+2a_3 y+3a_4 y^2 & a_5+2a_6 z+3a_7 z^2 \\
  -a_8-2a_9 x-3a_{10} x^2 & -a_8+a_{11} (1-2y) & -a_{12}-2a_{13} z-3a_{14} z^2\\
  0 & a_15+2a_{16} y+3a_{17} y^2-a_{19} z & -a_{18}-a_{19} y
\end{array}\right\|
$$ 

Since all model variables have specific biological meanings and should be positive, the system has only two fixed points in the allowed state space under abnormal parameters. Eigenvalue of Jacobian matrixes at both points are calculated. From the eigenvalues we could tell that both points are saddles, the system has no stable fixed points.

Equilibria and eigenvalues of the system under abnormal parameters:
| Equilibria (x_0, y_0, z_0) | Eigenvalues |
| ---- | ---- |
| (0.6244, 0.9354, 0.8769) |	 λ_1=-2.8372，λ_2,3=-0.5262±2.3472i  |
| (0.8051, 1.8148, 1.3194) |	 λ_1=-1.3802，λ_2,3=-1.7563±7.5090i  |

### 3. Bifurcation diagrams and chaotic analysis
Existence of too much insulin in blood causes the glucose level to decrease beyond physiological range, leading to a disorder named hypoglycemia. High level of insulin is most possibly caused by inefficient degradation of insulin, which is indicated by reduced value of parameter $a_14$ in the model. If $a_1$ gets too low, it proceeds to hypoglycemia. Bifurcation diagrams of $a_1$  confirms that the system is stable for large value of $a_1$ but as $a_1$ decreases the system starts to act in a chaotic manner.

<img align="center" src="https://raw.githubusercontent.com/liuzhenyu-yyy/Chaotic-Model-for-Insulin-Glucose-System/main/figure/bifurcation2.jpg" width=500//>

To further certify the chaotic characteristics of the system, we calculate the Lyapunov exponent of the system by numerical simulation. To achieve this, we adopted MATLAB code provided by Vasiliy Govorukhin on the File Exchange platform of MathWorks MATLAB Central (Govorukhin, 2020) and make some vital changes to the code to make it feasible for our system. A positive Finite-time Lyapunov exponent is an indicator of chaotic behavior. During numerical simulation, time series of Lyapunov exponents gradually converge to fix values. By plotting the fixed Lyapunov exponents against $a_1$ we generated the Lyapunov exponent diagram for $a_1$. Clearly as $a_1$ decreases, one of the Lyapunov exponents increased from zero to positive, confirming that the system is chaotic for small values of $a_1$.

<img align="center" src="https://raw.githubusercontent.com/liuzhenyu-yyy/Chaotic-Model-for-Insulin-Glucose-System/main/figure/Lyapunov.jpg" width=500//>

### 4. Sensitivity to initial condition
For chaotic dynamics, a minor variation in initial conditions may cause significantly different dynamic behavior. Therefor, a small fluctuation in the insulin concentration may result in unpredictable outcomes through time. This is confirmed by numerical simulation that the system is pretty sensitive to the initial value of $x_0$, where a small perturbance could result in very distinct time series. 

<img align="center" src="https://raw.githubusercontent.com/liuzhenyu-yyy/Chaotic-Model-for-Insulin-Glucose-System/main/figure/Sensitivity.jpg" width=500//>
