import SwiftUI
import UIKit

@main
struct StarterBoardHubApp: App {
    var body: some Scene {
        WindowGroup {
            HubView().preferredColorScheme(.dark)
        }
    }
}

struct HubView: View {
    @State private var showingInfo: HubItem?
    private let items = HubItem.items

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color(red: 0.035, green: 0.045, blue: 0.10), Color(red: 0.08, green: 0.035, blue: 0.16)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("STARTERBOARD").font(.system(size: 12, weight: .bold, design: .rounded)).tracking(3).foregroundStyle(.cyan)
                            Text("System Hub").font(.system(size: 34, weight: .bold, design: .rounded))
                            Text("Shortcuts and information for iOS system components.").font(.subheadline).foregroundStyle(.white.opacity(0.65))
                        }.padding(.top, 12)
                        HStack(spacing: 12) {
                            Image(systemName: "info.circle.fill").foregroundStyle(.cyan)
                            Text("Apple’s private system apps (including SpringBoard and PreBoard) cannot be launched or controlled by an ordinary signed third-party app.").font(.footnote).foregroundStyle(.white.opacity(0.82))
                        }.padding(14).background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 16))
                        Text("SYSTEM DESTINATIONS").font(.caption.weight(.bold)).tracking(1.6).foregroundStyle(.white.opacity(0.55))
                        VStack(spacing: 12) {
                            ForEach(items) { item in
                                Button {
                                    if let url = item.url {
                                        UIApplication.shared.open(url) { success in
                                            if !success { showingInfo = item }
                                        }
                                    } else { showingInfo = item }
                                } label: {
                                    HStack(spacing: 14) {
                                        Image(systemName: item.symbol).font(.title2).foregroundStyle(item.tint).frame(width: 48, height: 48).background(item.tint.opacity(0.14), in: RoundedRectangle(cornerRadius: 13))
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(item.name).font(.headline).foregroundStyle(.white)
                                            Text(item.detail).font(.caption).foregroundStyle(.white.opacity(0.58))
                                        }
                                        Spacer()
                                        Image(systemName: item.url == nil ? "info.circle" : "arrow.up.right").font(.subheadline.weight(.semibold)).foregroundStyle(.white.opacity(0.45))
                                    }.padding(14).background(.white.opacity(0.065), in: RoundedRectangle(cornerRadius: 18)).overlay(RoundedRectangle(cornerRadius: 18).stroke(.white.opacity(0.07), lineWidth: 1))
                                }.buttonStyle(.plain)
                            }
                        }
                        Text("This app uses public iOS APIs. Settings link behavior may vary by iOS version and device configuration.").font(.caption2).foregroundStyle(.white.opacity(0.45)).padding(.top, 4)
                    }.padding(20)
                }
            }.toolbar(.hidden, for: .navigationBar)
            .alert(item: $showingInfo) { item in
                Alert(title: Text(item.name), message: Text(item.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct HubItem: Identifiable {
    let id: String
    let name: String
    let detail: String
    let symbol: String
    let tint: Color
    let url: URL?
    let message: String

    static let items: [HubItem] = [
        HubItem(id: "settings", name: "Settings", detail: "Open iOS Settings", symbol: "gearshape.fill", tint: .cyan, url: URL(string: "App-prefs:"), message: "Your device did not accept the Settings URL. Open Settings from the Home Screen."),
        HubItem(id: "springboard", name: "SpringBoard", detail: "iOS Home Screen process", symbol: "square.grid.2x2.fill", tint: .purple, url: nil, message: "SpringBoard is the protected iOS Home Screen process. iOS provides no public URL or API for third-party apps to launch or control it."),
        HubItem(id: "preboard", name: "PreBoard", detail: "Protected pre-unlock interface", symbol: "lock.fill", tint: .orange, url: nil, message: "PreBoard is an Apple-private system component. A normal signed app cannot launch it or gain its private entitlements through KSign."),
        HubItem(id: "backboard", name: "BackBoard", detail: "System event and input services", symbol: "rectangle.inset.filled", tint: .pink, url: nil, message: "BackBoard services are managed by iOS. They are not standalone apps that third-party apps can open."),
        HubItem(id: "about", name: "About this hub", detail: "Capabilities and limitations", symbol: "iphone", tint: .green, url: nil, message: "StarterBoard Hub is a lightweight public-API launcher and reference. It does not jailbreak the device, inject into system processes, or bypass iOS security.")
    ]
}
