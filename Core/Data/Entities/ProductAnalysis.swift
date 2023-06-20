//
//  History.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation

struct ProductAnalysis : Decodable
{
    let title : String
    let alias : String
    let slug : String
    
    enum parentKeys: String,CodingKey {
        case title
        case alias
        case harmful
    }
    
    enum harmfulKeys : String, CodingKey {
        case allergen
    }
    
    enum allergenKeys : String, CodingKey {
        case slug
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: parentKeys.self)
        self.title = try container.decode(String.self, forKey: parentKeys.title)
        self.alias = try container.decode(String.self, forKey: parentKeys.alias)
        
        let childContainer = try container.nestedContainer(keyedBy: harmfulKeys.self, forKey: parentKeys.harmful)
        
        let allergenContainer = try childContainer.nestedContainer(keyedBy: allergenKeys.self, forKey: harmfulKeys.allergen)
        
        self.slug = try allergenContainer.decode(String.self, forKey: allergenKeys.slug)
    }
}


