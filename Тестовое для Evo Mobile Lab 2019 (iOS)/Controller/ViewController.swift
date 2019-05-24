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
    
    let searchController = UISearchController(searchResultsController: nil)
    var contex: NSManagedObjectContext!
    var dataNotes = [NoteCoreData()]
    var filteredDataNotes = [NoteCoreData()]
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Заметки"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        let fetchRequest: NSFetchRequest<NoteCoreData> = NoteCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
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
    
    func sortAlphabet() {
        dataNotes.sort(){$0.note! < $1.note!}
        tableView.reloadData()
    }
    
    func sortDate() {
        dataNotes.sort(by: { $0.date!.compare($1.date!) == .orderedDescending })
        tableView.reloadData()
    }
    
    func showActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Сортировать", message: "Выберете пожалуйста желательную сортировку", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "По алфавиту", style: .default, handler: { (_) in
            print("По алфавиту")
            self.sortAlphabet()
        }))
        
        alert.addAction(UIAlertAction(title: "По дате", style: .default, handler: { (_) in
            print("По дате")
            self.sortDate()
        }))
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { (_) in
            print("Отменить")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredDataNotes.count
        }
        return dataNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
        
        var note = NoteCoreData()
        
        if isFiltering {
            note = filteredDataNotes[indexPath.row]
        }
        else {
            note = dataNotes[indexPath.row]
        }
        
        cell.labelDate.text = noteDate(date: note.date)
        cell.labelNote.text = note.note
        cell.labelTime.text = noteTime(date: note.time)
        cell.labelUnicode.text = ">"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note : String?
        
        if isFiltering {
            note = filteredDataNotes[indexPath.row].note
        }
        else {
            note = dataNotes[indexPath.row].note
        }
        
        performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let note : NoteCoreData
        
        if isFiltering {
            note = filteredDataNotes[indexPath.row]
        }
        else {
            note = dataNotes[indexPath.row]
        }
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "showCreateAndDetailNote", sender: note)
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            if self.isFiltering {
                self.filteredDataNotes.remove(at: indexPath.row)
            }
            else {
                self.dataNotes.remove(at: indexPath.row)
            }
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
    
    @IBAction func barButtonItemSort(_ sender: Any) {
        showActionSheet(controller: self)
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
                    showCreateAndDetailNoteVC.contex = contex
                    showCreateAndDetailNoteVC.showEditNote = true
                }
            }
        }
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText( _ searchText: String) {
        filteredDataNotes = dataNotes.filter({ note -> Bool in
            if let noteText = note.note {
                return noteText.contains(searchText)
            }
            else {
                return false
            }
        })
        reloadData()
    }
}

