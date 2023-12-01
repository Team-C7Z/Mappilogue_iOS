//
//  MarkedRecord.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/03.
//

import Foundation
import UIKit

struct MarkedRecord {
    let date: String
    let location: String
    let color: UIColor
}

func dummyMarkedRecordData(markedRecordCount: Int) -> [MarkedRecord] {
    var markedRecords = [MarkedRecord]()
    
    if markedRecordCount == 1 {
        let markedRecord1 = MarkedRecord(date: "2일전", location: "롯데월드", color: .marineBAD7FA)
        
        markedRecords = [markedRecord1]
    } else if markedRecordCount == 2 {
        let markedRecord1 = MarkedRecord(date: "2일전", location: "롯데월드", color: .marineBAD7FA)
        let markedRecord2 = MarkedRecord(date: "5일전", location: "광안리", color: .limeF0F1B0)
        
        markedRecords = [markedRecord1, markedRecord2]
    } else if markedRecordCount >= 3 {
        let markedRecord1 = MarkedRecord(date: "2일전", location: "롯데월드", color: .marineBAD7FA)
        let markedRecord2 = MarkedRecord(date: "5일전", location: "광안리", color: .limeF0F1B0)
        let markedRecord3 = MarkedRecord(date: "6일전", location: "한강", color: .limeF0F1B0)
        let markedRecord4 = MarkedRecord(date: "35일전", location: "우리집", color: .limeF0F1B0)
        
        markedRecords = [markedRecord1, markedRecord2, markedRecord3, markedRecord4]
    }
    
    return markedRecords
}
