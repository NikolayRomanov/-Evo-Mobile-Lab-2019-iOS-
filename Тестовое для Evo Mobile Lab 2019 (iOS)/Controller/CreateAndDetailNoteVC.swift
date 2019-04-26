//
//  CreateAndDetailNoteVC.swift
//  Тестовое для Evo Mobile Lab 2019 (iOS)
//
//  Created by Macbook on 26.04.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class CreateAndDetailNoteVC: UIViewController {
    
    var note = Note()
    var showSaveNote = false
    var showEditNote = false
    var detailNote = String()
    
    @IBOutlet weak var textViewNote: UITextView!
    @IBOutlet weak var navigationItemNote: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createBarButtonSave()
        definitionVC()
        //print("showSaveNote", showSaveNote)
        //print("showEditNote", showEditNote)
        //print("detailNote", note)
        //print("count note", arrayNotes.count)
        // Do any additional setup after loading the view.
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
            print("showEditNote", note.note)
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

    func noteDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    func noteTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let result = formatter.string(from: date)
        return result
    }
    
    func recordObject() -> Note {
        note.date = noteDate()
        note.time = noteTime()
        note.note = textViewNote.text
        return note
    }
    
    @objc func barButtonItemSave() {
        if showSaveNote {
            arrayNotes.append(recordObject())
            print(arrayTest.count)
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
