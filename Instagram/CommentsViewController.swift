//
//  CommentsViewController.swift
//  Instagram
//
//  Created by 前田陸 on 2018/03/06.
//  Copyright © 2018年 前田陸. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentsViewController: UIViewController {
    @IBOutlet weak var commentsTextField: UITextField!
    
    var postData: PostData!
    
    var postArray: [PostData] = []
    @IBAction func commentsPostButton(_ sender: Any) {
        //Firebaseに保存するデータの準備
            if commentsTextField.text?.isEmpty == false {
                //コメントが入力されている
                let name = Auth.auth().currentUser?.displayName
                let text = commentsTextField.text
                postData.comments.append("\(name!):\(text!)")
                
                //commentsをFirebaseに保存する
                let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
                let comments = ["comments": postData.comments]
                postRef.updateChildValues(comments)
                
                //全てのモーダルを閉じる
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            } else {
                //されていない時
                commentsTextField.text = ""
            }
    }
    
    //キャンセルボタンが呼ばれた時のメソッド
    @IBAction func commentsCancelButton(_ sender: Any) {
        //画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
