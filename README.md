# AlgoGraphics
Random visualizations

I found [this post](http://inconvergent.net/spurious-splines/) very beautiful and interesting, so I decided to recreate it using swift.

There are both examples in the code:

- Applying randomness to a straight line:
![](https://github.com/victorBaro/AlgoGraphics/blob/master/Other%20Assets/definition%20points.png?raw=true)

- Apply randomness to a circle line:
![](https://github.com/victorBaro/AlgoGraphics/blob/master/Other%20Assets/XandYRandomness.png?raw=true)


Both drawing algorithms accept the following values:

```swift
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
```

The code is pretty rough... no classes, just a few functions. I would like to improve it and also add make lines a bit more interesting and maybe animate some changes. Will keep playing with this for a while as I find it very interesting.
