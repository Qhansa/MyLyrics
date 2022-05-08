//
//  ViewController.swift
//  MyLyrics
//
//  Created by Qhansa D. Bayu on 08/05/22.
//

import UIKit
import CoreData

class LyricDetailVC: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var lyricTitleTextField: UITextField!
    @IBOutlet weak var lyricIdeasTextView: UITextView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
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
    }
    
}

