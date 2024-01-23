//
//  DetectionModel.swift
//  Planto
//
//  Created by Manu on 2024-01-16.
//

import Foundation
import CoreML
import Vision
import CoreImage

class DetectionModel {
    
    var result: String = ""
    static let shared  = DetectionModel()
    
    func detect(image: CIImage) -> String {
        
     
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else{
            fatalError("Cannot find the ml model")
            
        }
    
        let req = VNCoreMLRequest(model: model)  { req , er in
            
            guard let classificationResult  = req.results?.first as? VNClassificationObservation else {
                return
            }
            
            self.result =  classificationResult.identifier
            //Reaching the wikipedia api to get info
            print("Reaching the wikipedia api to get info")
            WikiApiManagar.shared.fetchTheInfo(withTheName: classificationResult.identifier)
        }
        
        // get the result here to detect any
        let handler = VNImageRequestHandler(ciImage: image )
        
        do{
            try handler.perform([req])
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        return result
    }
    
}
