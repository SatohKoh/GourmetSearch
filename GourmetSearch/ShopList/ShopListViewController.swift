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
    var refreshObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ShopListViewController.onRefresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        var qc = QueryCondition()
//        qc.query = "ハンバーガー"
//
//        yls = YahooLocalSearch(condition: qc)
        
        loadDataObserver = NotificationCenter.default.addObserver(
            forName: .apiLoadComplete,
            object: nil,
            queue: nil,
            using: {
                (notification) in
                
                self.tableView.reloadData()
                
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
    
    @objc func onRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        
        refreshObserver = NotificationCenter.default.addObserver(
            forName: .apiLoadComplete,
            object: nil,
            queue: nil,
            using: {
                notification in
                NotificationCenter.default.removeObserver(self.refreshObserver!)
                refreshControl.endRefreshing()
        })
        yls.loadData(reset: true)
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension ShopListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return yls.shops.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row < yls.shops.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListItem") as! ShopListItemTableViewCell
                cell.shop = yls.shops[indexPath.row]
                
                if yls.shops.count < yls.total {
                    if yls.shops.count - indexPath.row <= 4 {
                        yls.loadData()
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
}

