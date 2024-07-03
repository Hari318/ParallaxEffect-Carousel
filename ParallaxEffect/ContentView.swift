//
//  ContentView.swift
//  ParallaxEffect
//
//  Created by Hari on 26/06/24.
//

import SwiftUI

struct ContentView: View {
    let images = ["babysealion", "BobbaFett", "colorbird", "shark"]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Carousel(images: images)
                .background(Color.black)
        }
    }
}

struct Carousel: View {
    let images: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(images, id: \.self) { image in
                    ParallaxPhotos(image: image)
                }
            }
        }
        .padding(.all)
    }
}

struct ParallaxPhotos: View {
    let image: String
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .shadow(radius: 5)
            .frame(height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .scrollTransition(axis: .horizontal) { content, phase in
                return content.offset(x: phase.value * -250)
            }
            .containerRelativeFrame(.horizontal)
            .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

struct AnimatedBorderShape: Shape {
    var animatableData: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = RoundedRectangle(cornerRadius: 32).path(in: rect)
        path = path.trimmedPath(from: 0, to: animatableData)
        return path
    }
}

#Preview {
    ContentView()
}
