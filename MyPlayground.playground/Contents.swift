//: Playground - noun: a place where people can play

import UIKit


    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    
    let year =  components.year!
    
    print(year)
    
    for i in (1980..<year).reversed()
    {
        print(i)
    }

