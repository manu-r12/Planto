

import Foundation
import Alamofire
import SwiftyJSON


struct PlantInfo: Codable {
    var title: String?
    var description: String
    var imageURL: URL?
}

struct WikipediaResult: Codable {
    var query: Query
}

struct Query: Codable {
    var pages: [String: PlantInfo]
    var pageids: [String]
}


class WikiApiManagar: ObservableObject {

    @Published var flowerDataJson: JSON = []
    let wikipediaURL = "https://en.wikipedia.org/w/api.php"
    
    static let shared = WikiApiManagar()
    
    func fetchTheInfo(withTheName flowerName: String){
        
        let parameters: [String: String] = [
                    "format": "json",
                    "action": "query",
                    "prop": "extracts|pageimages",
                    "exintro": "",
                    "explaintext": "",
                    "titles": flowerName,
                    "indexpageids": "",
                    "redirects": "1",
                    "pithumbsize": "500"
            ]
        
        AF.request(wikipediaURL, method: .get, parameters: parameters)
//            .validate()
            .responseJSON { response in
                switch response.result{
                case .success(let result):
                    print(result)
                    self.flowerDataJson = JSON(result)
                 
        
                
                    print("JSON Formatted Data::->",    self.flowerDataJson)
                    
                case .failure(_):
                    print("error in fetching")
                }
            }
        
      
    }
}
