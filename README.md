# Chaotic Model for Insulin Glucose System
 A chaotic model for the insulin-glucose regulatory system. Using this model, we could mimic several common metabolic disorders related to the system and identify key parameters responsible for the initiation of these disease.
 
## Description
 This is my final project in "Mathematical Modeling in the Life Sciences"  Course of [Prof. Louis Tao](http://www.bio.pku.edu.cn/enhomes/news/teacher_dis/68.html) in the spring semaster of 2020. Here a novel mathematical model based on [Lotka–Volterra equations](https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations) was developed to mimic the behaviors of the insulin-glucose system. Numerical simulation indicates that the model has various different dynamic behaviors under different conditions, including chaos. Using this model, we could mimic several common metabolic disorders related to the system and identify key parameters responsible for the initiation of these disease.
 
 ## Model presentation
 Alfred Lotka and Vito Volterra proposed the two-dimension ordinary differential equation model to describe the population dynamics of prey and predator in 1926. Prompted by their model, the relationship of glucose and insulin is also like prey and predator. It’s reasonable to model the insulin-glucose system by making some adjustments to the Lotka–Volterra model.
 The mathematical relationships for the model are formulated as follows:
 
 $$ \frac{dx}{dt} =-a_1 x+a_2 xy+a_3 y^2+a_4 y^3+a_5 z+a_6 z^2+a_7 z^3+a_{20} $$
 
 $$ \frac{dy}{dt} =-a_8 xy-a_9 x^2-a_{10} x^3+a_{11} y(1-y)-a_{12} z-a_{13} z^2-a_{14} z^3+a_{21} $$
 
 $$ \frac{dz}{dt} =a_{15} y+a_{16} y^2+a_{17} y^3-a_{18} z-a_{19} yz$$
 
 Where x(t) is the concentration of insulin, y(t) is the population of glucose and z(t) is the population density of β-cells. There are 21 distinct model parameters, each has specific biological meaning, as discussed in project report, and could be adjusted to simulate both normal condition and metabolic disorders.
