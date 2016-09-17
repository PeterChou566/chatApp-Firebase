//
//  LoginController.swift
//  gameofchats
//
//  Created by 周大剛 on 2016/9/10.
//  Copyright © 2016年 周大剛. All rights reserved.
//

import UIKit
import Firebase

// LoginPage的 ViewController !!
class LoginController: UIViewController {
    
    // 新增一個白色的Container在頁面中
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        //注意translate...這行，他才能讓下面layout的設定跑出來！
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // 讓白色Container的角”圓滑“一點
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // 新增Register按鈕在頁面中
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        
        button.addTarget(self, action: #selector(handleRegister), forControlEvents: .TouchUpInside)
        return button
    }()
    
    func handleRegister(){
        guard let email = emailTextField.text, password = passwordTextField.text ,name = nameTextField.text else{
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
        
            if error != nil{
                print(error)
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().referenceFromURL("https://gameofchat-3a4f5.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email":email]
            userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err)
                    return
                }
                
                print("Saved user successfully into Firebase db")
                
            })
        })
        print(123)
    }
    
    // 新增nametextField到Container裡面
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // 新增分隔線
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 新增emailtextField到Container裡面
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // 新增分隔線
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 新增passwordtextField到Container裡面
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.secureTextEntry = true // 密碼欄，特殊性打字
        return tf
    }()
    
    //  新增頁面使用者影像
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon-App-60x60")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 未知功能...
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定View的背景顏色
        /* 原先版本： view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)*/
        view.backgroundColor = UIColor(r: 61 , g: 91 , b: 151)
        
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
    }
    
    func setupProfileImageView(){
        // need x ,y , width , height contraints 
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        profileImageView.bottomAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor,constant: -12).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(150).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(150).active = true
    }
    
    func setupInputsContainerView(){
        // need x ,y , width , height contraints (設定Container的layout!!)
        // anchor 錨; 固定的
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true //距離兩側的寬度縫隙各12
        inputsContainerView.heightAnchor.constraintEqualToConstant(150).active = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeperatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeperatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        // need x ,y , width , height contraints
        nameTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
            nameTextField.topAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor).active = true
            nameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
            nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3).active = true
        // need x ,y , width , height contraints
            nameSeperatorView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
            nameSeperatorView.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
            nameSeperatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
            nameSeperatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        // need x ,y , width , height contraints
        emailTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        emailTextField.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3).active = true
        // need x ,y , width , height contraints
        emailSeperatorView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
        emailSeperatorView.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        emailSeperatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        emailSeperatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        
        // need x ,y , width , height contraints
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        passwordTextField.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3).active = true
    }
    
    func setupLoginRegisterButton(){
        // need x ,y , width , height contraints
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
            // 按鈕的最上與Container的底部，相差12
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
            // 寬度，比照Container的寬度
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
    }

    //改變StatusBar成我喜歡的樣式:白色的 (statusBar就是手機最頂顯示時間或電池icon的地方)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

// 不想要在設定UIColor時，一直重複打255
extension UIColor{

    convenience init(r: CGFloat, g:CGFloat, b:CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
