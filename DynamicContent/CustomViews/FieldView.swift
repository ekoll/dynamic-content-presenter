//
//  InputField.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

class FieldView<T: UIView>: BaseControl {
    // MARK: - properties
    let textHeight: CGFloat = 44
    let titleToTextPadding: CGFloat = 8
    let warningToTextPadding: CGFloat = 8
    let horizontalPadding: CGFloat = 16

    var title: String? {
        get { titleLabel.text }
        set {
            titleLabel.text = newValue
        }
    }

    var hint: String? {
        get { hintLabel.text }
        set {
            hintLabel.text = newValue
            let wasHintHidden = hintView.isHidden
            hintView.isHidden = newValue?.isEmpty ?? true

            if wasHintHidden != hintView.isHidden {
                setNeedsUpdateConstraints()
            }
        }
    }

    var inputHeight: CGFloat {
        get { inputHeightConstraint.constant }
        set { inputHeightConstraint.constant = newValue }
    }

    // MARK: - subviews
    let input: T
    let titleLabel: UILabel = .title

    let hintImage: UIImageView = .hint
    
    let hintLabel: UILabel = .hint
    
    private(set) lazy var hintView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ hintImage, hintLabel ])
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.spacing = 12

        return stackView
    }()

    private lazy var inputHeightConstraint: NSLayoutConstraint = .init(item: input, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)

    init(input: T, frame: CGRect = .zero) {
        self.input = input
        super.init(frame: frame)
    }

    override func commonInit() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, input, hintView])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.setCustomSpacing(15, after: input)

        addSubview(stackView)

        stackView.fitInto(self)

        hintImage.fixHeight(34, withAspectRatio: 1)

        input.translatesAutoresizingMaskIntoConstraints = false
        inputHeightConstraint.isActive = true

        hintView.isHidden = hint?.isEmpty ?? true
    }

    override func becomeFirstResponder() -> Bool {
        input.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        input.resignFirstResponder()
    }
}
