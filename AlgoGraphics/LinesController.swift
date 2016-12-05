import UIKit

class LinesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let definitionPoints = 10
        let numberOfLines = 20
        let xRandomness: CGFloat = 30
        let yRandomness: CGFloat = 50
        let xInfluenceInXAxis: CGFloat = 0.1
        let yInfluenceInXAxis: CGFloat = 0.1

        for index in 0...10 {
            let image = drawDistortedLine(with: definitionPoints,
                                          width: view.bounds.width,
                                          numberOfLines: numberOfLines,
                                          xRandomness: xRandomness * CGFloat(index),
                                          yRandomness: yRandomness,
                                          xInfluenceInXAxis: xInfluenceInXAxis,
                                          yInfluenceInXAxis: yInfluenceInXAxis)
            let imageView = UIImageView(image: image)
            let yOrigin = CGFloat(index) * 50.0 + 100.0
            imageView.frame.origin = CGPoint(x: 0, y: yOrigin)
            view.addSubview(imageView)
        }
    }
}
