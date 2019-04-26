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
        return arrayTest.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNote", for: indexPath)
        cell.textLabel?.text = arrayTest[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = arrayTest[indexPath.row]
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

