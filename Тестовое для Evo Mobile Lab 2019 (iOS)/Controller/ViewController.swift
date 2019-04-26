//
//  ViewController.swift
//  Тестовое для Evo Mobile Lab 2019 (iOS)
//
//  Created by Macbook on 26.04.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Заметки"
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
        cell.labelDate.text = arrayNotes[indexPath.row].date
        cell.labelNote.text = arrayNotes[indexPath.row].note
        cell.labelTime.text = arrayNotes[indexPath.row].time
        cell.labelUnicode.text = ">"
        
        //cell.textLabel?.text = arrayNotes[indexPath.row].note
        //cell.detailTextLabel?.text = arrayNotes[indexPath.row].date + "     " + arrayNotes[indexPath.row].time
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
        //81
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = arrayNotes[indexPath.row].note
        performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let note = arrayNotes[indexPath.row]
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
        }
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            arrayNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
                }
                if let senderShowDetailNote = sender as? String {
                    showCreateAndDetailNoteVC.detailNote = senderShowDetailNote
                }
                if let senderShowEditNote = sender as? Note {
                    showCreateAndDetailNoteVC.note = senderShowEditNote
                    showCreateAndDetailNoteVC.showEditNote = true
                }
            }
        }
    }
    
}

