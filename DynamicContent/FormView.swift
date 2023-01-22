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
        
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.fitInto(view.safeAreaLayoutGuide)
        stackView.fitInto(scrollView.contentLayoutGuide, topInset: 20, leading: 16, trailing: 16)
        stackView.setConstraints(with: scrollView.frameLayoutGuide, constraints: .init(attribute: .width, constant: -32))
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contnet = viewModel.generateContent()
        
        title = contnet.header
        
        contnet.views.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
}
