//
//  ViewController.swift
//
//  Created by ViJay Avhad on 23/06/18.
//  Copyright © 2018 VIJAY. All rights reserved.
//

import UIKit
import Parchment

class DealsVC: UIViewController{
    
    var overlay : UIView?
    var loader = false
    
    let urlStrP = "popular.json"
    let urlStrT = "top.json"
    
    var arrDealsData  = [[String:Any]]()
    
    
    fileprivate let vcTitles = ["Top","Popular"]
    
    override func viewDidLoad() {
        self.title = "Deals"
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "idTopDealsVC")
        firstViewController.title = "Top"
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "idPopularDealsVC")
        secondViewController.title = "Popular"

        let pagingViewController = FixedPagingViewController(viewControllers: [
            firstViewController,
            secondViewController
            ])
        
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
    }

    
    func showActivityIndicator() {
        
        hideActivityIndicator()
        if  let window = UIApplication.shared.keyWindow{
            overlay = UIView(frame:CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
            overlay!.alpha = 0
            overlay!.backgroundColor = UIColor.black
            window.addSubview(overlay!);
        }else{
            
            overlay = UIView(frame:self.view.frame)
            overlay!.alpha = 0
            overlay!.backgroundColor = UIColor.black
            self.view.addSubview(overlay!);
            
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.7)
        overlay!.alpha = overlay!.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        indicator.center = overlay!.center
        indicator.startAnimating()
        overlay!.addSubview(indicator)
        //self.view.bringSubview(toFront: overlay!)
        let delay = 100.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        loader = true
        DispatchQueue.main.asyncAfter(deadline: time) {
            if self.loader{
                self.hideActivityIndicator()
                print("HIDDEN FOR TIMEOUT")
            }
        }
    }
    
    func hideActivityIndicator() {
        if overlay != nil {
            loader = false
            overlay?.removeFromSuperview()
            overlay =  nil
        }
    }
    
    func setShadow(_ overlay0:UIView){
        overlay0.layer.shadowRadius = 3;
        overlay0.layer.shadowOpacity = 1.5;
        overlay0.layer.shadowOffset = CGSize(width: 1, height: 1);
        overlay0.layer.borderWidth = 1.0
        overlay0.layer.borderColor = UIColor.white.cgColor
        
    }
}





