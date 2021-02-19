//
//  ViewController.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/18/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tracks = [TrackItemData]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let imageUrl = tracks[indexPath.row].album.images.first?.url {
            AF.request(imageUrl).responseImage { resp in
                switch resp.result {
                case .success(let image):
                    self.coverArt.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tracks[indexPath.row].name
        return cell
    }
    

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var accessToken: UITextField!
    @IBOutlet weak var typeToggle: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var coverArt: UIImageView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func onSearch(_ sender: Any) {
        
        let searchType: String = typeToggle.titleForSegment(at: typeToggle.selectedSegmentIndex)!
        
        print(searchType)
        print("YEETO CHEETO\n\n******************\n\n****************")
//        if typeToggle.selectedSegmentIndex != 0 {
//            searchType = "type"
//            print("yeetTo")
//        }
        
//        let parameters: [String:Any] = ["q": searchTextField.text!,
//                                        "type": typeToggle.titleForSegment(at: typeToggle.selectedSegmentIndex))
//                        ]
        
        let parameters: [String:Any] = ["q": searchTextField.text!,
                                        "type": searchType,
//                                        "limit": 2
                        ]
//
//        print(parameters.index(forKey: "type"))
        
        
        let hdr = HTTPHeaders(
            ["Authorization": "Bearer \(accessToken.text!)",
             "Content-Type": "application/json"])
            
        if searchType == "artist" {
            AF.request("https://api.spotify.com/v1/search",
                       parameters: parameters,
                       headers: hdr).responseDecodable(of: ArtistQuery.self) { resp in
                         
                        switch resp.result {
                        case .success(let artistData):
                            print(artistData)
                        case .failure(let error):
                            print(error)
                       }
                    }
        } else {
            AF.request("https://api.spotify.com/v1/search",
                       parameters: parameters,
                       headers: hdr).responseDecodable(of: TrackQuery.self) { resp in

                        switch resp.result {
                        case .success(let trackData):
                            self.tracks = trackData.tracks.items
                            self.table.reloadData()
                            print(trackData)
                        case .failure(let error):
                            print(error)
                       }
                    }
//            AF.request("https://api.spotify.com/v1/search",
//                       parameters: parameters,
//                       headers: hdr).responseJSON(completionHandler: { (result) in
//                            print(result)
//                       })
        }
        
        
    }
}

