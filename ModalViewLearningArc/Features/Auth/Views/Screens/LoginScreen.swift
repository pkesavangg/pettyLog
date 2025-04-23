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
    @State private var showCredentialsNotSavedAlert = false
    
    @State private var alertMessage: String?
    @State private var showSaveCredentialsPrompt = false
    @State private var showSettingsPrompt = false
    @State private var canSaveCredentials = false
    
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
                    
                    VStack(spacing: 25) {
                        PrimaryButton(
                            title: CommonStrings.login,
                            isLoading: isLoading
                        ) {
                            Task { await handleLogin() }
                        }
                        
                        
                        if authModel.getBiometricType() != .none {
                            Button {
                                authModel.requestBiometricUnlock { result in
                                    switch result {
                                    case .success(let credentials):
                                        Task {
                                            await handleBioMetricLogin(email: credentials.email, password: credentials.password)
                                        }
                                    case .failure(let authError):
                                        switch authError {
                                        case .credentialsNotSaved:
                                            showSaveCredentialsPrompt = true
                                        case .deniedAccess:
                                            showSettingsPrompt = true
                                        default:
                                            alertMessage = authError.localizedDescription
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: authModel.getBiometricType() == .faceID ? AppAssets.faceId : AppAssets.fingerprint)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(theme.onBackground.opacity(0.6))
                            }
                        }
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
        .alert("Biometric Access Denied", isPresented: $showSettingsPrompt) {
            Button("Go to Settings") {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("You denied biometrics access to the app. If you want to enable it, go to Settings and allow Face ID or Touch ID access.")
        }
        .alert("Biometric Error", isPresented: Binding(get: {
            alertMessage != nil
        }, set: { newValue in
            if !newValue { alertMessage = nil }
        })) {
            Button("OK", role: .cancel) { alertMessage = nil }
        } message: {
            Text(alertMessage ?? "")
        }
        .alert("Save Credentials?", isPresented: $showSaveCredentialsPrompt) {
            Button("Save") {
                self.canSaveCredentials = true
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Would you like to enable Face ID / Touch ID login next time by securely saving your credentials?")
        }
    }
    
    private func handleBioMetricLogin(email: String, password: String) async {
        isLoading = true
        error = nil
        do {
            try await authModel.login(email: email, password: password)
        } catch {
            alertMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    
    private func handleLogin() async {
        loginButtonClicked = true
        if !loginForm.isValid { return }
        
        isLoading = true
        error = nil
        do {
            try await authModel.login(email: loginForm.email, password: loginForm.password)
            
            // Save if not already present
            if canSaveCredentials {
                KeychainManager.save(loginForm.email, for: "userEmail")
                KeychainManager.save(loginForm.password, for: "userPassword")
            }
            
        } catch {
            alertMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    
    
}


#Preview("Not Logged In") {
    LoginScreen()
        .environment(AuthAggregateModel())
        .environmentObject(ThemeManager.shared)
}
