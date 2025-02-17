//
//  SearchListCell.swift
//  Ingresso-Challenge
//
//  Created by Yuri Strack on 05/09/21.
//

import SwiftUI
import URLImage

struct SearchListCell: View {
    
    var movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(imageString: movie.imagesURL.portrait)
            
            VStack(alignment: .leading) {
                Text(movie.title).font(.system(size: 14)).fontWeight(.bold)
                Text("Ação").font(.footnote).foregroundColor(.secondary)
                Text("\(movie.duration) min").font(.footnote).foregroundColor(.secondary)
                
                ContentRatingView(contentRating: movie.contentRating)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.primaryBlue))
        }
        .contentShape(Rectangle()) // Allows spacer area to be clickable
    }
}
