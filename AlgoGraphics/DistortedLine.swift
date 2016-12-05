import UIKit

private struct ImagePosition {
    let size: CGSize
    let minX: CGFloat
    let minY: CGFloat
}

func drawDistortedLine(with definitionPoints: Int, width: CGFloat, numberOfLines: Int, xRandomness: CGFloat, yRandomness: CGFloat, xInfluenceInXAxis: CGFloat, yInfluenceInXAxis: CGFloat) -> UIImage {
    var waves: [[CGPoint]] = []
    for _ in 0...numberOfLines {
        var points: [CGPoint] = []
        for index in 0...definitionPoints {
            let xDivisions = width / CGFloat(definitionPoints)
            let nonDistortedPosition = CGPoint(x: xDivisions * CGFloat(index), y: 0)
            let distortedPosition = nonDistortedPosition.distortPoint(using: xRandomness, yRandomness: yRandomness, xInfluence: CGFloat(index) * xInfluenceInXAxis, yInfluence: CGFloat(index) * yInfluenceInXAxis)
            points.append(distortedPosition)
        }
        waves.append(points)
    }
    let imageSize = findDrawingSize(from: waves).size
    return drawImage(from: waves, imageSize: imageSize, amountToShift: CGPoint(x: 0, y: imageSize.height/2))
}

func drawDistortedCircle(with definitionPoints: Int, radius: CGFloat, numberOfLines: Int, xRandomness: CGFloat, yRandomness: CGFloat, xInfluenceInXAxis: CGFloat, yInfluenceInXAxis: CGFloat) -> UIImage {
    var waves: [[CGPoint]] = []
    for _ in 0...numberOfLines {
        var points: [CGPoint] = []
        for index in 0...definitionPoints {
            let angle = 2.0 * CGFloat(M_PI) / CGFloat(definitionPoints)
            let percentage = angle * CGFloat(index)
            let nonDistortedPosition = CGPoint(x: radius * cos(percentage), y: radius * sin(percentage))

            let distortedPosition = nonDistortedPosition.distortPoint(using: xRandomness, yRandomness: yRandomness, xInfluence: CGFloat(index) * xInfluenceInXAxis, yInfluence: CGFloat(index) * yInfluenceInXAxis)
            points.append(distortedPosition)
        }
        waves.append(points)
    }
    let imagePosition = findDrawingSize(from: waves)
    return drawImage(from: waves, imageSize: imagePosition.size, amountToShift: CGPoint(x: -imagePosition.minX, y: -imagePosition.minY))
}



private func drawImage(from lines: [[CGPoint]], imageSize: CGSize, amountToShift: CGPoint) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()
    context?.setLineWidth(1)
    let shiftedLines = lines.map { $0.map { return CGPoint(x: $0.x + amountToShift.x, y: $0.y + amountToShift.y) }}
    for (_, wave) in shiftedLines.enumerated() {
        UIColor.green.withAlphaComponent(0.2).setStroke()
        let bezierPath = UIBezierPath()
        var prevPoint: CGPoint?
        var isFirst = true

        for point in wave {
            if let prevPoint = prevPoint {
                let midPoint = CGPoint(
                    x: (point.x + prevPoint.x) / 2,
                    y: (point.y + prevPoint.y) / 2)
                if isFirst {
                    bezierPath.addLine(to: midPoint)
                }
                else {
                    bezierPath.addQuadCurve(to: midPoint, controlPoint: prevPoint)
                }
                isFirst = false
            }
            else {
                bezierPath.move(to: point)
            }
            prevPoint = point
        }
        if let prevPoint = prevPoint {
            bezierPath.addLine(to: prevPoint)
        }
        bezierPath.stroke()
    }
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}


private func findDrawingSize(from points: [[CGPoint]]) -> ImagePosition {
    var minY: CGFloat = 0
    var maxY: CGFloat = 0
    var maxX: CGFloat = 0
    var minX: CGFloat = 0
    for wave in points {
        for point in wave {
            if point.x > maxX { maxX = point.x }
            if point.y > maxY { maxY = point.y }

            if point.x < minX { minX = point.x }
            if point.y < minY { minY = point.y }
        }
    }
    return ImagePosition(size: CGSize(width: max(maxX - minX, 1), height: max(maxY - minY, 1)), minX: minX, minY: minY)
}

extension CGPoint {
    func distortPoint(using xRandomness: CGFloat, yRandomness: CGFloat, xInfluence: CGFloat, yInfluence: CGFloat) -> CGPoint {
        let xDistortion = calculateDistortion(from: xRandomness)
        let yDistortion = calculateDistortion(from: yRandomness)
        return CGPoint(x: x + xDistortion * xInfluence, y: y + yDistortion * yInfluence)
    }

    private func calculateDistortion(from value: CGFloat) -> CGFloat {
        let random = CGFloat(arc4random_uniform(UInt32(value)))
        return random - (value / 2.0)
    }
}
