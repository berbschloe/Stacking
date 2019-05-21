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

    private var stackViewWidthConstraint: NSLayoutConstraint!
    private var stackViewHeightConstraint: NSLayoutConstraint!
    /// Returns a new stacking view object that manages the provided views.
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

            stackViewWidthConstraint = stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
            stackViewHeightConstraint = stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        }

        stackViewWidthConstraint.isActive = axis == .vertical
        stackViewHeightConstraint.isActive = axis == .horizontal
    }
    
    open override var layoutMargins: UIEdgeInsets {
        get { return stackView.layoutMargins }
        set { stackView.layoutMargins = newValue }
    }

    /// The list of views arranged by the stack view.
    open var arrangedSubviews: [UIView] {
        return stackView.arrangedSubviews
    }

    /// Adds a view to the end of the arrangedSubviews array.
    open func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    /// Adds an array of views to the end of the arrangedSubviews array.
    open func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview(_:))
    }

    /// Removes the provided view from the stack’s array of arranged subviews.
    open func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
    }

    /// Removes the provided views from the stack’s array of arranged subviews.
    open func removeArrangeSubviews(_ views: [UIView]) {
        views.forEach(removeArrangedSubview(_:))
    }

    /// Adds the provided view to the array of arranged subviews at the specified index.
    open func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }

    /// Adds the provided views to the array of arranged subviews at the specified index.
    open func insertArrangeSubviews(_ views: [UIView], at stackIndex: Int) {
        views.enumerated().forEach { (index, view) in
            insertArrangedSubview(view, at: stackIndex + index)
        }
    }

    /// The axis along which the arranged views are laid out. The default value is `horizontal`.
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

    /// The distribution of the arranged views along the stack view’s axis. The default value is `fill`.
    open var distribution: UIStackView.Distribution {
        get { return stackView.distribution }
        set { stackView.distribution = newValue }
    }

    /// The alignment of the arranged subviews perpendicular to the stack view’s axis. The default value is `fill`.
    open var alignment: UIStackView.Alignment {
        get { return stackView.alignment }
        set { stackView.alignment = newValue }
    }

    /// The distance in points between the adjacent edges of the stack view’s arranged views.
    open var spacing: CGFloat {
        get { return stackView.spacing }
        set { stackView.spacing = newValue }
    }

    /// Applies custom spacing after the specified view.
    @available(iOS 11.0, *)
    open func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }

    /// Returns the custom spacing after the specified view.
    @available(iOS 11.0, *)
    open func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        return stackView.customSpacing(after: arrangedSubview)
    }

    /// A Boolean value that determines whether the vertical spacing between views is measured from their baselines.
    /// The default value is `false`.
    open var isBaselineRelativeArrangement: Bool {
        get { return stackView.isBaselineRelativeArrangement }
        set { stackView.isBaselineRelativeArrangement = newValue }
    }

    /// A Boolean value that determines whether the stack view lays out its arranged views relative to its layout margins.
    /// The default value is `false`.
    open var isLayoutMarginsRelativeArrangement: Bool {
        get { return stackView.isLayoutMarginsRelativeArrangement }
        set { stackView.isLayoutMarginsRelativeArrangement = newValue}
    }
}
