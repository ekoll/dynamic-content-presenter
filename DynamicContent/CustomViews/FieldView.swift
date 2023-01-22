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

    // MARK: - subviews
    let input: T
    let titleLabel: UILabel = .title

    let hintImage: UIImageView = .hint
    
    let hintLabel: UILabel = .hint
    
    private(set) lazy var hintView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ hintImage, hintLabel ])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 4

        return stackView
    }()

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

        hintImage.fixHeight(20, withAspectRatio: 1)

        input.translatesAutoresizingMaskIntoConstraints = false

        hintView.isHidden = hint?.isEmpty ?? true
    }

    override func becomeFirstResponder() -> Bool {
        input.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        input.resignFirstResponder()
    }
}
