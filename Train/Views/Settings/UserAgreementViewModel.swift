//
//  UserAgreementViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class UserAgreementViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var agreementText: String = ""
    @Published var hasAccepted: Bool {
        didSet {
            UserDefaults.standard.set(hasAccepted, forKey: "hasAcceptedUserAgreement")
        }
    }
    @Published var isDarkMode: Bool
    
    let agreementURL: String = "https://yandex.ru/legal/practicum_offer"
    
    init() {
        self.hasAccepted = UserDefaults.standard.bool(forKey: "hasAcceptedUserAgreement")
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        loadAgreementText()
    }
    
    func loadAgreementText() {
        agreementText = """
        Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц
        
        Данный документ является действующим, если расположен по адресу: https://yandex.ru/legal/practicum_offer
        
        Российская Федерация, город Москва
        
        1. ТЕРМИНЫ
        
        Понятия, используемые в Оферте, означают следующее:
        
        Авторизованные адреса — адреса электронной почты каждой Стороны. Авторизованным адресом Исполнителя является адрес электронной почты, указанный в разделе 11 Оферты. Авторизованным адресом Студента является адрес электронной почты, указанный Студентом в Личном кабинете.
        
        Вводный курс — начальный Курс обучения по представленным на Сервисе Программам обучения в рамках выбранной Студентом Профессии или Курсу, рассчитанный на определенное количество часов самостоятельного обучения, который предоставляется Студенту единожды при регистрации на Сервисе на безвозмездной основе. В процессе обучения в рамках Вводного курса Студенту предоставляется возможность ознакомления с работой Сервиса и определения возможности Студента продолжить обучение в рамках Полного курса по выбранной Студентом Программе обучения. Точное количество часов обучения в рамках Вводного курса зависит от выбранной Студентом Профессии или Курса и определяется в Программе обучения, размещенной на Сервисе. Максимальный срок освоения Вводного курса составляет 1 (один) год с даты начала обучения.
        """
    }
    
    func acceptAgreement() {
        hasAccepted = true
    }
    
    func openInBrowser() {
        if let url = URL(string: agreementURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
