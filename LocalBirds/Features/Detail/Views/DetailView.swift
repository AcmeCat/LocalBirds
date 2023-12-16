//
//  DetailView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct DetailView: View {
    
    @State private var birdInfo: SingleBirdResponse?
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    imageBlock
                    
                    Group {
                        mainInfo
                        supportLink
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .onAppear {
            do {
                birdInfo = try StaticJSONMapper.decode(file: "SingleBirdData", type: SingleBirdResponse.self)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView()
    }
}

private extension DetailView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}

private extension DetailView {
    
    var mainInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            PillView(id: birdInfo?.id ?? 0)
            
            Group {
                firstname
                lastname
                email
            }
            .foregroundColor(Theme.text)
        }
    }
    
    @ViewBuilder
    var firstname: some View {
        Text("Common Name")
            .font(
                .system(.body, design: .rounded)    .weight(.semibold)
            )
        Text(birdInfo?.name ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        Divider()
    }
    
    @ViewBuilder
    var lastname: some View {
        Text("Scientific Name")
            .font(
                .system(.body, design: .rounded)    .weight(.semibold)
            )
        Text(birdInfo?.sciName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        Text("Endemic To")
            .font(
                .system(.body, design: .rounded)    .weight(.semibold)
            )
        Text(birdInfo?.region.first ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}

private extension DetailView {
    
    var supportLink: some View {
        Link(destination: .init(string: "https://www.apple.com")!) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Support Nuthatch API")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                        .weight(.semibold)
                    )
                Text("https://nuthatch.lastelm.software")
            }
            
            Spacer()
            
            Symbols.link
                .font(.system(.title3, design: .rounded))
        }
    }
}

private extension DetailView {
    
    @ViewBuilder
    var imageBlock: some View {
        if let imageString = birdInfo?.images.first,
           let imageUrl = URL(string: imageString) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height:250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}
