//
//  MemoViewController.swift
//  MemoPad
//
//  Created by Kazuma Adachi on 2020/06/21.
//  Copyright © 2020 Kazuma Adachi. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var SaveButton: UIButton!
    
    
    var ud: UserDefaults = UserDefaults.standard
    var titleArray:[String] = []
    var contentArray:[String] = []
    var banme: Int!
    var tagNumber: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンのデザイン
        SaveButton.layer.cornerRadius = 15
        
        contentTextView.layer.cornerRadius = 8
        
        titleTextField.layer.cornerRadius = 4
        
        
        
        if ud.object(forKey: "title\(tagNumber)") != nil && ud.object(forKey: "content\(tagNumber)") != nil {
            titleArray = ud.object(forKey: "title\(tagNumber)") as! [String]
            contentArray = ud.object(forKey: "content\(tagNumber)") as! [String]
        }
        
        titleTextField.delegate = self
        
        //タイトルと内容を、配列の(cellの番目)と関連付ける
        if (banme != -1) {
            titleTextField.text = titleArray[banme]
            contentTextView.text = contentArray[banme]
        }
        
        print(String(banme))
        
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func saveMemo() {
        
        if titleTextField.text != "" {
            if(banme != -1) {
                titleArray[banme] = titleTextField.text!
                contentArray[banme] = contentTextView.text
            } else {
                titleArray.append(titleTextField.text!)
                contentArray.append(contentTextView.text!)
            }
            
            ud.set(titleArray, forKey: "title\(tagNumber)")
            ud.set(contentArray, forKey: "content\(tagNumber)")
            
            let savealert: UIAlertController = UIAlertController(title: "保存しました", message: "", preferredStyle: .alert)
            
            savealert.addAction(UIAlertAction(title:"OK", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(savealert, animated: true, completion: nil)
            
        } else {
            let notalert: UIAlertController = UIAlertController(title: "保存できません", message: "タイトルを入力してください", preferredStyle: .alert)
            
            notalert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: { action in
            }))
            
            present(notalert, animated: true, completion: nil)
        }
        
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         
          self.view.endEditing(true)
    }
//  他のところを押すことで、キーボードを下げる
    
    
    
    
    
    @IBAction func cancel() { 
        
        if  banme == -1  {
            print("pass: -1")
            if contentTextView.text == "" && titleTextField.text == "" {
                
                self.dismiss(animated: true, completion: nil)
                
                //            ↓ みにelse
            } else {
                print("pass: -1_else")
                let newalert: UIAlertController = UIAlertController(title: "このまま閉じますか？", message: "セーブせずにこのページを閉じると、書き換えた内容は保存されません", preferredStyle: .alert)
                
                newalert.addAction(UIAlertAction(title:"OK", style: .default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
                
                newalert.addAction(UIAlertAction(title:"キャンセル", style: .cancel, handler: { action in
                }))
                present(newalert, animated: true, completion: nil)
                
            }
            
            //　↓つまり、内容又は題名、又はその両方が書き換わっていたら
        } else if contentArray[banme] != contentTextView.text || titleArray[banme] != titleTextField.text {
            print("pass: not_-1_changed")
            
            let Lostalert: UIAlertController = UIAlertController(title: "このまま閉じますか？", message: "セーブせずにこのページを閉じると、書き換えた内容は保存されません", preferredStyle: .alert)
            
            Lostalert.addAction(UIAlertAction(title:"OK", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            
            Lostalert.addAction(UIAlertAction(title:"キャンセル", style: .cancel, handler: { action in
            }))
            present(Lostalert, animated: true, completion: nil)
            
        } else {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    
    
    

    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

