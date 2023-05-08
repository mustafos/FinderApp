//
//  Model.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 27.03.2023.
//

import Foundation

class ReverseWordsModel {
    
    func reverseWords(in inputString: String) -> String {
        let words = inputString.components(separatedBy: " ")
        let reversedWords = words.map { String($0.reversed()) }
        return reversedWords.joined(separator: " ")
    }
    
    func reverseExceptAlphabeticSymbols(in inputString: String) -> String {
        let words = inputString.components(separatedBy: " ")
        let reversedWords = words.map { word -> String in
            let letters = word.filter { $0.isLetter }
            var reversedLetters = String(letters.reversed())
            var result = ""
            for c in word {
                if c.isLetter {
                    result.append(reversedLetters.removeFirst())
                } else {
                    result.append(c)
                }
            }
            return result
        }
        return reversedWords.joined(separator: " ")
    }
    
    func reverseIgnoredUserDefined(in inputString: String, ignoredChars: Set<Character> = []) -> String {
        let words = inputString.components(separatedBy: " ")
        let reversedWords = words.map { word -> String in
            let letters = word.filter { !ignoredChars.contains($0) && $0.isLetter }
            var reversedLetters = String(letters.reversed())
            var result = ""
            for c in word {
                if !ignoredChars.contains(c) && c.isLetter {
                    result.append(reversedLetters.removeFirst())
                } else {
                    result.append(c)
                }
            }
            return result
        }
        return reversedWords.joined(separator: " ")
    }
}
