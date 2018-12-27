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
    @IBOutlet weak var repoIssues: UILabel!
    @IBOutlet weak var repoPrivate: UIImageView!
    private var viewModel: SearchResultViewModel!
    private var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView = Shape.round(containerView)
        profileImage = Shape.round(profileImage) as? UIImageView
        self.addGesture()
    }
    
    public func setupCell(_ viewModel: SearchResultViewModel, at indexPath: IndexPath) {
        self.viewModel = viewModel
        self.indexPath = indexPath
        
        self.setupName()
        self.setupForksStarsIssues()
        self.setupProfile()
        self.setupArchived()
        self.setupPrivate()
    }
    
    private func setupName() {
        self.repoName.text = ""
        
        guard let name = viewModel.repoName(at: self.indexPath) else { return }
        self.repoName.text = name
    }
    
    private func setupForksStarsIssues() {
        self.repoStars.text = "0"
        self.repoForks.text = "0"
        self.repoIssues.text = "0"
        
        if let stars = viewModel.repoStars(at: self.indexPath) { self.repoStars.text = stars }
        if let forks = viewModel.repoForks(at: self.indexPath) { self.repoForks.text = forks }
        if let issues = viewModel.repoIssues(at: self.indexPath) { self.repoIssues.text = issues }
    }
    
    private func setupProfile() {
        self.profileImage.image = nil
        
        guard let profile = viewModel.repoAvatar(at: self.indexPath) else { return }
        self.profileImage.sd_setImage(with: profile)
    }
    
    private func setupArchived() {
        containerView.backgroundColor = (viewModel.repoArchived(at: self.indexPath)) ? .lightGray : .white
    }
    
    private func setupPrivate() {
        self.repoPrivate.isHidden = !(viewModel.repoPrivate(at: self.indexPath))
    }
    
    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openProfile(_:)))
        self.containerView.addGestureRecognizer(gesture)
    }
    
    @objc private func openProfile(_ sender: UITapGestureRecognizer) {
        guard let url = viewModel.repoURL(at: self.indexPath) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
