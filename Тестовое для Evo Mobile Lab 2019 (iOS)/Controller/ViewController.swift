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
        cell.labelUnicode.text = "стрелочка"
        
        //cell.textLabel?.text = arrayNotes[indexPath.row].note
        //cell.detailTextLabel?.text = arrayNotes[indexPath.row].date + "     " + arrayNotes[indexPath.row].time
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = arrayNotes[indexPath.row].note
        performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
    }
    
    @IBAction func barButtonIntemAdd(_ sender: Any) {
        let showCreateNote = true
        performSegue(withIdentifier: "showCreateAndDetailNote", sender: showCreateNote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateAndDetailNote" {
            if let showCreateAndDetailNoteVC = segue.destination as? CreateAndDetailNoteVC {
                if let sendershowCreateNote = sender as? Bool {
                    showCreateAndDetailNoteVC.showCreateOrDetailNote = sendershowCreateNote
                }
                if let sendershowDetailNote = sender as? String {
                    showCreateAndDetailNoteVC.detailNote = sendershowDetailNote
                }
            }
        }
    }
    
}

