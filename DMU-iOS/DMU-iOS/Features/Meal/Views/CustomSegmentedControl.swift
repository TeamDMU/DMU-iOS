//
//  CustomSegmentedControl.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/17/25.
//

import SwiftUI

struct CustomSegmentedControl: UIViewRepresentable {
    @Binding var selection: MenuType

    let items: [String]

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = items.firstIndex(of: selection == .korean ? "한식 🍚" : "일품 🍛") ?? 0
        segmentedControl.addTarget(context.coordinator, action: #selector(Coordinator.segmentChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let segmentedControl = uiView.subviews.first as? UISegmentedControl {
            segmentedControl.selectedSegmentIndex = items.firstIndex(of: selection == .korean ? "한식 🍚" : "일품 🍛") ?? 0
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var control: CustomSegmentedControl

        init(_ control: CustomSegmentedControl) {
            self.control = control
        }

        @objc func segmentChanged(_ sender: UISegmentedControl) {
            if sender.selectedSegmentIndex == 0 {
                control.selection = .korean
            } else {
                control.selection = .oneDish
            }
        }
    }
}
