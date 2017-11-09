//
//  ShopDetailViewController.swift
//  GourmetSearch
//
//  Created by 佐藤恒 on 2017/11/04.
//  Copyright © 2017年 佐藤恒. All rights reserved.
//

import UIKit
import MapKit

class ShopDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var nameHeight: NSLayoutConstraint!
    @IBOutlet weak var addressContainerHeight: NSLayoutConstraint!
    
    var shop = Shop()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var url = shop.photoUrl {
            if let range = url.range(of: "http") {
                url.replaceSubrange(range, with: "https")
            }
            photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "loading"));
        } else {
            photo.image = UIImage(named: "loading")
        }
        
        name.text = shop.name
        tel.text = shop.tel
        address.text = shop.address
        
        updateFavoriteButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        let nameFrame = name.sizeThatFits(CGSize(width: name.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        nameHeight.constant = nameFrame.height
        
        let addressFrame = address.sizeThatFits(CGSize(width: address.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        addressContainerHeight.constant = addressFrame.height
        
        view.layoutIfNeeded()
    }
    
    // MARK: - アプリケーションロジック
    func updateFavoriteButton() {
        guard let gid = shop.gid else {
            return
        }
        
        if Favorite.inFavorites(gid) {
            favoriteIcon.image = UIImage(named: "star-on")
            favoriteLabel.text = "お気に入りから外す"
        } else {
            favoriteIcon.image = UIImage(named: "star-off")
            favoriteLabel.text = "お気に入りに入れる"
        }
    }
    
    // MARK: - IBAction
    @IBAction func telTapped(_ sender: UIButton) {
    }
    
    @IBAction func addressTapped(_ sender: UIButton) {
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard let gid = shop.gid else {
            return
        }
        
        Favorite.toggle(gid)
        updateFavoriteButton()
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
