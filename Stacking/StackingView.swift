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

open class StackingView: UIScrollView {

    private let stackView: UIStackView = UIStackView()

    private var stackViewWidthOrHeightConstraint: NSLayoutConstraint?

    public convenience init(arrangedSubviews views: [UIView]) {
        self.init(frame: .zero)
        for view in views {
            addArrangedSubview(view)
        }
    }

    private var didSetupConstraints = false
    open override func updateConstraints() {
        super.updateConstraints()

        if !didSetupConstraints {
            didSetupConstraints = true

            stackView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: self.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }

        stackViewWidthOrHeightConstraint?.isActive = false

        if axis == .vertical {
            stackViewWidthOrHeightConstraint = stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        } else {
            stackViewWidthOrHeightConstraint = stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        }

        stackViewWidthOrHeightConstraint?.isActive = true
    }

    open var arrangedSubviews: [UIView] {
        return stackView.arrangedSubviews
    }

    open func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    open func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
    }

    open func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }

    open var axis: NSLayoutConstraint.Axis {
        get {
            return stackView.axis

        }
        set {
            if stackView.axis != newValue {
                stackView.axis = newValue
                setNeedsUpdateConstraints()
            }
        }
    }

    open var distribution: UIStackView.Distribution {
        get { return stackView.distribution }
        set { stackView.distribution = newValue }
    }

    open var alignment: UIStackView.Alignment {
        get { return stackView.alignment }
        set { stackView.alignment = newValue }
    }

    open var spacing: CGFloat {
        get { return stackView.spacing }
        set { stackView.spacing = newValue }
    }

    @available(iOS 11.0, *)
    open func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }

    @available(iOS 11.0, *)
    open func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        return stackView.customSpacing(after: arrangedSubview)
    }

    open var isBaselineRelativeArrangement: Bool {
        get { return stackView.isBaselineRelativeArrangement }
        set { stackView.isBaselineRelativeArrangement = newValue }
    }

    open var isLayoutMarginsRelativeArrangement: Bool {
        get { return stackView.isLayoutMarginsRelativeArrangement }
        set { stackView.isLayoutMarginsRelativeArrangement = newValue}
    }
}
