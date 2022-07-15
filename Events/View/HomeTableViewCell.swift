//
//  HomeTableViewCell.swift
//  Events
//
//  Created by Joshua on 10/07/2022.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        serviceLabel.text = nil
        serviceImageView.image = nil
    }

    func setupCell(_ serviceType: ServiceType) {
        updateUI(serviceTypeName: serviceType.name, serviceTypeImage: serviceType.imageThumbURL?.md)
    }

    private func updateUI(serviceTypeName: String?, serviceTypeImage: String?) {
     self.serviceLabel.text = serviceTypeName

        guard let serviceImageString = serviceTypeImage else { return }

        guard let serviceImageImageURL = URL(string: serviceImageString) else { return }

       serviceImageView.kf.indicatorType = .activity
       serviceImageView.kf.setImage(with: serviceImageImageURL, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
    }
}
