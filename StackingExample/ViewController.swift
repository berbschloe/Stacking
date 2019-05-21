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

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        stackingView.contentInsetAdjustmentBehavior = .always
        stackingView.keyboardDismissMode = .interactive

        stackingView.addArrangedSubviews([
            makeView(height: 100, backgroundColor: .blue),
            makeView(height: 200, backgroundColor: .red),
            makeView(height: 200, backgroundColor: .green),
            makeView(height: 200, backgroundColor: .red),
            makeView(height: 100, backgroundColor: .yellow)
        ])

        let firstCell = stackingView.arrangedSubviews.first!
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        firstCell.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: firstCell.leftAnchor),
            textField.rightAnchor.constraint(equalTo: firstCell.rightAnchor),
            textField.topAnchor.constraint(equalTo: firstCell.topAnchor),
            textField.bottomAnchor.constraint(equalTo: firstCell.bottomAnchor),
        ])

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

        horizontalStackingView.addArrangedSubviews([
            makeView(width: 100, backgroundColor: .purple),
            makeView(width: 300, backgroundColor: .orange),
            makeView(width: 1000, backgroundColor: .purple)
        ])

        return horizontalStackingView
    }

    //MARK: - Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded();
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded();
        }
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded();
        }
    }
}
