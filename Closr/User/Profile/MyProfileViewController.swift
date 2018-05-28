//
//  MyProfileViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import SwaggerClient

protocol MyProfileViewControllerDelegate: class {
    func didSelectConfirm(controller: MyProfileViewController)
}

enum Form: Int {
    case name
    case email
    case birthday
    case phone
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .birthday:
            return "Birthday"
        case .phone:
            return "Phone number"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name, .birthday:
            return .default
        case .email:
            return .emailAddress
        case .phone:
            return .phonePad
        }
    }
}

class MyProfileViewController: UIViewController {

    var isConfirming: Bool = false
    
    var profile: Profile?
    
    weak var delegate: MyProfileViewControllerDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.dataSource            = self
        tableView.delegate              = self
        tableView.estimatedRowHeight    = 40
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.separatorStyle        = .none
        
        tableView.register(ProfileFormTableViewCell.self, forCellReuseIdentifier: ProfileFormTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    fileprivate lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = AppFont.title
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(color: AppColor.brand, for: .normal)
        button.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var birthdayPickerView: UIDatePicker = {
        let pickerView              = UIDatePicker()
        pickerView.datePickerMode   = .date
        // TODO: default to 1990
        return pickerView
    }()
    
    fileprivate lazy var toolBar: UIToolbar = {
        let toolBar         = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.tintColor   = AppColor.brand
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onToolBarDone))
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [leftSpace, doneItem]
        
        return toolBar
    }()
    
    fileprivate lazy var keyboardObbserver: KeyboardObserver = KeyboardObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.easy.layout(Edges())
        
        setupProfileHeader()
        setupFooterIfNeeded()
        
        addKeyboardObserver()
    }
    
    fileprivate func addKeyboardObserver() {
        keyboardObbserver.addObserver(didAppear: { [weak self] (keyboardSize) in
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            self?.tableView.contentInset = contentInsets
        }) { [weak self] (keyboardSize) in
            self?.tableView.contentInset = .zero
        }
    }
    
    fileprivate func setupProfileHeader() {
        let profileHeader       = ProfileAvatarHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: ProfileAvatarHeaderView.preferredHeight))
        profileHeader.delegate  = self
        
        profileHeader.update(avatarURL: profile?.avatar, showMenu: !isConfirming)
        
        tableView.tableHeaderView = profileHeader
    }
    
    fileprivate func setupFooterIfNeeded() {
        if isConfirming {
            view.addSubview(confirmButton)
            
            confirmButton.easy.layout(
                Leading(),
                Bottom(),
                Trailing(),
                Height(AppSizeMetric.buttonHeight)
            )
        }
    }
    
    fileprivate func validateForm(text: String?, cell: ProfileFormTableViewCell) {
        guard let row = tableView.indexPath(for: cell)?.row else {
            return
        }
        
        guard let form = Form(rawValue: row) else {
            return
        }
        
        let validator = Validator()
        
        switch form {
        case .name:
            let result = validator.validate(name: text)
            if !result.valid {
                popAlert(with: result.message)
                return
            }
            profile?.displayName = text
        case .email:
            let result = validator.validate(email: text)
            if !result.valid {
                popAlert(with: result.message)
                return
            }
            profile?.email = text
        case .phone:
            profile?.phone = text
        default:
            break
        }
    }
    
    fileprivate func popAlert(with message: String?) {
        let alertController = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
    
    @objc
    fileprivate func onConfirm() {
        delegate?.didSelectConfirm(controller: self)
    }
    
    @objc
    fileprivate func onToolBarDone() {
        
        updateBirthdayFieldWhenDone()
        
        tableView.endEditing(true)
    }
    
    fileprivate func updateBirthdayFieldWhenDone() {
        let indexPath = IndexPath(row: Form.birthday.rawValue, section: 0)
        
        if let cell = tableView.cellForRow(at: indexPath), cell.isFirstResponder {
        
            profile?.birthday = birthdayPickerView.date.description
            cell.setNeedsLayout()
        }
    }
    
    fileprivate func showImagePickerActionSheet() {
        let actionSheet = UIAlertController(title: "Import photo", message: nil, preferredStyle: .actionSheet)
        
        let fromCamera = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.showImagePickerForCamera()
        }
        
        let fromPhotos = UIAlertAction(title: "Photos", style: .default) { (_) in
            self.showImagePickerForPhotoPicker()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(fromCamera)
        actionSheet.addAction(fromPhotos)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }

    fileprivate func showImagePickerForCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            popAlert(with: "YourTable can't access the Camera.")
            return
        }
        
        showImagePicker(for: .camera)
    }
    
    fileprivate func showImagePickerForPhotoPicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            popAlert(with: "YourTable can't access your Photo library.")
            return
        }
        
        showImagePicker(for: .photoLibrary)
    }
    
    fileprivate func showImagePicker(for sourceType: UIImagePickerControllerSourceType) {
        let imagePicker         = UIImagePickerController()
        imagePicker.delegate    = self
        imagePicker.sourceType  = sourceType
        present(imagePicker, animated: true)
    }
}

