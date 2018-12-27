//
//  TableConfig.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/27/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import PullToRefreshKit

class TableConfig: NSObject {
    class func footerConfig() -> DefaultRefreshFooter {
        let footer = DefaultRefreshFooter.footer()
        footer.setText("", mode: .pullToRefresh)
        footer.setText("", mode: .tapToRefresh)
        footer.setText("", mode: .scrollAndTapToRefresh)
        footer.setText("fetching data....", mode: .refreshing)
        footer.setText("no more data", mode: .noMoreData)

        footer.tintColor = Theme.backgroundColor
        return footer
    }
}
