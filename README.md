# The Car Pathfinding Problem

![GitHub last commit](https://img.shields.io/github/last-commit/RealA10N/Car-Pathfinding-Problem?style=flat-square)
![HitCount](http://hits.dwyl.com/RealA10N/Car-Pathfinding-Problem.svg)

Use the [Main.m](Main.m) object to create a new pathfinding problem. This class is designed to be used inside of a dedicated script, and/or inside the command window.

### Table of Contents

- [The Map, Constructor method](#The-Map)
- [The Start State, The Main.setStart() Method](#Start-State)
- [The End Point, The Main.setEnd() Method](#End-Point)


## The Map

The map is a two-dimensional space that contains the car and obstacles. The bottom left corner of the map will always be the point [0, 0]. From there, the default size of the graph will be 20, which means that the other corners of the map will be [0, 20], [20, 0] and [20, 20].

### The Main Constructor 

The constructor of the Main class will create an empty map, with no obstacles and the car in the middle. The car will be teleported to the center of the map, with its default rotation (0deg).

#### Parameters

Basic call format: `mainobj = Main(size)`, `mainobj = Main()`.

* **size** is the size of the map. if this parameter is not given, the size is defaulted to 20.

#### Examples


```matlab
%% Creates a Main object with the default size 20
main = Main();
```

```matlab
%% Creates a Main object with a given size - 50 for example
mapsize = 50;
main = Main(mapsize);
```


## Start State

The start state is the state of the car before a search algorithm starts. This state contains the **rotation**, **x** and **y** of the car.

### The Main.setStart() Method

This method lets you define the start state of the car. Practically, when using this method, two things happen:

1. The car gets teleported to the given position.
2. The given position is saved, and after each search the car will be teleported back to the saved position.

You can either use the method with all 3 parameters, 1 parameter or even without them. If the amount of passes parameters is less then 3, the method will call the `ginput` MATLAB function to let the user select an start position on the graph. The selected point will be rounded to the closest point on the discretization grid and the car will teleport to the given point. If the rotation parameter isn't passed, it will be defaulted to 0deg.

#### Parameters

Basic call formats: `mainobj.setStart(rotation, x, y)`, `mainobj.setStart(rotation)`, `mainobj.setStart()`.

* **rotation** is the rotation of the car in degrees. The value 0 indicates that there is no additional rotation, and that the will be placed on the map with it's defined rotation.
* **x** and **y** are the the positions of the car reference point of the car. The reference point is the [0, 0] point of the car in the [car definition file](/General/Car.m). Can be an integer or a real number. 

#### Examples

```matlab
%% A specific start state (with given rotation, x and y)
main = Main();
x = 10;  
y = 8.5;  % The given x and y can be integers or real numbers.
rotation = 180;  % Rotation in degrees
main.setStart(rotation, x, y)  % Because 3 parameters are given, won't call the ginput function
```

```matlab
%% Select the start point and use the rotation parameter
main = Main();
rotation = 180;  % Rotation in degrees
main.setStart(rotation)  % Will call the ginput function
```

```matlab
%% Select the start point and use default rotation
main = Main();
main.setStart()  % Will call the ginput function
```


## End Point

In the current state of the program, the end point is not a state of the car (represented by the [**x**, **y**] of the reference point of the car and the rotation of the car around it) but rather just a two dimensional point [**x**, **y**]. The car only needs to touch the end point for the algorithm to find a path.

### The Main.setEnd() Method

This method lets you define the end point in the problem. You can use this method by giving it the point with the **x** and **y** parameters, or without them. If this method is called without parameters, the `ginput` MATLAB function will be called and the user will be able to set the end point by clicking on the graph.

#### Parameters

Basic call format: `mainobj.setEnd(x, y)` , `mainobj.setEnd()`.

* **x** and **y** represent the position of the end point. As mentioned above, the end point doesn't include a rotation. Can be an integer or a real number.

#### Examples

```matlab
%% A specific end point (with given x and y)
main = Main();
x = 5.5;
y = 18;
main.setEnd(x, y);  % Won't call the ginput function
```

```matlab
%% User selects the end point using ginput
main = Main();
main.setEnd(x, y)  % Will call the ginput function
```
