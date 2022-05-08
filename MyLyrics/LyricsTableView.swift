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
        
        if firstLoad {
            firstLoad = false
            
            // The Mandatory Core Data Codes
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            // Getting the Existing Data from Core Data
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
    
    // To Calculate How Many Lyrics that are still available in the app
    func nonDeletedLyrics() -> [Lyric] {
        var noDeleteLyricList = [Lyric]()
        for lyric in lyricList {
            if lyric.deletedDate == nil {
                noDeleteLyricList.append(lyric)
            }
        }
        return noDeleteLyricList
    }
    
    // MARK - TableView Functions/Settings
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedLyrics().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lyricCell = tableView.dequeueReusableCell(withIdentifier: "lyricCellID", for: indexPath) as! LyricCell
        
        let thisLyric: Lyric!
        thisLyric = nonDeletedLyrics()[indexPath.row]
        
        lyricCell.titleLabel.text = thisLyric.title
        lyricCell.ideasLabel.text = thisLyric.ideas
        
        return lyricCell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editLyric", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editLyric" {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let lyricDetail = segue.destination as? LyricDetailVC
            
            let selectedLyric: Lyric!
            selectedLyric = nonDeletedLyrics()[indexPath.row]
            lyricDetail!.selectedLyric = selectedLyric
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
