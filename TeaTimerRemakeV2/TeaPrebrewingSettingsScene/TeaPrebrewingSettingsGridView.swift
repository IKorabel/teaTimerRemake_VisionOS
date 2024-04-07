//
//  TeaPrebrewingSettingsGridView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 27.03.24.
//
import SwiftUI

import Foundation

struct PrebrewingSettingsGridView: View {
    @Environment(TeaPrebrewingSettingsViewModel.self) private var viewModel
    
    let teaSettingsOption: TeaBrewingWay
    
    var isSelected: Bool = false
    
    var isVisionOS: Bool {
        return viewModel.isVisionOS
    }
    
    var body: some View {
        ZStack {
            Image(teaSettingsOption.brewingMode.imageName)
                .resizable()
                .frame(height: isVisionOS ? 200 : 180)
                .scaledToFit()
                .overlay {
                    ContainerRelativeShape()
                        .strokeBorder(.separator, lineWidth: 0.5)
                }
                .clipShape(.containerRelative)
            VStack() {
                header
                Spacer()
                footer
            }

        }
        .onTapGesture {
            viewModel.handleViewAction(.didSelectOption(optionId: teaSettingsOption.id))
        }
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(duration: 1), value: isSelected ? 1.02 : 1.0)
        .contentShape(.containerRelative)
        .containerShape(.rect(cornerRadius: 20))
    }
    
    private var header: some View {
        HStack {
            Text(teaSettingsOption.brewingMode.modeTitle)
                .font(.callout)
                .padding(8)
                .background()
                .allowsHitTesting(false)
            Spacer()
            selectionButton
        }
        .padding(8)
        .foregroundStyle(isVisionOS ? .primary : .secondary)
        .backgroundStyle(isVisionOS ? .ultraThinMaterial : .regularMaterial)
    }
    
    private var footer: some View {
        HStack {
            Text(teaSettingsOption.brewingMode.modeDescription)
                .font(.callout)
                .padding(8)
                .background()
                .allowsHitTesting(false)
            Spacer()
        }
        .foregroundStyle(isVisionOS ? .primary : .secondary)
        .backgroundStyle(isVisionOS ? .ultraThinMaterial : .regularMaterial)
        .padding(8)
    }
    
    private var selectionButton: some View {
        Button(action: {
            viewModel.handleViewAction(.didSelectOption(optionId: teaSettingsOption.id))
        }, label: {
            Label("Select", systemImage: isSelected ? "checkmark.circle.fill" : "circle")
                .contentTransition(.symbolEffect)
                .foregroundStyle(!isVisionOS && isSelected ? Color.ttGreen : .primary)
                .font(.title)
            .padding(8)
            .background(in: .circle)
        })
        .tint(isSelected ? Color.ttGreen : Color.primary)
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .buttonBorderShape(.circle)
    }
}

#Preview {
    PrebrewingSettingsGridView(teaSettingsOption: .init(brewingMode: .ceremony, brewingModesWithPhases: []))
}


