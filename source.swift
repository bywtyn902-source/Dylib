import UIKit

class FloatingMenuController {
    static let shared = FloatingMenuController()
    
    private var floatingButton: UIButton?
    private var menuView: UIView?
    private var isMenuVisible = false

    func setupOverlay() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 20, y: 150, width: 60, height: 60)
        btn.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.8)
        btn.setTitle("FOX", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.cornerRadius = 30
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        btn.addGestureRecognizer(panGesture)
        btn.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        
        if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(btn)
            self.floatingButton = btn
        }
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        let translation = gesture.translation(in: view.superview)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        gesture.setTranslation(.zero, in: view.superview)
    }

    @objc private func toggleMenu() {
        isMenuVisible.toggle()
        if isMenuVisible {
            showMenu()
        } else {
            hideMenu()
        }
    }

    private func showMenu() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        
        let container = UIView(frame: CGRect(x: 50, y: 220, width: 280, height: 350))
        container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        container.layer.cornerRadius = 16
        
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 16, width: 248, height: 30))
        titleLabel.text = "FOX CONFIG MENU"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        container.addSubview(titleLabel)
        
        keyWindow.addSubview(container)
        self.menuView = container
    }

    private func hideMenu() {
        menuView?.removeFromSuperview()
        menuView = nil
    }
}
