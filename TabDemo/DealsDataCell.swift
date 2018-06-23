//
//  DealsDataswift
//  Created by ViJay Avhad on 23/06/18.
//  Copyright © 2018 VIJAY. All rights reserved.


import UIKit
import WebKit
class DealsDataCell: UITableViewCell {

    @IBOutlet weak var imgDeal: UIImageView!
    @IBOutlet weak var lblDealTitle: UILabel!
    @IBOutlet weak var wvDecrWeb: UIWebView!
    
    var dealData : [String:Any]!{
        didSet{
            lblDealTitle.text = dealData["title"] as? String ?? ""
            imgDeal.image = nil;
            if let imgUrl = dealData["image"] as? String {
                NetWorkManager.downloadImageFrom(urlString: imgUrl, imgView: imgDeal)
            }
            
            DispatchQueue.main.async {
                let htmlString = self.dealData["description"] as? String ?? ""
                self.wvDecrWeb.loadHTMLString(htmlString, baseURL: nil)
                self.wvDecrWeb.backgroundColor = UIColor.clear
                self.wvDecrWeb.scrollView.bounces = false;
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}
