//
//  LoadingView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import DesignSystem
import DeclarativeUIKit
import UIKit

class LoadingView: UIView {
    lazy var body: UIView = {
        LoadingAnimationViewController()
            .asUIView()
    }()

    init() {
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Inspired from https://stackoverflow.com/a/62210326/3397287
private class LoadingAnimationViewController: UIViewController {
    private let dotSize: CGFloat = 10.0

    private let stackView: UIStackView = {
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
        return $0
    }(UIStackView())

    private let circleA = UIView()
    private let circleB = UIView()
    private let circleC = UIView()
    private lazy var circles = [circleA, circleB, circleC]

    func animate() {
        let jumpDuration: Double = 0.30
        let delayDuration: Double = 0.30
        let totalDuration: Double = delayDuration + jumpDuration*2

        let jumpRelativeDuration: Double = jumpDuration / totalDuration
        let jumpRelativeTime: Double = delayDuration / totalDuration
        let fallRelativeTime: Double = (delayDuration + jumpDuration) / totalDuration

        for (index, circle) in circles.enumerated() {
            let delay = jumpDuration*2 * TimeInterval(index) / TimeInterval(circles.count)
            UIView.animateKeyframes(withDuration: totalDuration, delay: delay, options: [.repeat], animations: {
                UIView.addKeyframe(withRelativeStartTime: jumpRelativeTime, relativeDuration: jumpRelativeDuration) {
                    circle.frame.origin.y -= 30
                }
                UIView.addKeyframe(withRelativeStartTime: fallRelativeTime, relativeDuration: jumpRelativeDuration) {
                    circle.frame.origin.y += 30
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.primaryWhite.uiColor
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circles.forEach {
            $0.layer.cornerRadius = dotSize/2
            $0.layer.masksToBounds = true
            $0.backgroundColor = .systemBlue
            stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}
