//
//  UserAgreementView.swift
//  Train
//

import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = UserAgreementViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 8)
                
                Text("Данный документ является действующим, если расположен по адресу: \(viewModel.agreementURL)")
                    .font(.system(size: 17, weight: .regular))
                
                Text("Российская Федерация, город Москва")
                    .font(.system(size: 17, weight: .regular))
                
                Text("1. ТЕРМИНЫ")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.top, 8)
                
                Text("Понятия, используемые в Оферте, означают следующее:")
                    .font(.system(size: 17, weight: .regular))
                
                Text("Авторизованные адреса — адреса электронной почты каждой Стороны. Авторизованным адресом Исполнителя является адрес электронной почты, указанный в разделе 11 Оферты. Авторизованным адресом Студента является адрес электронной почты, указанный Студентом в Личном кабинете.")
                    .font(.system(size: 17, weight: .regular))
                
                Text("Вводный курс — начальный Курс обучения по представленным на Сервисе Программам обучения в рамках выбранной Студентом Профессии или Курсу, рассчитанный на определенное количество часов самостоятельного обучения, который предоставляется Студенту единожды при регистрации на Сервисе на безвозмездной основе. В процессе обучения в рамках Вводного курса Студенту предоставляется возможность ознакомления с работой Сервиса и определения возможности Студента продолжить обучение в рамках Полного курса по выбранной Студентом Программе обучения. Точное количество часов обучения в рамках Вводного курса зависит от выбранной Студентом Профессии или Курса и определяется в Программе обучения, размещенной на Сервисе. Максимальный срок освоения Вводного курса составляет 1 (один) год с даты начала обучения.")
                    .font(.system(size: 17, weight: .regular))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                        Text("")
                    }
                    .foregroundColor(viewModel.isDarkMode ? .white : .black)
                }
            }
        }
        .toolbarBackground(Color("BackgroundColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(viewModel.isDarkMode ? .dark : .light, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        UserAgreementView()
    }
}
