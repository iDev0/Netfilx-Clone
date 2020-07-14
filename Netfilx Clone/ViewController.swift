//
//  ViewController.swift
//  Netfilx Clone
//
//  Created by iDev0 on 2020/07/09.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var popularCollectionView: UICollectionView! {
        didSet {
            self.popularCollectionView.backgroundColor = .black
        }
    }
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView! {
        didSet {
            self.nowPlayingCollectionView.backgroundColor = .black
        }
    }
    
    
    private var nowPlaying: [NowPlaying.Result] = []
    private var popular: [NowPlaying.Result] = []
    
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
        
        if let nowPlayingCV =  nowPlayingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            nowPlayingCV.scrollDirection = .horizontal
        }
        
        if let popularCV = popularCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            popularCV.scrollDirection = .horizontal
        }
        
        Api.shared.getMovie(path: .popular) { result in
            
            let decoder = JSONDecoder()
            let json = try? decoder.decode(NowPlaying.self, from: result)
            
            if let results = json?.results {
                self.popular = results
            }
        }
        
        
        
        let nib = UINib(nibName: "CustomCollectionCell", bundle: nil)
        nowPlayingCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        popularCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    
    


}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let collectionViewId = collectionView.restorationIdentifier else {
            return 0
        }
        
        if collectionViewId == "nowPlaying" {
            return nowPlaying.count
        } else {
            return popular.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionCell
        
        guard let collectionViewId = collectionView.restorationIdentifier else {
            return cell
        }
        
        if collectionViewId == "nowPlaying" {
            
            cell.posterView.image = Utils.shared.getImage(url: "https://image.tmdb.org/t/p/w500\(nowPlaying[indexPath.row].poster_path)")
            cell.titleLabel.text = nowPlaying[indexPath.row].title
            
        } else {
            
            cell.posterView.image = Utils.shared.getImage(url: "https://image.tmdb.org/t/p/w500\(popular[indexPath.row].poster_path)")
            cell.titleLabel.text = popular[indexPath.row].title
            
        }
        
        

        return cell
    }
    
    
    
}

