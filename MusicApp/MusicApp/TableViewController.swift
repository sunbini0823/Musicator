//
//  TableViewController.swift
//  MusicApp
//
//  Created by Sunbin Kim on 4/28/18.
//  Copyright © 2018 Sunbin Kim. All rights reserved.
//

import UIKit

var songs:[String] = []
var length:Int? = 0

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var songList: UITableView!
    var songName: String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        songName = songs[indexPath.row]
        performSegue(withIdentifier: "playSong", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "playSong") {
            if let destinationViewController = segue.destination as? FirstViewController {
                destinationViewController.songName = songName!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if length == 0 {
            gettingSongName()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gettingSongName() {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            length = songPath.count
            for song in songPath
            {
                var mySong = song.absoluteString
                
                if mySong.contains("mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count - 1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                    print(mySong)
                    
                }
            }
            songList.reloadData()
        }
        catch {
            
        }
    }

}
