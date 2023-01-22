//
//  FormView.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

class FormView: UIViewController {
    private let viewModel: FormViewModel
    
    let scrollView: UIScrollView = .init()
    let stackView: UIStackView = .init()
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .white
        
        scrollView.keyboardDismissMode = .onDrag
        scrollView.alwaysBounceVertical = true
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.fitInto(view.safeAreaLayoutGuide)
        stackView.fitInto(scrollView.contentLayoutGuide, topInset: 20, leading: 16, trailing: 16)
        stackView.setConstraints(with: scrollView.frameLayoutGuide, constraints: .init(attribute: .width, constant: -32))
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let contnet = viewModel.generateContent()
        
        title = contnet.header
        
        contnet.views.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        
        scrollView.contentInset.bottom = height + view.safeAreaInsets.bottom
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
