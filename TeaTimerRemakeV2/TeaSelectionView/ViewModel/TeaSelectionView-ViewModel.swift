//
//  TeaSelectionView-ViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import Foundation

class TeaSelectionViewModel: TeaSelectionViewFeature.ViewModelType {
    
    var teaList: [Tea] = Tea.teaList
    
    override init(state: TeaSelectionViewFeature.State) {
        super.init(state: .init())
        self.state.selectedIndex = teaList.first?.id
    }
    
    override func handleViewAction(_ action: TeaSelectionViewFeature.ViewAction) {
        switch action {
        case .didClickOnInfoButton:
            readAboutTea()
        case .didScrollTeaPage(let newTeaPageId):
            selectTeaPage(id: newTeaPageId)
        default:
            break
        }
    }
    
    func handleCallBackAction(_ callbackAction: TeaSelectionViewFeature.CallbackAction) {
        switch callbackAction {
        case .addTeaToList:
            print("add tea to list")
        case .readAboutTea:
            readAboutTea()
        case .brewTea:
            print("brew tea")
        }
    }
    
    private func selectTeaPage(id: UUID) {
        self.state.selectedIndex = id
    }
    
    func findSelectedTea() -> Tea? {
        guard let foundedTea = teaList.first(where: {$0.id == state.selectedIndex}) else { return nil }
        return foundedTea
    }
    
    private func readAboutTea() {
        state.isTeaInfoSheetPresented = true
        print("READ")
    }
}
