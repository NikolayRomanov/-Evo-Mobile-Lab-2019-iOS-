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
    var showCreateOrDetailNote = false
    var detailNote = String()
    
    @IBOutlet weak var textViewNote: UITextView!
    @IBOutlet weak var navigationItemNote: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createBarButtonSave()
        definitionVC()
        print("showCreateOrDetailNote", showCreateOrDetailNote)
        print("detailNote", note)
        print("count note", arrayNotes.count)
        // Do any additional setup after loading the view.
    }
    
    func definitionVC() {
        if showCreateOrDetailNote {
            createBarButtonSave()
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
        arrayNotes.append(recordObject())
        //arrayTest.append(textViewNote.text)
        print(arrayTest.count)
        navigationItemNote.rightBarButtonItem?.title = "Готово"
        navigationItemNote.rightBarButtonItem?.isEnabled = false
    }
}
