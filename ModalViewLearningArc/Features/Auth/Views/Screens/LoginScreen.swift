import SwiftUI

struct LoginScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @Environment(\.appTheme) private var theme
    @StateObject var router: Router<AuthRoute> = .init()
    
    @State private var loginForm = LoginFormConfig()
    @State private var error: String?
    @State private var isLoading = false
    @State private var showResetPasswordAlert = false
    @State private var loginButtonClicked = false
    
    var body: some View {
        RoutingView(stack: $router.stack) {
            VStack {
                Spacer(minLength: 60)
                
                VStack(spacing: 16) {
                    Image(systemName: AppAssets.loginIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(theme.primary)
                    
                    Text(LandingScreenStrings.welcomeBack)
                        .font(.largeTitle.bold())
                        .foregroundColor(theme.onBackground)
                    
                    Text(LandingScreenStrings.instruction)
                        .font(.subheadline)
                        .foregroundColor(theme.onBackground.opacity(0.6))
                        .multilineTextAlignment(.center)
                    
                    VStack(spacing: 20) {
                        CustomTextField(
                            value: $loginForm.email,
                            placeholder: CommonStrings.email,
                            inputType: .email
                        )
                        
                        CustomTextField(
                            value: $loginForm.password,
                            placeholder: CommonStrings.password,
                            inputType: .passwordWithToggle
                        )
                    }
                    
                    ValidationMessageView(message: loginForm.validationErrorMessage, show: loginButtonClicked)
                    
                    PrimaryButton(
                        title: CommonStrings.login,
                        isLoading: isLoading
                    ) {
                        Task { await handleLogin() }
                    }

                    LinkButton(title: CommonStrings.signup, isDisabled: false) {
                        router.navigate(to: .signup)
                    }
                    
                    VStack(spacing: 10) {
                        Text(CommonStrings.resetPasswordInfo)
                            .font(.caption)
                            .foregroundColor(theme.onBackground.opacity(0.6))
                            .multilineTextAlignment(.center)
                        
                        LinkButton(title: CommonStrings.forgotPassword, isDisabled: false) {
                            showResetPasswordAlert = true
                        }
                    }
                    .padding(.top, .p8)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(theme.surface)
                        .shadow(radius: 2)
                )
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .background(theme.background.ignoresSafeArea())
            .alert(CommonStrings.resetPasswordTitle, isPresented: $showResetPasswordAlert) {
                TextField(CommonStrings.email, text: $loginForm.email)
                Button(CommonStrings.submit) {
                    Task {
                        try? await authModel.sendPasswordReset(to: loginForm.email)
                    }
                }
                Button(CommonStrings.cancel, role: .cancel) {}
            } message: {
                Text(CommonStrings.resetPasswordInfo)
            }
            .accentColor(theme.primary)
        }
        .environmentObject(router)
    }
    
    private func handleLogin() async {
        self.loginButtonClicked = true
        if !loginForm.isValid {
            return
        }
        isLoading = true
        error = nil
        do {
            try await authModel.login(email: loginForm.email, password: loginForm.password)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}


#Preview("Not Logged In") {
    LoginScreen()
        .environment(AuthAggregateModel())
        .environmentObject(ThemeManager.shared)
}
