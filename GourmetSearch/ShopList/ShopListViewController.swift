//
//  ShopListViewController.swift
//  GourmetSearch
//
//  Created by 佐藤恒 on 2017/10/23.
//  Copyright © 2017年 佐藤恒. All rights reserved.
//

import UIKit

class ShopListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var yls: YahooLocalSearch = YahooLocalSearch()
    var loadDataObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var qc = QueryCondition()
        qc.query = "ハンバーガー"
        
        yls = YahooLocalSearch(condition: qc)
        
        loadDataObserver = NotificationCenter.default.addObserver(
            forName: .apiLoadComplete,
            object: nil,
            queue: nil,
            using: {
                (notification) in
                
                if notification.userInfo != nil {
                    if let userInfo = notification.userInfo as? [String: String?] {
                        if userInfo["error"] != nil {
                            let alertView = UIAlertController(
                                title: "通信エラー",
                                message: "通信エラーが発生しました．",
                                preferredStyle: .alert)
                            alertView.addAction(
                                UIAlertAction(title: "OK", style: .default) {
                                    action in return
                                }
                            )
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
                }
            }
        )
        yls.loadData(reset: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self.loadDataObserver!)
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension ShopListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListItem") as! ShopListItemTableViewCell
            cell.name.text = "\(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
}

