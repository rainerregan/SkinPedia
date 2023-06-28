//
//  CameraSetup.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import Foundation

protocol CameraViewProtocol {
    func setupCamera();
    func checkCameraPermission();
    func saveToCoreData(name : String) async;
}
