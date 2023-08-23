//
//  DNYKViewBuilder.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/23/23.
//

import DNYK_Core

struct DNYKViewBuilder {
    static func newCategoryView(with service: DNYKService) -> NewCategoryView<NewCategoryViewModel> {
        NewCategoryView(viewModel: .init(service: service))
    }
}
