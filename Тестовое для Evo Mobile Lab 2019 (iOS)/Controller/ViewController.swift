//
//  ViewController.swift
//  Тестовое для Evo Mobile Lab 2019 (iOS)
//
//  Created by Macbook on 26.04.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var contex: NSManagedObjectContext!
    var notes = [Note()]
    var dataNotes = [NoteCoreData()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Заметки"
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        let fetchRequest: NSFetchRequest<NoteCoreData> = NoteCoreData.fetchRequest()
        
        do {
            if let results = try contex?.fetch(fetchRequest) {
                dataNotes = results
            }
        }
        catch {
            print("error.localizedDescription", error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func noteDate(date: Date?) -> String {
        if date != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date!)
            return result
        }
        else {
            return "No info"
        }
    }
    
    func noteTime(date: Date?) -> String {
        if date != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let result = formatter.string(from: date!)
            return result
        }
        else {
            return "No info"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
        
        cell.labelDate.text = noteDate(date: dataNotes[indexPath.row].date)
        cell.labelNote.text = dataNotes[indexPath.row].note
        cell.labelTime.text = noteTime(date: dataNotes[indexPath.row].time)
        cell.labelUnicode.text = ">"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = dataNotes[indexPath.row].note
        performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let note = dataNotes[indexPath.row]
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
        }
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.dataNotes.remove(at: indexPath.row)
            self.contex.delete(note)
            
            do {
                try self.contex.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch  {
                print(error.localizedDescription)
            }
        }
        editAction.backgroundColor = .blue
        deleteAction.backgroundColor = .red
        return [deleteAction, editAction]
    }
    
    @IBAction func barButtonIntemAdd(_ sender: Any) {
        let showSaveNote = true
        
        performSegue(withIdentifier: "showCreateAndDetailNote", sender: showSaveNote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateAndDetailNote" {
            if let showCreateAndDetailNoteVC = segue.destination as? CreateAndDetailNoteVC {
                if let senderShowSaveNote = sender as? Bool {
                    showCreateAndDetailNoteVC.showSaveNote = senderShowSaveNote
                    showCreateAndDetailNoteVC.contex = contex
                }
                if let senderShowDetailNote = sender as? String {
                    showCreateAndDetailNoteVC.detailNote = senderShowDetailNote
                }
                if let senderShowEditNote = sender as? NoteCoreData {
                    showCreateAndDetailNoteVC.note = senderShowEditNote
                    showCreateAndDetailNoteVC.showEditNote = true
                }
            }
        }
    }
    
}

