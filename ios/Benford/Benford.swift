//
//  Benford.swift
//  BenfordTests
//
//  Created by Juan Maria Lao Ramos on 27/4/21.
//

import Foundation
import UIKit

class Benford{
    
    func analyze(string: String) -> BenfordData {
        let analyzer = Analyzer()
        
        string.forEach { char in
            analyzer.addDigit(digit: Int(char.asciiValue ?? 0))
        }
        
        let report = analyzer.analyze()
        
        return report
    }
    
    func analyze(_ image: UIImage) -> BenfordData {
        let analyzer = Analyzer()
        let data = image.jpegData(compressionQuality: 1.0)!
        
        data.forEach{ byte in
            analyzer.addDigit(digit: Int(byte))
        }

        let report = analyzer.analyze()
        
        return report
    }
}

class Analyzer{
    var data = BenfordData()
        
    func addDigit(digit: Int){
        let digitToAdd = digit%10
        if(digitToAdd > 0 && digitToAdd <= 9){
            if let digitData = data.digits.first(where: {$0.digit == digitToAdd}){
                digitData.count+=1
                data.digitCount += 1
            }
        }
    }
    
    func analyze()-> BenfordData{
        return data.measure()
    }
}

struct BenfordData: CustomStringConvertible{
    var digits:[BenfordAnalysisItem] = [
        BenfordAnalysisItem(1),
        BenfordAnalysisItem(2),
        BenfordAnalysisItem(3),
        BenfordAnalysisItem(4),
        BenfordAnalysisItem(5),
        BenfordAnalysisItem(6),
        BenfordAnalysisItem(7),
        BenfordAnalysisItem(8),
        BenfordAnalysisItem(9)
    ]
    
    func digit(at index: Int) -> BenfordAnalysisItem?{
        return digits.first(where: {$0.digit == index})
    }
    
    var digitCount = 0
    
    var description: String{
        var string = "Digit\tBenford [%]\tObserved [%]\tDeviation"
        string += """

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"""
        for i in 0..<9 {           
            let str = String(format: """
%d\t%.2f\t\t%.2f\t\t%.4f

""", i+1 ,digits[i].theory * 100,digits[i].measured*100,digits[i].deviation*100)
            string += str
        }
        
        return string
    }
    
    mutating func measure() -> BenfordData{
        digits[0].measure(digitCount)
       digits[1].measure(digitCount)
       digits[2].measure(digitCount)
       digits[3].measure(digitCount)
       digits[4].measure(digitCount)
       digits[5].measure(digitCount)
       digits[6].measure(digitCount)
       digits[7].measure(digitCount)
       digits[8].measure(digitCount)
        return self
    }
}

class BenfordAnalysisItem{
    
    var digit: Int
    var theory: Float = 0
    var measured: Float = 0
    var count: Float = 0
    var deviation: Float = 0
    
    init(_ digit: Int){
        self.digit = digit
        self.theory = probability(of: digit)!
    }
    
    private func probability(of z:Int) -> Float? {
        if z < 1 || z > 9{
           return nil
        }
        
        return Float(log10(Double(1)+Double(1)/Double(z)))
    }
    
    func measure(_ digitCount :Int){
        measured = count/Float(digitCount)
        deviation = theory - measured
    }
}



