//
//  PickerView.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 22.01.2023.
//

import UIKit

public protocol PickerData {
    var pickerID: String { get }
    var pickerText: String { get }
}

extension String: PickerData {
    public var pickerID: String { self }
    public var pickerText: String { self }
}

class PickerField: BaseTextField {
    //MARK: - properties
    private let optionalPick: OptionalPick = .init()
    private(set) var dataSource: [PickerData] = []

    private(set) var selectedIndex: Int = 0 {
        didSet{
            if dataSource.isEmpty {
                text = "-"
                leftViewMode = .never
                return
            }

            let data = dataSource[selectedIndex]
            text = data.pickerText
        }
    }

    var selectModeTitle: String {
        get { optionalPick.pickerText }
        set {
            optionalPick.pickerText = newValue
            pickerView.reloadAllComponents()
            if selectedIndex < 0 { text = selectModeTitle }
        }
    }

    var selectedItem: PickerData? {
        if selectedIndex < 0 { return nil }

        guard dataSource.count > selectedIndex else { return nil }
        return dataSource[selectedIndex]
    }

    var isOptional: Bool = true {
        didSet {
            guard !dataSource.isEmpty else { return }
            switch (oldValue, isOptional) {
            case (false, true):
                dataSource.insert(optionalPick, at: 0)
                select(index: selectedIndex + 1)
                pickerView.reloadAllComponents()

            case (true, false):
                dataSource.removeFirst()
                if selectedIndex > 0 {
                    select(index: selectedIndex - 1)
                }
                pickerView.reloadAllComponents()

            default:
                break
            }
        }
    }

    override var returnKeyType: UIReturnKeyType {
        didSet {
            switch returnKeyType {
            case .next: doneButton.title = "Next"
            default: doneButton.title = "Done"
            }
        }
    }

    private lazy var doneButton: UIBarButtonItem = .init(title: "Done", style: .done, target: self, action: #selector(doneTap))

    //MARK: subViews
    private let pickerView: UIPickerView = .init()

    private let rightImageView: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let button = UIButton(configuration: configuration)
        button.setImage(.init(systemName: "chevron.down"), for: .normal)
        button.contentMode = .center
        button.tintColor = #colorLiteral(red: 0.568627451, green: 0.5647058824, blue: 0.6235294118, alpha: 1)
        button.sizeToFit()

        return button
    }()

    //MARK: - initializers
    override func commonInit() {
        super.commonInit()
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)

        inputView = pickerView
        pickerView.delegate = self

        rightView = rightImageView
        rightViewMode = .always

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTap))
        toolbar.setItems([cancelButton, space, doneButton], animated: false)

        inputAccessoryView = toolbar
        toolbar.sizeToFit()

        rightImageView.addTarget(self, action: #selector(tapRightView), for: .touchUpInside)
    }

    // MARK: - actions
    @objc func tapRightView() {
        becomeFirstResponder()
    }

    // MARK: - funcs
    func setDataSource(_ dataSource: [PickerData]) {
        self.dataSource = dataSource
        if dataSource.count > 0, isOptional {
            self.dataSource.insert(optionalPick, at: 0)
        }
        selectedIndex = 0
        pickerView.reloadComponent(0)
        setNeedsLayout()
    }

    func clear() {
        dataSource = []
        selectedIndex = -1
        pickerView.reloadComponent(0)
    }

    func select(index: Int){
        let index = max(index, 0)
        guard dataSource.count > index, selectedIndex != index else{ return }
        selectedIndex = index
        pickerView.selectRow(index, inComponent: 0, animated: false)
    }

    func selectItem(_ item: PickerData) {
        guard let index = dataSource.firstIndex(where: { $0.pickerID == item.pickerID }) else { return }
        select(index: index)
    }

    //MARK: - actions
    @objc func doneTap(){
        let index =  pickerView.selectedRow(inComponent: 0)

        if selectedIndex != index {
            selectedIndex = index
            sendActions(for: .valueChanged)
        }

        resignFirstResponder()
        sendActions(for: .editingDidEndOnExit)
    }

    @objc func cancelTap(){
        resignFirstResponder()
    }

    @objc func editingDidBegin() {
        guard selectedIndex > 0 else { return }
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
}

extension PickerField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSource.count
    }
}

extension PickerField: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataSource[row].pickerText
    }
}

extension PickerField {
    
    class OptionalPick: PickerData {
        let image: UIImage? = nil
        let pickerID: String = ""
        var pickerText: String = "Select"
    }
}

