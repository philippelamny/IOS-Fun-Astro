//
//  AstroCardVC.swift
//  born-day
//
//  Created by philippe lam on 27/04/2018.
//  Copyright © 2018 philippe lam. All rights reserved.
//

import UIKit

class AstroCardVC: UIViewController {
    

    @IBOutlet weak var _title: UILabel!
    @IBOutlet var description_first: UITextView!
    var year : Int = 0
    var month : Int = 0
    var day: Int = 0
    @IBOutlet weak var img_astro: UIImageView!
    @IBOutlet weak var description_sec: UITextView!
    @IBOutlet weak var credit: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let sign = AstroCard.getSignFromDate(month: self.month, day: self.day)
        self.img_astro.image = UIImage (named: AstroCard.getImgNameOfSign(sign: sign))
        _ = AstroCard(from: AstroCard.enFrom.sandipbgt, sign: sign, vc: self)
    }
    
    func callBackLoadAstro(astro: VCard) {
        self.description_first.text = astro._firstDescription
        self.description_sec.text = astro._secondDescription
        self.credit.text = astro._credit
        self._title.text = "Astro : " + astro._sign
        
        self.description_first.reloadInputViews()
        self.description_sec.reloadInputViews()
        self.credit.reloadInputViews()
        self._title.reloadInputViews()
    
    }
    
    
}
