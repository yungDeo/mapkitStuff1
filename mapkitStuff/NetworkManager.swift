//
//  NetworkManager.swift
//  mapkitStuff
//
//  Created by MCS Devices on 1/4/18.
//  Copyright © 2018 MCS Devices. All rights reserved.
//

import Foundation
final class networkManager{
    weak var delegate: NetworkManagerDelegate?
    func downloadNearbyPlacesApi(latitude: String, longitude: String) {
        let urljson: String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=500&key=AIzaSyCR2qrY2q_VVxi4yUZpUNoG50T6VVrzVPY"
        let urlString = URL(string: urljson)
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url){ (data,response,error ) in
                if error != nil {
                    
                    print(error as Any )
                } else {
                    
                        
                        guard let data = data else { return}
                    do {
                                let places = try JSONDecoder().decode(place.self, from: data)
                                print(places .results[4].name)
                                
                        DispatchQueue.main.async {
                            self.delegate?.didDownloadplaces(places: places)
                        }
                            
                        
                    } catch let jsonError {
                        
                        print(jsonError)
                    }
                }
                
            }
            task.resume()
        }
    }
}
