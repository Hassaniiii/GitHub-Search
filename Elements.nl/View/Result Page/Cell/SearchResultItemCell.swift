//
//  SearchResultTableViewCell.swift
//  Elements.nl
//
//  Created by Hassan Shahbazi on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultItemCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoForks: UILabel!
    private var viewModel: SearchResultViewModel!
    private var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView = Shape.round(containerView)
        profileImage = Shape.round(profileImage) as? UIImageView
    }
    
    public func setupCell(_ viewModel: SearchResultViewModel, at indexPath: IndexPath) {
        self.viewModel = viewModel
        self.indexPath = indexPath
        
        self.setupName()
        self.setupForksStars()
        self.setupProfile()
        self.setupArchived()
    }
    
    private func setupName() {
        self.repoName.text = ""
        
        guard let name = viewModel.repoName(at: self.indexPath) else { return }
        self.repoName.text = name
    }
    
    private func setupForksStars() {
        self.repoStars.text = "0"
        self.repoForks.text = "0"
        
        if let stars = viewModel.repoStars(at: self.indexPath) { self.repoStars.text = stars }
        if let forks = viewModel.repoForks(at: self.indexPath) { self.repoForks.text = forks }
    }
    
    private func setupProfile() {
        self.profileImage.image = nil
        
        guard let profile = viewModel.repoAvatar(at: self.indexPath) else { return }
        self.profileImage.sd_setImage(with: profile)
    }
    
    private func setupArchived() {
        containerView.backgroundColor = (viewModel.repoArchived(at: self.indexPath)) ? .gray : .white
    }
}
