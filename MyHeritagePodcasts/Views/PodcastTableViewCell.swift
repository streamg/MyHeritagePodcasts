//
//  PodcastTableViewCell.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import UIKit
import Kingfisher

class PodcastTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var viewModel: PodcastViewModel? {
        didSet {
            viewModel?.artistName.bind(listener: { [weak self] artistName in
                self?.artistNameLabel.text = artistName
            })
            viewModel?.trackName.bind(listener: { [weak self] trackName in
                self?.trackNameLabel.text = trackName
            })
            viewModel?.thumbURL.bind(listener: { [weak self] thumbURL in
                if let thumbURL = thumbURL {
                    self?.thumbImageView.kf.setImage(with: ImageResource(downloadURL: thumbURL),
                                                     placeholder: nil,
                                                     options: [.transition(ImageTransition.fade(0.5)), .downloadPriority(0.5)])
                } else {
                    self?.thumbImageView.image = nil
                }
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 10
        thumbImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
