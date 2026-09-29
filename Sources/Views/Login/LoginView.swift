import SwiftUI

struct LoginView: View {
    @Environment(AuthStore.self) private var authStore
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppMetrics.spacingStandard) {
                Spacer(minLength: 60)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Welcome to")
                        .font(AppFont.body)
                        .foregroundStyle(Color.brandTextSecondary)
                    Text("Fashion Shop")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.brandTextPrimary)
                }
                .padding(.bottom, 24)

                VStack(alignment: .leading, spacing: AppMetrics.spacingStandard) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(AppFont.caption)
                            .foregroundStyle(Color.brandTextSecondary)
                        TextField("demo@shop.com", text: $email)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.brandCardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusMedium, style: .continuous))
                            .accessibilityIdentifier("login_email_field")
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(AppFont.caption)
                            .foregroundStyle(Color.brandTextSecondary)
                        SecureField("••••••", text: $password)
                            .padding()
                            .background(Color.brandCardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusMedium, style: .continuous))
                            .accessibilityIdentifier("login_password_field")
                    }

                    if let errorMessage = authStore.errorMessage {
                        Text(errorMessage)
                            .font(AppFont.caption)
                            .foregroundStyle(.red)
                            .accessibilityIdentifier("login_error_message")
                    }

                    Button("Log In") {
                        authStore.login(email: email, password: password)
                    }
                    .buttonStyle(PrimaryPillButtonStyle())
                    .padding(.top, 8)
                    .accessibilityIdentifier("login_submit_button")

                    Text("Demo account: demo@shop.com / 123456")
                        .font(AppFont.caption)
                        .foregroundStyle(Color.brandTextSecondary)
                        .padding(.top, 4)
                }
                .cardStyle()

                Spacer(minLength: 40)
            }
            .padding(.horizontal, AppMetrics.paddingStandard)
        }
        .background(Color.white)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("login_screen")
    }
}
