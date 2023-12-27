//
//  MainView.swift
//  LocalBirds
//
//  Created by Rory Allen on 27/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var cvm = ChecklistsViewModel()
    @StateObject private var bvm = BirdsViewModel()
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    @State private var isBOTDShown = true
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                if cvm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack {
                            if isBOTDShown {
                                BirdOfTheDayView(shouldShowBOTD: $isBOTDShown, bird: bird)
                                Spacer().padding()
                            }
                            Text("Your Lists")
                                .foregroundColor(Theme.text)
                                .font(
                                    .system(.title3, design: .rounded)
                                )
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 15)
                                .background(Theme.detailBackground)
                            ForEach (cvm.checklists, id: \.id) { checklist in
                                NavigationLink {
                                    SightingsView(checklistId: checklist.id)
                                } label: {
                                    ChecklistItemView(checklist: checklist)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Welcome!")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .task {
                await cvm.fetchChecklists()
            }
            .sheet(isPresented: $shouldShowCreate, onDismiss: fetch){
                CreateChecklistView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $cvm.hasError, error: cvm.error) {
                Button("Retry") {
                    Task {
                        await cvm.fetchChecklists()
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    SuccessPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    MainView()
}

private extension MainView {
    
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    func fetch() { Task { await cvm.fetchChecklists() }}
    
    var bird: Bird {
        bvm.birds.randomElement() ?? Bird(images: [], region: ["Downunder"], lengthMin: "12", lengthMax: "121", name: "Oomeedoodle", sciName: "Leglus Richardii", family: "Oomee", order: "Doodoo", status: "Presumed Extinct", id: 12)
    }
    
}
