//
//  Created by ViJay Avhad on 23/06/18.
//  Copyright © 2018 VIJAY. All rights reserved.
//

import UIKit

class PopularDealsVC: DealsVC{

    @IBOutlet weak var tblProd: UITableView!
   
    override func viewDidLoad() {

        tblProd.estimatedRowHeight = 180
        tblProd.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showActivityIndicator()
        
        NetWorkManager().callService(urlStrP) { (json) in
            if let jsonR = json{
                if let dataInside = jsonR["deals"] as? [String:Any]{
                    self.arrDealsData = dataInside["data"] as! [[String : Any]]
                }
                print(self.arrDealsData)
            }else{
                let alertController = UIAlertController(title: "Unable Process your request.",  message: "Error", preferredStyle:.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action -> Void in
                })
               self.present(alertController, animated: true, completion: nil)
            }
            self.hideActivityIndicator()
            self.tblProd.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.bottom)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PopularDealsVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDealsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "idDealsDataCell", for: indexPath) as? DealsDataCell
        {
            let catData = self.arrDealsData[indexPath.row]
            cell.dealData = catData;
            return cell
        }
        return UITableViewCell()
    }
}
