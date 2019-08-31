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
        
        let viewModel = ArticleViewModel(with: AnyRepository())
        
        viewModel.testRepository()
    }
}


class ArticleViewModel {

    private let repository: AnyRepository<Article>

    init(with repo: AnyRepository<Article>) {
        repository = repo
    }

    func testRepository() {
        var article = Article(price: 12, name: "Apple Airpods")
        //insert article
        try? repository.insert(item: article)
        //get all articles
        let items: [Article] = repository.getAll()

        print("Number of saved items: \(items.count)")
        //update
        article.name = "Apple Airpods 2"
        
        try? repository.update(item: article)
    }
}

