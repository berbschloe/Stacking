//
//  Stacking
//
//  Copyright (c) 2018 - Present Brandon Erbschloe - https://github.com/berbschloe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import Stacking

class ViewController: StackingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        stackingView.scrollView.keyboardDismissMode = .interactive
        stackingView.stackView.spacing = 10
        stackingView.stackView.isLayoutMarginsRelativeArrangement = true
        stackingView.stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // Issue on iPhones with notches where the indicator is outsize the content area.
        // Bumping it by one fixes the misplacement.
//        stackingView.scrollView.scrollIndicatorInsets.top = 1
        
        [
            makeView(height: 100, backgroundColor: .systemBlue),
            makeView(height: 200, backgroundColor: .systemRed),
            makeView(height: 200, backgroundColor: .systemGreen),
            makeView(height: 200, backgroundColor: .systemRed),
            makeView(height: 100, backgroundColor: .systemYellow),
            makeView(height: 250, backgroundColor: .systemPurple)
        ].forEach(stackingView.stackView.addArrangedSubview(_:))

        let firstCell = stackingView.stackView.arrangedSubviews.first!
        let textField = BlockableTextField()
        textField.evaluateString = { $0?.count ?? 0 > 5 }
        textField.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.layer.cornerRadius = 4
        textField.textAlignment = .center
        firstCell.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: firstCell.layoutMarginsGuide.leftAnchor),
            textField.rightAnchor.constraint(equalTo: firstCell.layoutMarginsGuide.rightAnchor),
            textField.centerYAnchor.constraint(equalTo: firstCell.layoutMarginsGuide.centerYAnchor)
        ])

        let cell = stackingView.stackView.arrangedSubviews[2]
        let horizontalStackingView = makeHorizontalStackingView()
        cell.addSubview(horizontalStackingView)

        NSLayoutConstraint.activate([
            horizontalStackingView.leftAnchor.constraint(equalTo: cell.leftAnchor),
            horizontalStackingView.rightAnchor.constraint(equalTo: cell.rightAnchor),
            horizontalStackingView.topAnchor.constraint(equalTo: cell.topAnchor),
            horizontalStackingView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
        ])

        stackingView.stackView.spacing = 10
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
        view.layer.cornerRadius = 4

        return view
    }

    private func makeHorizontalStackingView() -> StackingView {
        let horizontalStackingView = StackingView()
        horizontalStackingView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackingView.stackView.axis = .horizontal
        horizontalStackingView.stackView.distribution = .fill
        horizontalStackingView.stackView.spacing = 10
        horizontalStackingView.stackView.isLayoutMarginsRelativeArrangement = true
        horizontalStackingView.stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        [
            makeView(width: 100, backgroundColor: .systemPurple),
            makeView(width: 300, backgroundColor: .systemOrange),
            makeView(width: 1000, backgroundColor: .systemPurple)
        ].forEach(horizontalStackingView.stackView.addArrangedSubview(_:))

        return horizontalStackingView
    }

    //MARK: - Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let newInset = keyboardHeight - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        
        additionalSafeAreaInsets.bottom = newInset
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        additionalSafeAreaInsets.bottom = 0
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let newInset = keyboardHeight - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        
        additionalSafeAreaInsets.bottom = newInset
    }
}



class BlockableTextField : UITextField {
    
    var evaluateString: ((String?) -> Bool)?
    
    override public var hasText: Bool {
        get {
            return evaluateString?(text) ?? super.hasText
        }
    }
}
