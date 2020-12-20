//
//  ListViewController.swift
//  MemoPad
//
//  Created by Kazuma Adachi on 2020/06/21.
//  Copyright © 2020 Kazuma Adachi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var genre: UITextField!
    var tagNumber: Int!
    
    
    //追加したやつ↓
    var ud: UserDefaults = UserDefaults.standard
    var titleArray:[String] = []
    var contentArray:[String] = []
    var banme:Int!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.rightBarButtonItem = editButtonItem
        
        if ud.object(forKey: "title\(tagNumber)") != nil && ud.object(forKey: "content\(tagNumber)") != nil {
            titleArray = ud.object(forKey: "title\(tagNumber)") as! [String]
            contentArray = ud.object(forKey: "content\(tagNumber)") as! [String]
        }
        
        //        セルを動かす
        table.isEditing = false
        table.allowsSelectionDuringEditing = true
        
        table.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        genre.delegate = self
        if ud.object(forKey: "genre\(tagNumber)") as? String != nil
        {
            genre.text = ud.object(forKey: "genre\(tagNumber)") as? String
        }
        // Do any additional setup after loading the view.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        //tableViewの編集モードを切り替える
        table.isEditing = editing //editingはBool型でeditButtonに依存する変数
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番目の行が選択されました。")
        
        banme = indexPath.row
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 別の画面に遷移
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let insertTitle = titleArray[sourceIndexPath.row]
        let insertContent = contentArray[sourceIndexPath.row]
        // TODO: 入れ替え時の処理を実装する（データ制御など）
        titleArray.remove(at: sourceIndexPath.row)
        contentArray.remove(at: sourceIndexPath.row)
        //ここでインサート
        titleArray.insert(insertTitle, at: destinationIndexPath.row)
        contentArray.insert(insertTitle, at: destinationIndexPath.row)
        //保存
        ud.set(titleArray, forKey: "title\(tagNumber)")
        ud.set(contentArray, forKey: "content\(tagNumber)")
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none //表示させない。
//    }
    
    //    編集モード時に左にずれるか。
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false //ずれない。
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVC" {
            let MemoViewController = segue.destination as!  MemoViewController
            MemoViewController.banme = self.banme
            MemoViewController.tagNumber = self.tagNumber
        }
    }
    
    
    
    
    
    
    //追加したやつ↓
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    
    
    //追加するやつ↓
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = titleArray[indexPath.row]
        cell.textLabel?.textColor = UIColor(red: 25/225, green: 149/225, blue: 173/225, alpha: 1.0)
        
        return cell
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("pass: return")
        textField.resignFirstResponder()
        
        ud.set(genre.text, forKey: "genre\(tagNumber)")
        
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            titleArray.remove(at: indexPath.row)
            contentArray.remove(at: indexPath.row)
            ud.set(titleArray, forKey: "title\(tagNumber)")
            ud.set(contentArray, forKey: "content\(tagNumber)")
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    
    
    @IBAction func plus() {
        banme = -1
        self.performSegue(withIdentifier: "toVC", sender: nil)
        
    }
    
    
    
    
    
    
//    ✅テキストの一部の色を変える(メモ記入欄）
//    　最初の画面のマルのグレーの部分を濃くしたほうが中の文字が見やすくなる
//    ✅メモ検索機能
//    みぎにページスライド
//    ✅ジャンル無限複製
//　　　editがスライドでできたら便利？
//　　　メモの情報構成は考え直しても良さそう
//    カテゴリから探索もできるし、一覧もあるといいね
//　　　✅メモ一覧のページをkeepメモみたいにする
    
    
//    差別化ポイントをしっかりと出す
   
    
    
    
    
    
//    アイデア：毎日　〇〇祭り　みたいな。毎日わかる
//    LIT TikTok集客してんのかね？
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

