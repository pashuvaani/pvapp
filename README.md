# 🐾 PashuVaani App (পশুবাণী / पशुवाणी)

> **AI-Powered Tele-Veterinary & Animal Healthcare Platform** for Pets (Dogs, Cats, Birds) & Livestock (Cattle, Buffalo, Goat, Poultry, Equine).

---

## 🎨 Brand Design & Color Palette System

| Design Token | Color Name | Hex | Usage & Weight |
|---|---|---|---|
| `primaryDeepGreen` | Primary Deep Green 🌲 | `#08765B` | Primary headers, active buttons, brand anchor |
| `primaryGreen` | Primary Green 🟢 | `#0E8F6D` | Accent icons, badges, secondary buttons |
| `teal` | Teal 🟦🟢 | `#16A6A0` | Main gradient midpoint, tab indicators |
| `brightAqua` | Bright Aqua 💧 | `#39C9C2` | Gopu AI glow, highlights, active states |
| `freshLimeAccent` | Fresh Lime Accent 🍃 | `#A8E63B` | Brand signature accent, notification badges |
| `softMint` | Soft Mint 🌿 | `#DDF5EC` | Chip backgrounds, light fills, card highlights |
| `lightMintBg` | Light Mint Background 🍃 | `#EFFAF5` | Screen background tint, chat bubble tint |
| `appBackground` | App Background 🤍 | `#F8FAF9` | **70% Base Surface Color** |
| `cardWhite` | Pure White ⬜ | `#FFFFFF` | Cards, modals, elevated containers |
| `primaryText` | Primary Text 🌑 | `#1E2933` | Headings, titles, high contrast text |
| `secondaryText` | Secondary Text ◻️ | `#667085` | Subtitles, captions, metadata |
| `borderDivider` | Border / Divider | `#E5ECE9` | Card borders, input field outlines |
| `softYellowAccent` | Soft Yellow Accent 🌟 | `#F6D365` | Ratings, stars, warnings, highlights |
| `emergencyRed` | Emergency / Alert 🔴 | `#E74C3C` | SOS Hotline, critical alerts |

### 🌈 Gradients

- **Main Gradient**: `linear-gradient(135deg, #08765B 0%, #16A6A0 55%, #39C9C2 100%)`
- **Brand Signature Gradient**: `#08765B → #A8E63B → #39C9C2`

---

## 📁 File Structure

```text
pashuvaani_app/
├── android/
├── ios/
├── web/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_constants.dart
│   │   │   └── app_styles.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── network/
│   │   │   └── api_client.dart
│   │   ├── routes/
│   │   │   └── app_routes.dart
│   │   └── utils/
│   │       └── helpers.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── pet_model.dart
│   │   ├── doctor_model.dart
│   │   ├── appointment_model.dart
│   │   ├── product_model.dart
│   │   └── health_record_model.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   ├── chat_service.dart
│   │   ├── appointment_service.dart
│   │   ├── video_call_service.dart
│   │   ├── notification_service.dart
│   │   └── product_service.dart
│   ├── features/
│   │   ├── auth/ (login, signup)
│   │   ├── home/ (home_screen)
│   │   ├── gopu_ai/ (chat_screen, controller, widgets)
│   │   ├── consultation/ (screen, booking, doctor_list, video_call)
│   │   ├── vet_team/ (vet_list, vet_profile)
│   │   ├── products/ (product_list, detail, cart)
│   │   ├── pets/ (pet_profile, add_pet)
│   │   ├── health_records/ (records, vaccination)
│   │   ├── emergency/ (emergency_screen)
│   │   └── profile/ (profile_screen)
│   └── shared/
│       ├── widgets/ (custom_button, text_field, card, gradient_header)
│       └── components/ (bottom_nav_bar, pet_avatar)
└── assets/
    ├── images/ (logo, gopu, pets, doctors, products)
    ├── icons/
    └── fonts/
```

---

## 🖼 Asset Upload Instructions

Once the code is ready, place your image assets in their respective directories:
- `assets/images/logo/` -> Logo files (`logo.png`, `logo_white.png`, `logo_icon.png`)
- `assets/images/gopu/` -> Gopu AI avatar & mascot assets (`gopu_avatar.png`, `gopu_mascot.png`)
- `assets/images/pets/` -> Default animal placeholders (`dog.png`, `cat.png`, `cow.png`, `goat.png`)
- `assets/images/doctors/` -> Veterinarian headshots
- `assets/images/products/` -> Pharmacy & pet products
