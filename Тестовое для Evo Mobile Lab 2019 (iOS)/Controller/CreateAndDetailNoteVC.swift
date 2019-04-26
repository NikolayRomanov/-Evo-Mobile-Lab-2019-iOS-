//
//  CreateAndDetailNoteVC.swift
//  Тестовое для Evo Mobile Lab 2019 (iOS)
//
//  Created by Macbook on 26.04.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class CreateAndDetailNoteVC: UIViewController {
    
    var showCreateOrDetailNote = false
    var detailNote = String()
    
    @IBOutlet weak var textViewNote: UITextView!
    @IBOutlet weak var navigationItemNote: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createBarButtonSave()
        definitionVC()
        print("showCreateOrDetailNote", showCreateOrDetailNote)
        print("detailNote", detailNote)
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

    @objc func barButtonItemSave() {
        arrayTest.append(textViewNote.text)
        print(arrayTest.count)
        navigationItemNote.rightBarButtonItem?.title = "Готово"
        navigationItemNote.rightBarButtonItem?.isEnabled = false
    }
}
