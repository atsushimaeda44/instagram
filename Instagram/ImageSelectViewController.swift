//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by 前田陸 on 2018/03/01.
//  Copyright © 2018年 前田陸. All rights reserved.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    @IBAction func handleLibraryButton(_ sender: Any) {
        //ライブラリを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func handleCameraButton(_ sender: Any) {
        //カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func handleCancelButton(_ sender: Any) {
        //画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    //写真を撮影選択した時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if info [UIImagePickerControllerOriginalImage] != nil{
            //撮影・選択された画像を取得する
            let image = info [UIImagePickerControllerOriginalImage] as! UIImage
            
            //後でCLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            //CLEditorにimageを渡して、加工画面を起動する
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            picker.pushViewController(editor, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    //CLEditorで加工が終わった時に呼び出されるメソッド
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        //投稿の画面を開く
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image = image!
        editor.present(postViewController, animated: true, completion: nil)
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
