import UIKit

class CirclesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let definitionPoints = 10
        let numberOfLines = 20
        let xRandomness: CGFloat = 20
        let yRandomness: CGFloat = 20
        let xInfluenceInXAxis: CGFloat = 0.1
        let yInfluenceInXAxis: CGFloat = 0.1

        for indexY in 0...5 {
            for indexX in 0...4 {
                let image = drawDistortedCircle(with: definitionPoints,
                                                radius: 30,
                                                numberOfLines: numberOfLines,
                                                xRandomness: xRandomness * CGFloat(indexX),
                                                yRandomness: yRandomness * CGFloat(indexY),
                                                xInfluenceInXAxis: xInfluenceInXAxis,
                                                yInfluenceInXAxis: yInfluenceInXAxis)
                let imageView = UIImageView(image: image)
                let yOrigin = CGFloat(indexY) * 100.0 + 100.0
                let xOrigin = CGFloat(indexX) * 80.0
                imageView.frame.origin = CGPoint(x: xOrigin, y: yOrigin)
                view.addSubview(imageView)
            }
        }
    }
}
