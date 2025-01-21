//
//  ExploreView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var exploreVM = ExploreViewModel.shared
    @StateObject private var recognizer = SpeechRecognizer(locale: Locale(identifier: "vi"))
    @State private var isTranscribing = false
        
    var colums =  [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack{
                topBar
                
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 16) {
                        ForEach(exploreVM.filteredList, id: \.id) { cObj in
                            NavigationLink {
                                ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: cObj))
                            } label: {
                                ExploreCategoryCell(cObj: cObj)
                                    .aspectRatio(0.75, contentMode: .fill)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onChange(of: recognizer.transcript) { newValue in
            exploreVM.txtSearch = newValue
        }
    }
}

extension ExploreView {
    private var topBar: some View {
        VStack {
            Text(DataConstants.Explore.title.localized)
                .foregroundStyle(Color.white)
                .font(.nunito(.bold, fontSize: 20))
            
            HStack {
                Image(.magnifyingglass)
                
                TextField("", text: $exploreVM.txtSearch, prompt: Text(DataConstants.Explore.title.localized).foregroundColor(Color.textTitle))
                    .textInputAutocapitalization(.never)
                    .keyboardType(.default)
                    .padding(.vertical, 12)
                    .foregroundStyle(.black)

                
                Button {
                    isTranscribing ? recognizer.stopTranscribing() : recognizer.startTranscribing()
                    isTranscribing.toggle()
                } label: {
                    Image(systemName: isTranscribing ? "microphone.slash.fill" : "microphone.fill")
                        .foregroundStyle(isTranscribing ? .red : Color.primaryApp)                        
                }
            }
            .padding(.horizontal)
            .background(Color.white)
            .clipShape(Capsule())
            .padding([.horizontal, .bottom])
            .shadow(radius: 10)
        }
        .background(Color.primaryApp)
    }
}

#Preview {
    ExploreView()
}
