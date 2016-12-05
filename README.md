# AlgoGraphics
Random visualizations

After reading [this post](http://inconvergent.net/spurious-splines/) I found it very beautiful and interesting. 
I have just recreated it using swift.

There are both examples in the code:

- Applying randomness to a straight line:
![](https://github.com/victorBaro/AlgoGraphics/blob/master/Other%20Assets/definition%20points.png?raw=true)

- Apply randomness to a circle line:
![](https://github.com/victorBaro/AlgoGraphics/blob/master/Other%20Assets/XandYRandomness.png?raw=true)


Both drawing algorithms accept the following values:

// Number of points control points for creating the bezierPath
definitionPoints = 10

// Number of lines to be drawn
numberOfLines = 20

// Amount of randomness in the x axis
xRandomness: CGFloat = 20

// Amount of randomness in the y axis
yRandomness: CGFloat = 20

// This values express how much the randomness increases along the axis
xInfluenceInXAxis: CGFloat = 0.1
yInfluenceInXAxis: CGFloat = 0.1
