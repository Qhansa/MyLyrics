//
//  ViewController.swift
//  MyLyrics
//
//  Created by Qhansa D. Bayu on 08/05/22.
//

import UIKit
import CoreData

class LyricDetailVC: UIViewController {
    
    // Variables for Passing Data Between Screens
    var selectedLyric: Lyric? = nil

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var lyricTitleTextField: UITextField!
    @IBOutlet weak var lyricIdeasTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedLyric != nil {
            lyricTitleTextField.text = selectedLyric?.title
            lyricIdeasTextView.text = selectedLyric?.ideas
        }
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        // The Mandatory Core Data Codes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Separated Conditions between Create a New Lyric or Edit an Existing Lyric
        if selectedLyric == nil {
            // Create a new lyric
            let entity = NSEntityDescription.entity(forEntityName: "Lyric", in: context)
            let newLyric = Lyric(entity: entity!, insertInto: context)
            newLyric.id = Int32(lyricList.count)
            newLyric.title = lyricTitleTextField.text
            newLyric.ideas = lyricIdeasTextView.text
            
            // Saving The New Lyric to the Core Data
            do {
                try context.save()
                lyricList.append(newLyric)
                navigationController?.popViewController(animated: true)
            } catch {
                print("Context Save Error")
            }
        } else {
            // Edit an existing lyric
            // Getting the Existing Data from Core Data
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lyric")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let lyric = result as! Lyric
                    // Showing the existing data in the Lyric Detail Session Page
                    if lyric == selectedLyric {
                        lyric.title = lyricTitleTextField.text
                        lyric.ideas = lyricIdeasTextView.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Fetch Failed")
            }
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        // The Mandatory Core Data Codes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Getting the Existing Data from Core Data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lyric")
        
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let lyric = result as! Lyric
                // Showing the existing data in the Lyric Detail Session Page
                if lyric == selectedLyric {
                    // Delete the Lyric
                    lyric.deletedDate = Date()
                    
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Fetch Failed")
        }
    }
    
    
}

