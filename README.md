# ARabeitak Native Android

ARabeitak is a research-grade mobile assistant that helps everyday drivers perform standard maintenance tasks with augmented reality guidance, automated instruction retrieval, and bi-directional tele-assistance. The system couples a Flutter experience for onboarding and task selection with native Android components that render markerless AR scenes (Wikitude), track user gestures (MediaPipe/TFLite), and host an Agora-powered remote assistance call center with ARCore overlays.

## System Overview
- **Scanning** - The user scans the vehicle interior or exterior; Wikitude tracks the scene and anchors overlays without markers (`app/src/main/assets/scenarios/*`).
- **Object detection & recognition** - Recognize vehicle components to anchor arrows, warnings, and 3D models inside each scenario.
- **Instruction retrieval** - Flutter repositories serve curated scenarios plus GPT-backed fallbacks (`arabeitak_flutter_ui/lib/repositories`). A Python/PDF parsing bridge extracts steps from OEM manuals when automation is required.
- **AR overlay & gesture tracking** - `ARWikitudeActivity` streams HTML/JS scenes and samples camera frames every 2 seconds. MediaPipe (`HandDetection.java`) verifies gestures such as cap rotations before advancing to the next step.
- **Remote assistance** - `CallIntroActivity` lets owners join as clients while technicians join as assistants. Agora (4.1.1) handles WebRTC, ARCore renders expert annotations, and custom renderers transmit touch points through a data channel.

## Feature Highlights
- **Flutter UX module** - `arabeitak_flutter_ui` is a reusable module with GoRouter navigation, localization (English/Arabic), onboarding (`IntroductionPage`), car selection, procedure browsers, and a GPT-powered chatbot (`ChatPage`). A `MethodChannel (flutter.native/helper)` bridges Flutter buttons to native AR/remote assistance entry points.
- **AR maintenance scenarios** - Markerless experiences such as _Jumpstart a Dead Battery_, _Add Coolant_, and _Change Tyre_ live under `app/src/main/assets/scenarios/<procedure>`. HTML/CSS/JS code references Wikitude's `ade.js`, overlay assets, audio, and warnings.
- **Gesture-aware safety** - `HandDetection` + `KeyPointClassifier` (MediaPipe Tasks + TensorFlow Lite) detect clockwise vs. anticlockwise motions or "next step" gestures. The activity injects contextual banners (`R.drawable.alert`, `hand_front_right`) to nudge the driver.
- **Tele-assistance with AR annotations** - `remote_assistance/ClientActivity` streams the driver's camera feed into Agora as an external source, receives expert annotations via the data channel, and renders them with ARCore (`PeerRenderer`, `ObjectRenderer`). `AssistantActivity` mirrors the stream, lets experts draw or place directional arrows, and pushes events to clients.
- **Automated content ingestion** - `repositories/pdf_parsing/script.dart` uses `dartpy` and `py_pdf_parser` to scrape OEM manuals for recurring tasks (tooling lists, alternative flows). Combined with GPT completions, this shortens the content authoring loop.

## Repository Layout
```
.
|--- app/                      # Native Android host (Wikitude, ARCore, Agora, MediaPipe)
|   |--- src/main/assets/scenarios/       # HTML/JS AR experiences per procedure
|   |--- src/main/java/com/wikitude/      # AR activities + gesture detection
|   |--- src/main/java/remote_assistance/ # Agora/ARCore tele-assistance stack
|   `--- build.gradle                     # SDK versions, Wikitude + Flutter integration
|--- arabeitak_flutter_ui/     # Flutter module embedded in the host app
|   |--- lib/presentation/                # Screens (introduction, car catalog, instructions, chat)
|   |--- lib/domain/                      # Car/procedure/testing models
|   `--- pubspec.yaml                     # Flutter & plugin dependencies
|--- plugins/, wikitude-sdk/              # Native Wikitude plugin sources bundled with the app
`--- README.md
```

## Getting Started
### Prerequisites
- Android Studio / Gradle with Android SDK 33, NDK 21e+, and Java 11.
- Flutter 3.x with Dart >= 2.18 (`flutter doctor` should pass).
- Python 3.10+ with `py_pdf_parser` (only if you run the PDF parsing script).
- An ARCore-capable Android device with camera + microphone access for AR and tele-assistance.

### Install dependencies
```bash
# Flutter assets
cd arabeitak_flutter_ui
flutter pub get

