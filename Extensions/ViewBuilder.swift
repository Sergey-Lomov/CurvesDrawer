//
//  ViewBuilder.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 20.09.2022.
//

import SwiftUI

extension ViewBuilder {
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View, C10 : View {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10))
    }
}
