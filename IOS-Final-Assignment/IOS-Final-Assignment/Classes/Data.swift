//
//  Data.swift
//  IOS-Final-Assignment
//  Principal Author: Sam Whelan
//  Created by  on 4/12/21.
//  Description: A class that holds the fields that create the user from the db into the
//  swift code

import UIKit

class Data: NSObject {
    //The ID of the user in the table
    var id: Int?
    //The name of the user
    var name: String?
    //The program the user is studying
    var program: String?
    //A URL which links to the user's GitHub accoutn
    var url: String?
    
    //Gives the values in the class the data to create a Data object
    func initWithData(theRow i: Int, theName n: String, theProgram p: String, theUrl u: String){
        id = i
        name = n
        program = p
        url = u
    }
}
