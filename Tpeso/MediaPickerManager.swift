//
//  Untitled.swift
//  Tpeso
//
//  Created by tom on 2025/5/26.
//

import UIKit
import AVFoundation
import Photos

class MediaPickerHelper {
    
    static let shared = MediaPickerHelper()
    
    private init() {}

    func requestCameraAccess(
        presentingVC: UIViewController,
        cameraHandler: @escaping () -> Void
    ) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            cameraHandler()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    granted ? cameraHandler() : self.showPermissionAlert(.camera)
                }
            }
        default:
            showPermissionAlert(.camera)
        }
    }

    // MARK: - 相册处理
    /// 请求相册权限并在授权后执行
    /// - Parameters:
    ///   - presentingVC: 用于 present 的控制器
    ///   - albumHandler: 权限允许时执行（你可以在这里 present 你的相册控制器）
    func requestPhotoLibraryAccess(
        presentingVC: UIViewController,
        albumHandler: @escaping () -> Void
    ) {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized, .limited:
            albumHandler()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async {
                    (status == .authorized || status == .limited)
                        ? albumHandler()
                        : self.showPermissionAlert(.photo)
                }
            }
        default:
            showPermissionAlert(.photo)
        }
    }

    // MARK: - 权限提示弹窗

    private enum PermissionType {
        case camera, photo
    }

    private func showPermissionAlert(_ type: PermissionType) {
        let title: String
        let message: String

        switch type {
        case .camera:
            title = "Unable to access the camera"
            message = "Please enable camera permission in settings"
        case .photo:
            title = "Unable to access the album"
            message = "Please enable album permission in settings"
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Go", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))

        DispatchQueue.main.async {
            if let topVC = Self.getTopViewController() {
                topVC.present(alert, animated: true)
            }
        }
    }

    // MARK: - 获取顶层控制器

    private static func getTopViewController(base: UIViewController? = UIApplication.shared
        .connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) }
        .first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController {
            return getTopViewController(base: tab.selectedViewController)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
