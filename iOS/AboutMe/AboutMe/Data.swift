//
//  Data.swift
//  AboutMe
//
//  Created by 석민솔 on 1/30/24.
//

import Foundation
import SwiftUI

struct Info {
    let image: String
    let name: String
    let story: String
    let hobbies: [String]
    let foods: [String]
    let colors: [Color]
    let funFacts: [String]
}

let information = Info(
    image: "profileImage",
    name: "민솔",
    story: "A sotry can be about anything you dream up. There are no right answers, There is no one else. \n\nNeed some inspiration?\n• 🐶🐱🛶️🎭🎤🎧🎸\n• 🏄‍♀️🚵‍♀️🚴‍♀️⛵️🥾🏂⛷📚\n• ✍️🥖☕️🏋️‍♂️🚲🧗‍♀️\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim lectus, hendrerit varius elementum at, posuere ut nibh. Aenean aliquet dapibus malesuada. Sed ac turpis id est finibus lacinia. Cras luctus nunc nec faucibus ultricies. Aliquam dictum ipsum non velit gravida euismod. Maecenas feugiat nisl ut justo tempus porta. Nullam ultrices eu lectus ac bibendum. Donec dignissim, ligula non tempus imperdiet, ante lacus viverra diam, eget tempor libero felis iaculis lacus. Vestibulum nec nisi eleifend, pulvinar erat eget, molestie tortor.\nPellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut pharetra orci ut egestas varius. Proin sit amet orci dictum, vehicula mauris ut, placerat lacus. Pellentesque eget leo suscipit, gravida massa et, suscipit est. Praesent vitae mauris pulvinar, posuere magna nec, interdum arcu. Nulla eget maximus nunc. Donec ultricies ut tortor id tincidunt. Donec scelerisque vitae dolor a posuere. Vivamus rhoncus vestibulum posuere. Nullam feugiat leo a ultrices imperdiet. Vestibulum tincidunt enim sit amet mollis gravida. Integer id interdum orci. Suspendisse consequat sed mi convallis porta. Nunc quis rhoncus urna, vitae aliquet nibh.\nDonec dignissim elementum posuere. Fusce finibus lacus nunc, tempus vulputate risus molestie eu. Ut vitae turpis non diam tempor blandit. Nam id euismod purus, non rutrum diam. Phasellus posuere pretium mollis. Quisque vitae egestas libero, quis placerat diam. Vestibulum augue leo, aliquet non aliquet suscipit, interdum eu orci. Suspendisse potenti. Nunc fringilla aliquam scelerisque.",
    hobbies: ["movieclapper", "fork.knife",  "book.fill"],
    foods: ["🥐", "🍕", "🍺"],
    colors: [Color.blue, Color.green, Color.yellow],
    funFacts: [
        "가는 집마다 영업을 안한다.",
        "어떤 집은 가보지도 않았는데 찜했다는 이유로 폐업을 한다.",
        "책이 좋아서 문헌정보학과까지 들어갔는데 책이 싫어진다.",
        "고양이를 좋아하는데 털 알러지가 있는 것 같다.",
        "바나나 먹으면 나한테 바나나?😏"
    ]
)
