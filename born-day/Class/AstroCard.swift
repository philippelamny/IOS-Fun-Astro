//
//  AstroCard.swift
//  born-day
//
//  Created by philippe lam on 24/04/2018.
//  Copyright © 2018 philippe lam. All rights reserved.
//

import Foundation

class AstroCard {
    var _vCard : VCard
    
    enum enFrom {
        case sandipbgt
    }
    
    init (from: enFrom, sign: String, vc: AstroCardVC) {
        let yearTmp = 0
        let monthTmp = 0
        let dayTmp = 0
        let imageTmp = URL(fileURLWithPath: "http://")
        var firstDescriptionTmp : String = ""
        var secondDescriptionTmp : String = ""
        
        self._vCard = VCard(_year: yearTmp, _month: monthTmp, _day: dayTmp, _sign: sign, _image: imageTmp, _firstDescription: firstDescriptionTmp, _secondDescription: secondDescriptionTmp, _credit: "")
        
        /** En fonction du type, gestion du chargement des informations dont on a besoin */
        switch from {
            case .sandipbgt:
                
                /** Appel API Web **/
                let urlToday : String = "http://sandipbgt.com/theastrologer/api/horoscope/%/today"
                let urlString : String = urlToday.replacingOccurrences(of: "%", with: sign)
                let requestUrl = URL(string:urlString)
                
                /** configuration de la tache a executer dans la thread lors de la recuperation des informations de l'API */
                let task = URLSession.shared.dataTask(with: requestUrl!) { data, response, error in
                    if error != nil {
                        print ("Some error occured to get information from the website")
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                            print ("Status code...")
                            return
                    }
                    //parsing the response
                    do {
                        //converting resonse to NSDictionary
                        var arData: NSDictionary
                        arData =  (try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary)!
                        //getting the JSON array teams from the response
                        let arMeta: NSDictionary = arData["meta"] as! NSDictionary
                        let mood: String = arMeta["mood"] as! String
                        let keywords: String = arMeta["keywords"] as! String
                        let intensity: String = arMeta["intensity"] as! String
                        let horoscope: String = arData["horoscope"] as! String
                        let credit: String = arData["credit"] as! String
                        
                        firstDescriptionTmp = "Mood : " + mood + "\n"
                        firstDescriptionTmp += "keywords : " + keywords + "\n"
                        firstDescriptionTmp += "intensity : " + intensity + "\n"
                        
                        secondDescriptionTmp = horoscope
                        
                        self._vCard._firstDescription = firstDescriptionTmp
                        self._vCard._secondDescription = secondDescriptionTmp
                        self._vCard._credit = credit
                        
                        /** Mise à jour de la vue controller AstroCard avec la thread principal */
                        DispatchQueue.main.async {
                            vc.callBackLoadAstro(astro: self._vCard)
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
                break
            
            default:
                break
        }
    }
    
    /** TODO : Test Unitaire **/
    static func getSignFromDate(month: Int, day: Int) -> String {
        let arSigns = [
            /*0:["sep": 19, "sign": [0:"capricorn", 1:"aquarius"]],
             1:["sep":18, "sign": [0:"aquarius", 1:"pisces"]],
             2:["sep":20, "sign": [0:"pisces", 1:"aries"]],
             3:["sep":19, "sign": [0:"aries", 1:"taurus"]],
             4:["sep":20, "sign": [0:"taurus", 1:"gemini"]],
             5:["sep":20, "sign": [0:"gemini", 1:"cancer"]],
             6:["sep":22, "sign": [0:"cancer", 1:"leo"]],
             7:["sep":22, "sign": [0:"leo", 1:"virgo"]],
             8:["sep":22, "sign": [0:"virgo", 1:"libra"]],
             9:["sep":22, "sign": [0:"libra", 1:"scorpio"]],
             10:["sep":21, "sign": [0:"scorpio", 1:"sagittarius"]],
             11:["sep":21, "sign": [0:"sagittarius", 1:"capricorn"]],*/
            [19, "capricorn", "aquarius"],
            [18, "aquarius", "pisces"],
            [20, "pisces", "aries"],
            [19, "aries", "taurus"],
            [20, "taurus", "gemini"],
            [20, "gemini", "cancer"],
            [22, "cancer", "leo"],
            [22, "leo", "virgo"],
            [22, "virgo", "libra"],
            [22, "libra", "scorpio"],
            [21, "scorpio", "sagittarius"],
            [21, "sagittarius", "capricorn"]
        ]
        
        let arSignMonth = arSigns[month-1]
        let sep = arSignMonth[0] as!Int
        if (day <= sep) {
            return arSignMonth[1] as!String
        }
        else {
            return arSignMonth[2] as!String
        }
        
    }
    
/** TODO : Test Unitaire **/
    static func getImgNameOfSign(sign: String) -> String  {
        return sign + ".jpg"
    }
}
