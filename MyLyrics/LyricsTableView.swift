//
//  LyricsTableView.swift
//  MyLyrics
//
//  Created by Qhansa D. Bayu on 08/05/22.
//

import UIKit
import CoreData

// Data for the table
var lyricList = [Lyric]()

class LyricsTableView: UITableViewController {
    
    var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lyric")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let lyric = result as! Lyric
                    lyricList.append(lyric)
                }
            } catch {
                print("Fetch Failed")
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyricList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lyricCell = tableView.dequeueReusableCell(withIdentifier: "lyricCellID", for: indexPath) as! LyricCell
        
        let thisLyric: Lyric!
        thisLyric = lyricList[indexPath.row]
        
        lyricCell.titleLabel.text = thisLyric.title
        lyricCell.ideasLabel.text = thisLyric.ideas
        
        return lyricCell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
