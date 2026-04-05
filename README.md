# PsyGuard AI

PsyGuard AI 是一款由人工智慧驅動的心理健康支援與陪伴工具，旨在為使用者提供一個安全且具同理心的平台。此 MVP 應用程式使用 Flutter 打造，運用人工智慧提供引導式協助、追蹤情緒趨勢，並作為日常心理健康的可靠夥伴。

## 核心功能

- **AI 陪伴：** 與對話式 AI 互動，獲得情感支持與引導。
- **語音互動：** 透過語音轉文字 (Speech-to-Text) 與文字轉語音 (Text-to-Speech) 功能，支援自然的溝通體驗。
- **趨勢追蹤：** 利用互動式圖表，讓隨時間變化的情緒狀態視覺化。
- **安全的本機儲存：** 採用加密的本機內容與資料庫，確保使用者資料隱私。
- **流暢的導覽：** 透過穩健的路由架構，帶來無縫的使用者體驗。

## 技術堆疊

本應用程式採用 Flutter 框架建置，並結合以下核心套件：

- **框架：** Flutter (Dart)
- **狀態管理：** Riverpod (flutter_riverpod)
- **路由管理：** Go Router (go_router)
- **本機資料庫：** Drift (drift) 與 SQLite
- **網路請求：** Dio (dio)
- **資料視覺化：** FL Chart (fl_chart)
- **語音 API：** speech_to_text 與 flutter_tts
- **Markdown 渲染：** flutter_markdown

## 專案結構

此儲存庫將主要的應用程式放置於 `psyguard_ai_app` 目錄下。關鍵的開發操作皆應在此目錄內執行。

## 開始使用

請依照以下步驟在本地端進行專案環境設定。

### 系統需求

- Flutter SDK (需兼容 ^3.9.2 版本限制)
- Xcode (用於 iOS 開發與測試)
- Android Studio (用於 Android 開發與測試)
- CocoaPods (用於 iOS 套件相依性管理)

### 安裝步驟

1. 進入應用程式目錄：
   ```bash
   cd psyguard_ai_app
   ```

2. 安裝 Dart 依賴套件：
   ```bash
   flutter pub get
   ```

3. 設定環境變數：
   - 在 `psyguard_ai_app` 目錄中建立一個 `.env` 檔案。
   - 參考現有的 `.env.example` 檔案作為範本，填入必要的金鑰（例如 API Token）。

4. 產生程式碼 (如 Drift 資料庫自動生成程式碼等)：
   ```bash
   dart run build_runner build -d
   ```

5. 安裝 iOS 依賴套件 (如果要在 iOS 環境下執行)：
   ```bash
   cd ios
   pod install
   cd ..
   ```

6. 執行應用程式：
   ```bash
   flutter run
   ```

## 授權條款

本專案依照 LICENSE 檔案中提供的授權條款進行授權。
