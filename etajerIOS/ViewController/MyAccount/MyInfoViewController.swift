//
//  MyInfoViewController.swift
//  etajerIOS
//
//  Created by mohamed on 8/27/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa

class MyInfoViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var familyNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userImageBtn: UIButton!
    @IBOutlet weak var saveDataBtn: UIButton!
    
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var changePasswordBtn: UIButton!
    
    let viewModel = MyInfoViewModel()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Code
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = AppUtility.shared.getCurrentUser()
        setDataToTxt(user: user)
    }
    
    override func configureUI() {
        super.configureUI()
        picker.delegate = self
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        userImageBtn.rx.tap.bind { (_) in
            self.imageBtnTapped()
        }.disposed(by: bag)
        
        saveDataBtn.rx.tap.bind { [unowned self] (_) in
            guard let firstName = self.firstNameTxt.text,
                  let lastName = self.familyNameTxt.text,
                  let email = self.emailTxt.text,
                  let mobile = self.mobileTxt.text else { return }
            self.viewModel.chnageUserData(firstName: firstName, lastName: lastName, email: email, mobile: mobile)
        }.disposed(by: bag)
        
        changePasswordBtn.rx.tap.bind { [unowned self] (_) in
            guard let password = self.newPasswordTxt.text,
                  let confirmPassword = self.confirmPasswordTxt.text,
                  password == confirmPassword else {
                    self.alert(title: "", message: PASSWORD_NOT_MATCHED.localized(), completion: nil)
                    return
            }
            self.viewModel.changePassword(newPassword: password, confirmPassword: confirmPassword)
        }.disposed(by: bag)
        
        backBtn.rx.tap.bind { (_) in
            NavigationCoordinator.shared.mainNavigator.popViewController(to: .myAccountViewController)
        }.disposed(by: bag)
    }
    
    override func configureData() {
        super.configureData()
        viewModel.output.successMsg.bind { [unowned self] (msg) in
            self.alert(title: "", message: msg, completion: nil)
        }.disposed(by: bag)
        
        viewModel.output.user.bind { [unowned self] (user) in
            self.setDataToTxt(user: user)
        }.disposed(by: bag)
        
        viewModel.output.failure.bind { (error) in
            guard let msg = error.first?.message else { return }
            self.alert(title: "", message: msg, completion: nil)
        }.disposed(by: bag)
    }
    
    func setDataToTxt(user: User?) {
        firstNameTxt.text = user?.firstName ?? user?.name?.split(separator: " ").first?.description
        familyNameTxt.text = user?.lastName ?? user?.name?.split(separator: " ").last?.description
        emailTxt.text = user?.email
        mobileTxt.text = user?.mobile
    }
    
    func imageBtnTapped() {
        let alert = UIAlertController(title: "chosse image from", message: " ", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.picker.allowsEditing = true
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.picker.allowsEditing = true
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        
        alert.addAction(camera)
        alert.addAction(photoLibrary)
        present(alert, animated: true, completion: nil)
    }
    
}

extension MyInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            userImage.contentMode = .scaleAspectFit
            userImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
