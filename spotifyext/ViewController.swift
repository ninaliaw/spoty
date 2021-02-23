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
    
    static var token: String?
    
    var tracks = [TrackItemData]()
    var artists = [ArtistItemData]()
    var searchType : String = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var accessToken: UITextField!
    @IBOutlet weak var typeToggle: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var nowPlayingButton: NSLayoutConstraint!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    
    // // // // // // //
    
    @IBAction func onPlayer(_ sender: Any) {
        //
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController")
        present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchType == "track" {
            return tracks.count
        }
        return artists.count
    }
    
    //if selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
        if searchType == "track" {
            print(tracks[indexPath.row].name)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchType == "track" {
            // SONG STUFF
            if let cell = table.dequeueReusableCell(withIdentifier: "SongTableViewCell") as? SongTableViewCell {
                cell.songTitle.text = tracks[indexPath.row].name
                cell.artistName.text = tracks[indexPath.row].artists.first?.name
                
                    if let imageUrl = tracks[indexPath.row].album.images.first?.url {
                        AF.request(imageUrl).responseImage { resp in
                            switch resp.result {
                            case .success(let image):
                                cell.albumArt.image = image
                            case .failure(let error):
                                print(error)
                            }
                          }
                    }
    
                   return cell
               }
            
        } else {
            // ARTIST STUFF
            if let cell = table.dequeueReusableCell(withIdentifier: "ArtistTableViewCell") as? ArtistTableViewCell {
                cell.artistName.text = artists[indexPath.row].name
                
                if let imageUrl = artists[indexPath.row].images.first?.url {
                        AF.request(imageUrl).responseImage { resp in
                            switch resp.result {
                            case .success(let image):
                                cell.artistPFP.image = image
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                   return cell
               }
        }
           
        return UITableViewCell()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "SongTableViewCell",
                                  bundle: nil)
        self.table.register(textFieldCell,
                                forCellReuseIdentifier: "SongTableViewCell")
        
        let artistTextFieldCell = UINib(nibName: "ArtistTableViewCell",
                                  bundle: nil)
        self.table.register(artistTextFieldCell,
                                forCellReuseIdentifier: "ArtistTableViewCell")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        self.registerTableViewCells()
        
    }

    @IBAction func onSearch(_ sender: Any) {
        
        ViewController.token = accessToken.text
        
        //**** SHOULD do a search/switch when toggle switches! *****
        //
        /////// hello hihihahaha
        ////
        //
            ///
            ///
        searchType = typeToggle.titleForSegment(at: typeToggle.selectedSegmentIndex)!
        
        let parameters: [String:Any] = ["q": searchTextField.text!,
                                        "type": searchType,
//                                        "limit": 2
                        ]
        
        let hdr = HTTPHeaders(
            ["Authorization": "Bearer \(accessToken.text!)",
             "Content-Type": "application/json"])
            
        if searchType == "artist" {
            AF.request("https://api.spotify.com/v1/search",
                       parameters: parameters,
                       headers: hdr).responseDecodable(of: ArtistQuery.self) { resp in
                         
                        switch resp.result {
                        case .success(let artistData):
                            self.artists = artistData.artists.items
                            self.table.reloadData()
                        case .failure(let error):
                            print(error)
                       }
                       }.responseJSON { (resp) in
                        switch resp.result {
                        case .success(let json):
                            print(json)
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
//                            print(trackData)
                        case .failure(let error):
                            print(error)
                       }
                    }
        }
        
        
    }
    
    
    
}

