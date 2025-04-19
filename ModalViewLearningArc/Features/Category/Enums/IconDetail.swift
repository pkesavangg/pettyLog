//
//  IconDetail.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//


import Foundation

struct IconDetail: Hashable {
    let iconName: String
    let categoryName: String
}

enum CategoryIconConstants {
    static let allIcons: [IconDetail] = [
        IconDetail(iconName: "fork.knife", categoryName: "Food"),
        IconDetail(iconName: "externaldrive.fill.badge.plus", categoryName: "Laptop Accessories"),
        IconDetail(iconName: "airplane", categoryName: "Travelling"),
        IconDetail(iconName: "envelope.fill", categoryName: "Postage"),
        IconDetail(iconName: "printer.fill", categoryName: "Stationery & Printing"),
        IconDetail(iconName: "gift.fill", categoryName: "Poojai Items"),
        IconDetail(iconName: "book.fill", categoryName: "Course Purchase"),
        IconDetail(iconName: "arrow.2.squarepath", categoryName: "Transaction Charges"),
        IconDetail(iconName: "cross.case.fill", categoryName: "Medicines"),
        IconDetail(iconName: "party.popper.fill", categoryName: "Celebration items"),
        IconDetail(iconName: "person.3.fill", categoryName: "Team Outing"),
        IconDetail(iconName: "takeoutbag.and.cup.and.straw.fill", categoryName: "Kitchen Tools"),
        IconDetail(iconName: "iphone.rear.camera", categoryName: "Mobile Accessories"),
        IconDetail(iconName: "sportscourt.fill", categoryName: "Sports Items"),
        IconDetail(iconName: "bolt.fill", categoryName: "Electricals and Hardwares"),
        IconDetail(iconName: "figure.walk.motion", categoryName: "Turf/Court Expense"),
        IconDetail(iconName: "face.smiling", categoryName: "Fun Friday Items"),
        IconDetail(iconName: "creditcard.fill", categoryName: "Card Charges"),
        IconDetail(iconName: "doc.text.fill", categoryName: "Subscriptions"),
        IconDetail(iconName: "giftcard.fill", categoryName: "Gifts"),
        IconDetail(iconName: "building.2.crop.circle.fill", categoryName: "Expo"),
        IconDetail(iconName: "paintbrush.pointed.fill", categoryName: "Decoration Items"),
        IconDetail(iconName: "banknote.fill", categoryName: "Petty Expense"),
        IconDetail(iconName: "wrench.and.screwdriver.fill", categoryName: "Maintenance"),
        IconDetail(iconName: "cart.fill", categoryName: "Office Supplies"),
        IconDetail(iconName: "fuelpump.fill", categoryName: "Fuel"),
        IconDetail(iconName: "bed.double.fill", categoryName: "Accommodation"),
        IconDetail(iconName: "mappin.and.ellipse", categoryName: "Local Travel"),
        IconDetail(iconName: "tshirt.fill", categoryName: "Uniforms"),
        IconDetail(iconName: "trophy.fill", categoryName: "Incentives"),
        IconDetail(iconName: "person.badge.plus.fill", categoryName: "Hiring"),
        IconDetail(iconName: "building.columns.fill", categoryName: "Banking"),
        IconDetail(iconName: "wifi", categoryName: "Internet"),
        IconDetail(iconName: "speaker.wave.2.fill", categoryName: "Marketing"),
        IconDetail(iconName: "doc.richtext", categoryName: "Legal & Compliance")
    ]
}
