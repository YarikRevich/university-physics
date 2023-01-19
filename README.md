# university-physics
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/Naereen/StrapDown.js/blob/master/LICENSE)
[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## General Information
A simulation of a change of an electrical pole, which supposed to be a university project within physics subject. With a help of the simulation you can observe the behaviour of dynamic charges relatively to static charges. After the simulation pipeline end you can easily investigate parameters of every charge in each step of the simulation

## Technologies
- MATLAB(2022)

## Calculations

### Calculation of an intension of the field

In order to calculate a field intension there was used such an algorithm as:

```
e = constants.K * data.charge / (((x - data.x) ^ 2) + ((y - data.y) ^ 2));
r = sqrt(((x - data.x) ^ 2) + ((y - data.y) ^ 2));
ex = ex + (e * (x - data.x) / r);
ey = ey + (e * (y - data.y) / r);
```

`e` is an intension of the field. In order to calculate it we need the `x` and `y` coordinates of the dynamic charge, which properties are given by user manually

`data.x` and `data.y` are the coordinates of the static charge, which is given in the input file

`ex` is an intension of the axis x of the field, which value for each charge accumulates

`ey` is an intension of the axis y of the field, which value for each charge accumulates

### Calculation of a potencial of the field

In order to calculate a potencial of the field there was used such an algorithm as:

```
e = constants.K * data.charge / (((x - data.x) ^ 2) + ((y - data.y) ^ 2));
v = v + (e * r);
```

`e` is an intension of the field, calculated in the same way as for the intension of the field

`v` is a potencial of the charge, which value accumulates

## Setup
- Open the project file with of help of locally installed MATLAB application
- Run 'main.m' function, which will start the simulation pipeline

## Status
This project is stil maintaned
