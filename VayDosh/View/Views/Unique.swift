//
//  Unique.swift
//  VayDosh
//
//  Created by Adam Miziev on 3/18/24.
//

import SwiftUI

struct Unique: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.teal).ignoresSafeArea()

            VStack {
                Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 44, height: 44)
                Text("Scottie").bold()
                Capsule()
                    .foregroundColor(Color.green)
                    .frame(height: 44)
                    .overlay(Text("Sign up").bold())
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .padding()
        }
    }
}

#Preview {
    Unique()
}
