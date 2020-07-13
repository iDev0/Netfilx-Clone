//
//  ViewController.swift
//  Netfilx Clone
//
//  Created by iDev0 on 2020/07/09.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    private var nowPlaying: [NowPlaying.Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Api.shared.getMovie(path : .nowPlaying , { result in
            
            let decoder = JSONDecoder()
            let json = try? decoder.decode(NowPlaying.self, from: result)
            
            if let results = json?.results {
                self.nowPlaying = results
            }
        })
        
        if let collectionView =  posterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionView.scrollDirection = .horizontal
        }
        
        let nib = UINib(nibName: "CustomCollectionCell", bundle: nil)
        posterCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
    }


}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlaying.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionCell
        
        cell.posterView.image = Utils.shared.getImage(url: "https://image.tmdb.org/t/p/w500\(nowPlaying[indexPath.row].poster_path)")
        cell.titleLabel.text = nowPlaying[indexPath.row].title

        return cell
    }
    
    
    
}

