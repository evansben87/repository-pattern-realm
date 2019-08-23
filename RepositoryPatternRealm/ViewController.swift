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
        
        let viewModel = ArticleViewModel(with: RealmRepository())
        
        viewModel.testRepository()
    }
}


class ArticleViewModel {
    
    private let repository: Repository
    
    init(with repo: Repository) {
        repository = repo
    }
    
    func testRepository() {
        let article = Article()
        article.price = 12
        article.name = "Apple Airpods"
        //insert article
        try? repository.insert(item: article)
        //get all articles
        let items: [Article] = repository.getAll()
        
        print("Number of saved items: \(items.count)")
        //update
        try? repository.update {
            article.name = "Apple Airpods 2"
            }
    }
}

