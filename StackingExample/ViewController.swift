//
//  ViewController.swift
//  StackingExample
//
//  Created by Brandon Erbschloe on 2/1/19.
//  Copyright © 2019 Brandon Erbschloe. All rights reserved.
//

import UIKit
import Stacking

class ViewController: StackingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        stackingView.contentInsetAdjustmentBehavior = .always

        stackingView.addArrangedSubview(makeView(height: 100, backgroundColor: .blue))
        stackingView.addArrangedSubview(makeView(height: 200, backgroundColor: .red))
        stackingView.addArrangedSubview(makeView(height: 200, backgroundColor: .green))
        stackingView.addArrangedSubview(makeView(height: 200, backgroundColor: .red))
        stackingView.addArrangedSubview(makeView(height: 100, backgroundColor: .yellow))

        let cell = stackingView.arrangedSubviews[2]
        let horizontalStackingView = makeHorizontalStackingView()
        cell.addSubview(horizontalStackingView)

        NSLayoutConstraint.activate([
            horizontalStackingView.leftAnchor.constraint(equalTo: cell.leftAnchor),
            horizontalStackingView.rightAnchor.constraint(equalTo: cell.rightAnchor),
            horizontalStackingView.topAnchor.constraint(equalTo: cell.topAnchor),
            horizontalStackingView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
        ])

        stackingView.spacing = 10
    }

    private func makeView(width: CGFloat? = nil, height: CGFloat? = nil, backgroundColor: UIColor) -> UIView {
        let view = UIView()

        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        view.backgroundColor = backgroundColor

        return view
    }

    private func makeHorizontalStackingView() -> StackingView {
        let horizontalStackingView = StackingView()
        horizontalStackingView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackingView.axis = .horizontal
        horizontalStackingView.distribution = .fill
        horizontalStackingView.spacing = 10
        horizontalStackingView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        horizontalStackingView.isLayoutMarginsRelativeArrangement = true

        horizontalStackingView.addArrangedSubview(makeView(width: 100, backgroundColor: .purple))
        horizontalStackingView.addArrangedSubview(makeView(width: 300, backgroundColor: .orange))
        horizontalStackingView.addArrangedSubview(makeView(width: 1000, backgroundColor: .purple))

        return horizontalStackingView
    }
}
