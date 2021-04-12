//
//  Data.swift
//  IOS-Final-Assignment
//
//  Created by  on 4/12/21.
//

import UIKit

class Data: NSObject {
    var id: Int?
    var name: String?
    var program: String?
    var url: String?
    
    func initWithData(theRow i: Int, theName n: String, theProgram p: String, theUrl u: String){
        id = i
        name = n
        program = p
        url = u
    }
}
