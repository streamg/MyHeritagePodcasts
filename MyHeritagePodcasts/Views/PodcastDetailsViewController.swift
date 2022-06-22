//
//  PodcastDetailsViewController.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import UIKit
import Kingfisher

class PodcastDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var viewModel: PodcastViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.artistName.bind(listener: { [weak self] artistName in
            self?.artistNameLabel.text = artistName
        })
        viewModel?.trackName.bind(listener: { [weak self] trackName in
            self?.trackNameLabel.text = trackName
        })
        viewModel?.releaseDate.bind(listener: { [weak self] releaseDate in
            self?.releaseDateLabel.text = releaseDate
        })
        viewModel?.thumbURL600.bind(listener: { [weak self] thumbURL in
            if let thumbURL = thumbURL {
                self?.imageView.kf.setImage(with: ImageResource(downloadURL: thumbURL),
                                            placeholder:nil,
                                            options: [.transition(ImageTransition.fade(0.5)), .downloadPriority(0.5)])
            } else {
                self?.imageView.image = nil
            }
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
