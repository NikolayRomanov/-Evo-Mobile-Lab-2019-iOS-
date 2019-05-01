//
//  CreateAndDetailNoteVC.swift
//  Тестовое для Evo Mobile Lab 2019 (iOS)
//
//  Created by Macbook on 26.04.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit
import CoreData

class CreateAndDetailNoteVC: UIViewController {
    
    var contex: NSManagedObjectContext!
    var note : NoteCoreData!
    var showSaveNote = false
    var showEditNote = false
    var detailNote = String()
    
    @IBOutlet weak var textViewNote: UITextView!
    @IBOutlet weak var navigationItemNote: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definitionVC()
    }
    
    func definitionVC() {
        if showSaveNote {
            createBarButtonSave()
            print("showSaveNote")
        }
        else if showEditNote {
            textViewNote.text = note.note
            createBarButtonEdit()
            print("showEditNote")
        }
        else {
            textViewNote.text = detailNote
        }
    }
    
    func createBarButtonSave() {
        let saveButton = UIBarButtonItem(title: "Сохранить",
                                           style: .plain,
                                           target: self,
                                           action: #selector(barButtonItemSave))
        navigationItemNote.rightBarButtonItem = saveButton
    }
    
    func createBarButtonEdit() {
        let editButton = UIBarButtonItem(title: "Редактировать",
                                         style: .plain,
                                         target: self,
                                         action: #selector(barButtonItemEdit))
        navigationItemNote.rightBarButtonItem = editButton
    }
    
    func recordObject() {
        let note = NoteCoreData(context: contex)
        note.note = textViewNote.text
        let date = Date()
        note.date = date
        note.time = date
        
        do {
            try contex.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    @objc func barButtonItemSave() {
        if showSaveNote {
            recordObject()
            navigationItemNote.rightBarButtonItem?.title = "Готово"
            navigationItemNote.rightBarButtonItem?.isEnabled = false
        }
        else if showEditNote {
            note.note = textViewNote.text
            createBarButtonEdit()
        }
    }
    
    @objc func barButtonItemEdit() {
        createBarButtonSave()
    }
    
}
