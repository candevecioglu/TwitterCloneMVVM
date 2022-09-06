//
//  RegistrationController.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 27.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

class RegistrationController: UIViewController {
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage : UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have and account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    // MARK: - Selectors
    
    @objc func handleShowLogin () {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto () {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegister () {
        guard let profileImage = profileImage else {
            print("DEBUG: Please select a profile image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let userName = usernameTextField.text else { return }
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)

        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email": email, "username": userName, "fullname": fullName, "profileImageURL": profileImageURL]
                    
                    REF_USERS.child(uid).updateChildValues(values) { error, ref in
                        print("Oldu!!!")
                    }
                    
                }
                
            }
        }
        
    }
    
    
    
    // MARK: - Helpers
    
    func configureUI () {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate      = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                  fullNameContainerView,
                                                  usernameContainerView,
                                                  registerButton])
        stack.axis         = .vertical
        stack.spacing      = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        
        stack.anchor(top: plusPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingLeft: 40,
                                     paddingRight: 40)
    }

}
    // MARK: - Delegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}

