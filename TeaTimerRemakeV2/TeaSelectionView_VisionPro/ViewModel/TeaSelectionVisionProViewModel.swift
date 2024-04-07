//
//  TeaSelectionVisionProViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 11.03.24.
//

import Foundation

class TeaSelectionVisionProViewModel: TeaSelectionViewFeature.ViewModelType  {
    
    var allTeas: [Tea] = Tea.teaList
    
    override init(state: TeaSelectionViewFeature.State) {
        super.init(state: state)
        commonInit()
    }
    
    override func handleViewAction(_ action: TeaSelectionViewFeature.ViewAction) {
        switch action {
        case .didSelectTeaInList:
            print("did select")
        case .didClickOnInfoButton:
            makeCallbackAction(.readAboutTea)
        default:
            print("did make action")
        }
    }
    
    private func commonInit() {
        let firstElement = allTeas.first
        state.selectedIndex = firstElement?.id
    }
    
    private func makeCallbackAction(_ action: TeaSelectionViewFeature.CallbackAction) {
        switch action {
        case .addTeaToList:
            addTeaToList()
        case .readAboutTea:
            showInfoSheet()
        case .brewTea:
            brewTea()
        }
    }
    
    func getBrewingWaysForSelectedTea() -> [TeaBrewingWay] {
        return defineSelectedTea().brewingWays
    }
    
    private func brewTea() {
        
    }
    
    private func addTeaToList() {
        
    }
    
    private func showInfoSheet() {
        state.isTeaInfoSheetPresented = true
    }
    
     func defineSelectedTea() -> Tea {
        let selectedTea = allTeas.first(where: {$0.id == state.selectedIndex })
        return selectedTea ?? Tea.init(tea: .shuPuerh)
    }
    
}
