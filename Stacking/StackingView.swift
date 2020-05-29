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

/// A container view that has a stack view embeded into a scroll view.
open class StackingView: UIView {

    public let scrollView = UIScrollView()
    public let stackView = UIStackView()

    private var stackViewWidthConstraint: NSLayoutConstraint!
    private var stackViewHeightConstraint: NSLayoutConstraint!
    
    private var stackViewAxisObservation: NSKeyValueObservation?
    
    /// Returns a new stacking view object that manages the provided views.
    public convenience init(arrangedSubviews views: [UIView]) {
        self.init(frame: .zero)
        for view in views {
            stackView.addArrangedSubview(view)
        }
    }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        stackViewAxisObservation = stackView.observe(\.axis) { [weak self] (_, _) in
            self?.setNeedsUpdateConstraints()
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])

        stackViewWidthConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        stackViewHeightConstraint = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stackViewAxisObservation?.invalidate()
    }
    
    open override func updateConstraints() {
        super.updateConstraints()

        stackViewWidthConstraint.isActive = stackView.axis == .vertical
        stackViewHeightConstraint.isActive = stackView.axis == .horizontal
    }
}

extension StackingView {
    
    open var stackViewLayoutMargins: UIEdgeInsets {
        get { return stackView.layoutMargins }
        set { stackView.layoutMargins = newValue }
    }
    
    open var arrangedSubviews: [UIView] {
        return stackView.arrangedSubviews
    }

    open func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    open func addArrangedSubview(_ view: UIView, spacing: CGFloat) {
        if let lastView = stackView.arrangedSubviews.last {
            stackView.setCustomSpacing(spacing, after: lastView)
        }
        stackView.addArrangedSubview(view)
    }
    
    open func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { stackView.addArrangedSubview($0) }
    }

    open func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
    }

    open func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }

    open var axis: NSLayoutConstraint.Axis {
        get { return stackView.axis }
        set { stackView.axis = newValue }
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

    open func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }

    open func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        return stackView.customSpacing(after: arrangedSubview)
    }

    open var isBaselineRelativeArrangement: Bool {
        get { return stackView.isBaselineRelativeArrangement }
        set { stackView.isBaselineRelativeArrangement = newValue }
    }

    open var isLayoutMarginsRelativeArrangement: Bool {
        get { return stackView.isLayoutMarginsRelativeArrangement }
        set { stackView.isLayoutMarginsRelativeArrangement = newValue }
    }
}
