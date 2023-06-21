//
//  StringUtils.swift
//  SkinPedia
//
//  Created by Rainer Regan on 21/06/23.
//

import Foundation

extension String {

    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
    
    func removeSpecialCharacters() -> String {
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,/-()")
        let filteredString = self.unicodeScalars.filter { allowedCharacterSet.contains($0) }.map { String($0) }.joined()
        return filteredString
    }
    
    func removingSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func processSkincareIngredients() -> String {
        let comaSplitted = self.split(separator: ",")
//        let trimmedCombined
//        let filteredString : String = self.removeSpecialCharacters()
//        let filteredRemovedSpace : String = filteredString.removingSpaces()
//        let splittedArray = filteredRemovedSpace.split(separator: ",")
//
//        return splittedArray.joined(separator: ", ")
        return self
    }
    
    func processEachSkincareIngredient() -> String {
        var colonSplitted = self.split(separator: ":")
        
        if(colonSplitted.count > 1){
            colonSplitted.remove(at: 0)
        }
        
        let finalBestCandidate = colonSplitted.joined()
        return finalBestCandidate
    }
    
    
}

extension Array where Element == String {
    func joinWithSeparator(_ separator: String) -> String {
        return self.joined(separator: separator)
    }
}
