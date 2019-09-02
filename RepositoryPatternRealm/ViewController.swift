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
        
       let viewModel = ArticleViewModel(with: CoreDataRepository(persistentContainer: CoreDataService.shared.persistentContainer))
        
        //viewModel.testRepository()
    }
}


class ArticleViewModel {

    private let repository: CoreDataRepository<Article>

    init(with repo: CoreDataRepository<Article>) {
        repository = repo
    }

    func testRepository() {
        let article = Article(price: 4999, name: "Apple Monitor")
        //insert article
        try? repository.insert(item: article)
        //get all articles
        let items: [Article] = try! repository.getAll()

        print("Number of saved items: \(items.count)")
        //update
        //article.name = "Apple Airpods 2"
        
        try? repository.update(item: article)
    }
}