extension MyProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFormTableViewCell.reuseIdentifier, for: indexPath) as! ProfileFormTableViewCell
        
        cell.dataSource = self
        cell.delegate   = self
        
        return cell
    }
}

extension MyProfileViewController: ProfileFormTableViewCellDataSource, ProfileFormTableViewCellDelegate {
    func title(for cell: ProfileFormTableViewCell) -> String? {
        
        return form(from: cell)?.title
    }
    
    func text(for cell: ProfileFormTableViewCell) -> String? {
        guard let form = form(from: cell) else {
            return nil
        }
        
        switch form {
        case .name:
            return profile?.displayName
        case .email:
            return profile?.email
        case .birthday:
            return profile?.birthday
        case .phone:
            return profile?.phone
        }
    }
    
    func keyboardType(for cell: ProfileFormTableViewCell) -> UIKeyboardType {
        return form(from: cell)?.keyboardType ?? .default
    }
    
    func inputView(for cell: ProfileFormTableViewCell) -> UIView? {
        if form(from: cell) == .birthday {
            return birthdayPickerView
        }
        return nil
    }
    
    func inputAccesaryView(for cell: ProfileFormTableViewCell) -> UIView? {
        if form(from: cell) == .birthday || form(from: cell) == .phone {
            return toolBar
        }
        return nil
    }
    
    // MARK: - delegate
    
    func didReturn(text: String?, from cell: ProfileFormTableViewCell) {
        
        tableView.endEditing(true)
        
        validateForm(text: text, cell: cell)
    }
    
    func didEndEditing(text: String?, from cell: ProfileFormTableViewCell) {
        validateForm(text: text, cell: cell)
    }
    
    fileprivate func form(from cell: ProfileFormTableViewCell) -> Form? {
        guard let row = tableView.indexPathForRow(at: cell.center)?.row else {
            return nil
        }
        
        return Form(rawValue: row)
    }
    
}

extension MyProfileViewController: ProfileAvatarHeaderViewDelegate {
    
    func didSelectEditAvatar() {
        showImagePickerActionSheet()
    }
    
    func didSelectMore(source: UIView) {
        let sourceRectX = source.bounds.width / 2
        let sourceRectY = source.bounds.height / 2
        
        let settingsController                      = SettingsTableViewController()
        settingsController.modalPresentationStyle   = .popover
        
        settingsController.popoverPresentationController?.sourceView = source
        settingsController.popoverPresentationController?.sourceRect = CGRect(x: sourceRectX, y: sourceRectY, width: 1, height: 1)
        settingsController.popoverPresentationController?.permittedArrowDirections = .up
        settingsController.popoverPresentationController?.delegate   = self
        
        present(settingsController, animated: true)
    }
}

extension MyProfileViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            dismiss(animated: true)
        }
        
        guard
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let imageURL = info[UIImagePickerControllerImageURL] as? URL,
            let token = UserAuthenticator.currentToken else { return }
        
        LoadingController.startLoadingOn(self)
        
        AuthenticationAPI.uploadAvatar(authorization: token, upload: imageURL) { (error) in
            
            LoadingController.stopLoading()
            
            guard error == nil else {
                self.popAlert(with: error.debugDescription)
                return
            }
            
            if let header = self.tableView.tableHeaderView as? ProfileAvatarHeaderView {
                header.update(avatarImage: image)
            }
        }
    }
}
