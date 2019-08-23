//
//  ViewController.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var viewModel = ArticleViewModel(with: RealmRepository())
        
        viewModel.save()
    }
}


class ArticleViewModel {
    
    private let repository: Repository
    
    init(with repo: Repository) {
        repository = repo
    }
    
    func save() {
        let article = Article()
        article.price = 12
        article.name = "Apple Airpods"
        
        try? repository.insert(item: article)
        
        var items: [Article] = repository.getAll()
        
        print(items.count)
         
        try? repository.update {
            article.name = "aaq"
            }
        
        items = repository.getAll()
        
        print(items.last!.name)
    }
    
    
}