# Back to the Android host
cd ..
./gradlew tasks   # downloads Gradle wrappers and verifies plugins
```

### Build & run
1. Open the root folder (`Arabeitak-Native-Android`) in Android Studio.
2. Let Gradle sync; the Flutter module is imported through `include_flutter.groovy` inside `settings.gradle`.
3. Connect an Android device (camera + ARCore support required).
4. From Android Studio, choose the `app` configuration and press **Run**. The launcher activity immediately boots the Flutter experience that pilots the rest of the workflows.


## Configuration
| Concern | File | Notes |
| --- | --- | --- |
| Wikitude license | `app/src/main/res/values/wikitude_license_key.xml` | Replace with your own key from the Wikitude developer portal. |
| Agora credentials | `app/src/main/java/remote_assistance/CustomUtilities.java` | Update `appId`, `channelName`, `token`, and optionally `uid`. |
| OpenAI API token | `arabeitak_flutter_ui/lib/licenses/keys.dart` | Store secrets securely; never check real tokens into version control. |
| Native <-> Flutter routes | `app/src/main/java/com/wikitude/samples/MainActivity.java` & `arabeitak_flutter_ui/lib/main.dart` | Maintain the `MethodChannel` names and switch statements to align Flutter route names with native activities/procedures. |
| AR scenario assets | `app/src/main/assets/scenarios/<procedure>` | Include `index.html`, `css`, `js`, media, and `.wt3` models. Update `ARWikitudeActivity` to load new folders. |

## Typical Workflows
1. **Explore & select procedures** - Launch the app, swipe through cars on the Flutter home page, and open `Maintenance Procedures` or `More about my car`. Procedures are grouped by maintenance vs. feature familiarization and backed by `TestingProcedure` models.
2. **Launch AR instructions** - From `InstructionsPage`, tap **Open in AR**. Flutter invokes `navigateToPage()`, which triggers `MainActivity.navigateToPage` to start `ARWikitudeActivity` with the requested `procedure` extra.
3. **Complete steps with gesture validation** - The AR scene displays textual/audio cues plus animated arrows. The background thread samples frames, runs MediaPipe hand detection, and either advances the script, shows warnings, or prompts the user to correct their motion.
4. **Request remote assistance** - Choose **Remote Assistance** on the Flutter card. The native activity asks whether to request or provide support. Clients stream their ARCore view into Agora and see expert annotations anchored on their scene.
5. **Chat with AI / auto-fetch instructions** - Use the chatbot to query GPT (`text-davinci-003`). The `repositories/gpt.dart` helper caches previous prompts to minimize costs. The PDF parsing bridge can ingest OEM manuals to seed future procedures.

## Extending the Project
- **Add a new AR procedure**: create `app/src/main/assets/scenarios/<name>` with your HTML experience, register it in `ARWikitudeActivity` and `MainActivity#navigateToPage`, then expose the procedure inside the Flutter UI (e.g., `TestingProcedure`, `Procedures.proceduresList`).
- **Automate more content**: plug additional user manual PDFs into `repositories/pdf_parsing/script.dart` or implement REST repositories inside `lib/repositories` to fetch instructions dynamically.

## Academic Context

This project originated from an academic graduation project focused on markerless, AR-enabled automotive maintenance.

- *Markerless Augmented Reality Platform for User Support — “ARabeitak” Car Maintenance App* (publication pending)
- **Research Contributors:** Judy Wagdy, Laila Hany, Rana Raafat, Steven Albert
- **Academic Supervisors:** Dr. Essam Eliwa, Eng. Nada Ayman
- **Prior Repositories:**
  - [AR-Automotive-Assistance](https://github.com/judykhairalla/AR-Automotive-Assistance)
  - [RemoteAssistance](https://github.com/judykhairalla/RemoteAssistance)
- **Related Work:**
  - [Augmented Reality Applications in the Automotive Industry](https://ieeexplore.ieee.org/document/10278357)