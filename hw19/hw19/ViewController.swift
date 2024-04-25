//
//  ViewController.swift
//  hw19
//
//  Created by Marina Zhukova on 25.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loadDataButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loadDataButtonAction(_ sender: Any) {
        
        let urlString =  "https://reqres.in/api/unknown"
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let responseError = error {
                debugPrint(error?.localizedDescription)
            } else{
                debugPrint("")
                
                guard let responseData = data else {return}
                
                do {
                    let result = try JSONDecoder().decode(ResourseListResponse.self, from: responseData)
                    
                    debugPrint(result)
                }catch(let parseError){
                    debugPrint(parseError.localizedDescription)
                }
            }
        }.resume()
    }
    
    struct ResourseListResponse: Decodable {
        let page: Int
        let total: Int
        let data: [ResourseResponse]
    }
    
    struct ResourseResponse : Decodable{
        
        
        var id: Int
        var name: String
        var year: Int
        var color: String
        var pantone_value: String
        
        
    }
}
