//
//  StoryPageView.swift
//  ChooseYourOwnStory
//
//  Created by 석민솔 on 1/31/24.
//

import SwiftUI

struct StoryPageView: View {
    
    let story: Story    // an instance of the Story type that contains all of the story’s data
    let pageIndex: Int  // index of the current story page
    
    var body: some View {
        VStack {
            ScrollView {
                Text(story[pageIndex].text) // story text from the current page
            }
            
            // the choices array of the current page in the story
            ForEach(story[pageIndex].choices, id: \Choice.text) { choice in
                NavigationLink(destination: StoryPageView(story: story, pageIndex: choice.destination)) {
                    Text(choice.text)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationTitle("Page \(pageIndex + 1)")   // displays the current page number in the navigation bar
        .navigationBarTitleDisplayMode(.inline)     // controls how the title appears in the navigation bar
    }
}



struct NonlinearStory_Previews: PreviewProvider {
    static var previews: some View {
        StoryPageView(story: story, pageIndex: 0)
    }
}
