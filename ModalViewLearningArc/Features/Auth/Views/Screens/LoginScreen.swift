import SwiftUI

struct LoginScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @Environment(\.appTheme) private var theme
    @StateObject var router: Router<AuthRoute> = .init()
    @Environment(LoaderManager.self) var loader
    @Environment(ToastManager.self) var toast

    @State private var loginForm = LoginFormConfig()
    @State private var error: String?
    @State private var showResetPasswordAlert = false
    @State private var loginButtonClicked = false
    @State private var showCredentialsNotSavedAlert = false

    @State private var alertMessage: String?
    @State private var showSaveCredentialsPrompt = false
    @State private var showSettingsPrompt = false
    @State private var canSaveCredentials = false

    var alertLang = AlertStrings.self
    var commonLang = CommonStrings.self
    var loaderLang = LoaderStrings.self
    var toastLang = ToastStrings.self

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
                            title: CommonStrings.login
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
                            if loginForm.isEmailValid {
                                loginForm.forgotPasswordEmail = loginForm.email
                            }
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
                TextField(CommonStrings.email, text: $loginForm.forgotPasswordEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    
                Button(CommonStrings.submit) {
                    Task {
                        loader.show(message: loaderLang.sending)
                        do {
                            try await authModel.sendPasswordReset(to: loginForm.forgotPasswordEmail)
                            toast.show("✅ Password reset link sent to your email", duration: 3.0)
                        } catch {
                            toast.show("❌ \(error.localizedDescription)", duration: 3.0)
                        }
                        loginForm.forgotPasswordEmail = ""
                        loader.hide()
                    }
                }
                Button(CommonStrings.cancel, role: .cancel) {}
            } message: {
                Text(CommonStrings.resetPasswordInfo)
            }
            .accentColor(theme.primary)
        }
        .environmentObject(router)
        .alert(alertLang.Biometric.deniedTitle, isPresented: $showSettingsPrompt) {
            Button(commonLang.goToSettings.uppercased()) {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            }
            Button(commonLang.cancel.uppercased(), role: .cancel) {}
        } message: {
            Text(alertLang.Biometric.deniedMessage)
        }
        .alert(alertLang.Biometric.errorTitle, isPresented: Binding(get: {
            alertMessage != nil
        }, set: { newValue in
            if !newValue { alertMessage = nil }
        })) {
            Button(commonLang.ok.uppercased(), role: .cancel) { alertMessage = nil }
        } message: {
            Text(alertMessage ?? "")
        }
        .alert(alertLang.Biometric.savePromptTitle, isPresented: $showSaveCredentialsPrompt) {
            Button(commonLang.save.uppercased()) {
                self.canSaveCredentials = true
            }
            Button(commonLang.cancel, role: .cancel) {}
        } message: {
            Text(alertLang.Biometric.savePromptMessage)
        }
        .onAppear {
            // Clear all keychain items for testing
            // KeychainManager.clearAllKeychainItems()
        }
    }

    private func handleBioMetricLogin(email: String, password: String) async {
        loader.show(message: loaderLang.loggingIn)
        error = nil
        do {
            try await authModel.login(email: email, password: password)
        } catch {
            alertMessage = error.localizedDescription
        }
        loader.hide()
    }

    private func handleLogin() async {
        loginButtonClicked = true
        if !loginForm.isValid { return }
        loader.show(message: loaderLang.loggingIn)
        error = nil
        do {
            try await authModel.login(email: loginForm.email, password: loginForm.password)

            // Save if not already present
            if canSaveCredentials {
                KeychainManager.save(loginForm.email, for: KeychainKeys.userEmail)
                KeychainManager.save(loginForm.password, for: KeychainKeys.userPassword)
            }
        } catch {
            toast.show("❌ \(error.localizedDescription)", duration: 3.0)
        }
        loader.hide()
    }
}


#Preview("Not Logged In") {
    LoginScreen()
        .environment(AuthAggregateModel())
        .environmentObject(ThemeManager.shared)
        .environment(LoaderManager.shared)
        .environment(ToastManager.shared)
}
