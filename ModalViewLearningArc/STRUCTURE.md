ModalViewLearningArc/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── PettyLogApp.swift
│
├── Domain/
│   ├── Models/                    # Swift Data Models
│   │   ├── Entry.swift
│   │   ├── Category.swift
│   │   ├── User.swift
│   │   └── Profile.swift
│   │
│   ├── Storage/
│   │   ├── SwiftDataContainer.swift
│   │   ├── StorageError.swift
│   │   └── Migrations/
│   │       └── SchemaMigrationPlan.swift
│   │
│   └── Repositories/
│       ├── Protocols/
│       │   ├── EntryRepository.swift
│       │   ├── CategoryRepository.swift
│       │   ├── UserRepository.swift
│       │   └── AuthRepository.swift
│       │
│       └── Implementations/
│           ├── Local/
│           │   ├── SwiftDataEntryRepository.swift
│           │   ├── SwiftDataCategoryRepository.swift
│           │   └── SwiftDataUserRepository.swift
│           │
│           ├── Remote/
│           │   ├── FirebaseEntryRepository.swift
│           │   ├── FirebaseCategoryRepository.swift
│           │   └── FirebaseAuthRepository.swift
│           │
│           └── Synced/
│               ├── SyncedEntryRepository.swift
│               └── SyncedCategoryRepository.swift
│
├── Features/
│   ├── Auth/
│   │   ├── Stores/
│   │   │   ├── LoginStore.swift
│   │   │   ├── SignupStore.swift
│   │   │   └── BiometricStore.swift
│   │   │
│   │   └── Views/
│   │       ├── Screens/
│   │       │   ├── LoginScreen.swift
│   │       │   └── SignupScreen.swift
│   │       └── Components/
│   │           ├── LoginForm.swift
│   │           └── BiometricButton.swift
│   │
│   ├── Entry/
│   │   ├── Stores/
│   │   │   └── EntryStore.swift
│   │   │
│   │   └── Views/
│   │       ├── Screens/
│   │       │   ├── EntryListScreen.swift
│   │       │   ├── EntryDetailScreen.swift
│   │       │   └── AddEntryScreen.swift
│   │       └── Components/
│   │           ├── EntryRow.swift
│   │           └── EntryForm.swift
│   │
│   └── Settings/
│       ├── Stores/
│       │   └── SettingsStore.swift
│       └── Views/
│           └── Screens/
│               └── SettingsScreen.swift
│
├── Core/
│   ├── Forms/
│   │   ├── Base/
│   │   │   ├── FormValidator.swift
│   │   │   ├── FormConfig.swift      # Base protocol
│   │   │   └── ValidationError.swift
│   │   │
│   │   ├── Validators/
│   │   │   ├── EmailValidator.swift
│   │   │   ├── PasswordValidator.swift
│   │   │   └── TextValidator.swift
│   │   │
│   │   └── Models/
│   │       ├── ValidationResult.swift
│   │       └── ValidationRule.swift
│   ├── DI/
│   │   └── DependencyContainer.swift
│   │
│   ├── Navigation/
│   │   ├── Router.swift
│   │   └── Routes.swift
│   │
│   ├── Network/
│   │   ├── NetworkMonitor.swift
│   │   └── APIClient.swift
│   │
│   └── Utils/
│       ├── Extensions/
│       │   ├── Date+Extensions.swift
│       │   └── Decimal+Extensions.swift
│       └── Constants/
│           └── AppConstants.swift
│
├── Theme/
│   ├── ThemeManager.swift
│   ├── Colors.swift
│   └── Typography.swift
│
└── Resources/
    ├── Assets.xcassets
    ├── Info.plist
    └── Localizable.strings
│   ├── DI/
│   │   └── DependencyContainer.swift
│   │
│   ├── Navigation/
│   │   ├── Router.swift
│   │   └── Routes.swift
│   │
│   ├── Network/
│   │   ├── NetworkMonitor.swift
│   │   └── APIClient.swift
│   │
│   └── Utils/
│       ├── Extensions/
│       │   ├── Date+Extensions.swift
│       │   └── Decimal+Extensions.swift
│       └── Constants/
│           └── AppConstants.swift
│
├── Theme/
│   ├── ThemeManager.swift
│   ├── Colors.swift
│   └── Typography.swift
│
└── Resources/
    ├── Assets.xcassets
    ├── Info.plist
    └── Localizable.strings