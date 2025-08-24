# API解説


## 制御命令シーケンス全体の構造

MQTTブローカーに関する情報と，アクチュエータを制御する命令の列の組み合わせ．


```
mqtt:
  server: '192.168.11.252'   # MQTTブローカーが動作するサーバのIPアドレス
  port: 1883                 # MQTTブローカーのポート番号
  topic: 'arduino/actuator'  # 制御命令送信に用いるMQTTトピック

sequence:
  - class : 'command'  # 'command(制御命令)'と'wait(待機)'の2種類
    id: 0              # 制御対象のアクチュエータに付けられている番号
    type: 103          # 制御対象のアクチュエータの種類を表す番号
    time: 234567890    # ログ解析時に利用する時刻(UNIX時間)
    command: 4         # 制御命令の種類(整数)
    paramSize: 1       # パラメータの数 (配列変数paramの要素数)
    param: [
      {
        x: 0,
        y: 0
      }
    ]
  - class : 'wait'     # MQTTで制御命令を送信するのを待つ指示
    value : 3          # 3秒待機
```

## MQTT関連パラメータ

```
mqtt:
  server: '192.168.11.252'   # MQTTブローカーが動作するサーバのIPアドレス
  port: 1883                 # MQTTブローカーのポート番号
  topic: 'arduino/actuator'  # 監視対象のMQTTトピック
```

MQTTブローカーのIPアドレス，ポート番号に加えて，制御対象のアクチュエータに命令を送るために
用いるトピックを指定する．

## 待機

MQTTで制御命令を送る途中に待ち時間が必要になる場合がある．この待機を実現するために，秒単位での待ち時間を指定する．

```
  - class : 'wait'     # MQTTで制御命令を送信するのを待つ指示
    value : 3          # 3秒待機
```

## 制御命令に付与する情報
- id : IoTのセンサ端末に接続されているアクチュエータにはID(整数)が付与されているはずなので，そのIDを記入する．
- type : 制御対象のアクチュエータの種類を表す番号で103番はArduino Liquid Crystalライブラリで動作するキャラクタディスプレイを表す．
- time : ログに残し，何かの解析の際に利用するための時刻情報． ここには，UNIX時間で時刻を記入する．もし，0を入力すると，送信時点の時刻情報が付加される．
```
  - class : 'command'  # 'command(制御命令)'と'wait(待機)'の2種類
    id: 0              # 制御対象のアクチュエータに付けられている番号
    type: 103          # 制御対象のアクチュエータの種類を表す番号
    time: 234567890    # ログ解析時に利用する時刻(UNIX時間)
```

## アクチュエータデバイスの種類


### キャラクタディスプレイ

キャラクタディスプレイとして利用できる周辺回路(モジュール)の種類は3種類で，それぞれ異なるデバイスドライバ(Arduinoライブラリ)を
利用する．下の表の右端の欄は該当する周辺回路の例である．

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|101|[Grove - LCD RGB Backlight](https://github.com/Seeed-Studio/Grove_LCD_RGB_Backlight "Grove - LCD RGB Backlight")| [Grove - LCD RGB Backlight](https://wiki.seeedstudio.com/Grove-LCD_RGB_Backlight/ "Grove - LCD RGB Backlight")|
|102|[Arduino ACM1602NI library](https://github.com/furushei/ACM1602NI-Arduino "Arduino ACM1602NI library")|[I2C接続キャラクターLCDモジュール](https://akizukidenshi.com/catalog/g/g105693/ "ACM1602NI使用キャラクタディスプレイ(秋月電子)")|
|103|[LiquidCrystal](https://docs.arduino.cc/libraries/liquidcrystal/ "LiquidCrystal")|[LCDキャラクターディスプレイモジュール](https://akizukidenshi.com/catalog/g/g100038/ "LCDキャラクターディスプレイモジュール(秋月電子)")|



### LED

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|201|なし|[Grove LED](https://wiki.seeedstudio.com/Grove-Red_LED/ "Grove LED")をアナログ端子に接続|
|202|[Grove - LED Barライブラリ](https://github.com/Seeed-Studio/Grove_LED_Bar "Grove_LED_Barライブラリ")|[Grove - LED Bar](https://wiki.seeedstudio.com/Grove-LED_Bar/ "Grove - LED Bar"), [Grove - Circular LED](https://wiki.seeedstudio.com/Grove-Circular_LED/ "Grove - Circular LED")|
|203|なし|[RGB LEDカソードコモン](https://akizukidenshi.com/catalog/g/g102476/ "RGB LEDカソードコモン")|
|204|[Adafruit NeoPixel Library](https://github.com/adafruit/Adafruit_NeoPixel "Adafruit NeoPixel Library")|[Grove - RGB LED Stick (10 - WS2813 Mini)](https://wiki.seeedstudio.com/Grove-RGB_LED_Stick-10-WS2813_Mini/ "Grove - RGB LED Stick (10 - WS2813 Mini)")|
||[ChainableLED](https://github.com/pjpmarques/ChainableLED "ChainableLED")|[Grove - Chainable RGB LED](https://wiki.seeedstudio.com/Grove-Chainable_RGB_LED/ "Grove - Chainable RGB LED")|


### NセグメントLED


| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|301|なし|[16セグメントLED](https://akizukidenshi.com/catalog/g/g114656/ "アノードコモン16セグメントLED")|
|302|なし|[2桁14セグメントLED](https://akizukidenshi.com/catalog/g/g116389/ "2桁14セグメントLED")|
|303|なし|[3桁7セグメントLED](https://akizukidenshi.com/catalog/g/g117364/ "3桁7セグメントLED")|
|304|なし|[Grove - 4-Digit Display](https://wiki.seeedstudio.com/Grove-4-Digit_Display/ "Grove - 4-Digit Display")|




### 単純ON/OFFデバイス


| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|401|なし|LEDやリレーをデジタル端子に接続|



### サーボ

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|501|[Servoライブラリ](https://docs.arduino.cc/libraries/servo/ "Arduino Servoライブラリ")|[Grove - Servo](https://wiki.seeedstudio.com/Grove-Servo/ "Grove - Servo")|


### 単純サウンド(スピーカ等)

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|601|なし|[Grove - Speaker](https://wiki.seeedstudio.com/Grove-Speaker/ "Grove - Speaker"), [Grove - Buzzer](https://wiki.seeedstudio.com/Grove-Buzzer/ "Grove - Buzzer") |


### 単純PMWデバイス

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|701|なし|LED等の単純なデジタル端子で動作するデバイスをPMW対応デジタル端子に接続|



### IRDA(赤外線リモコン)

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|801|[IRremote](https://docs.arduino.cc/libraries/irremote/ "IRremote")|[Grove - Infrared Emitter](https://wiki.seeedstudio.com/Grove-Infrared_Emitter/ "Grove - Infrared Emitter")|


### MP3プレーヤ


| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|901|[Grove Serial MP3 Player](https://github.com/Seeed-Studio/Seeed_Serial_MP3_Player "Grove Serial MP3 Player")|[KT403A](https://wiki.seeedstudio.com/Grove-MP3_v2.0/ "Grove - MP3 v2.0")|
|902|同上|[WT2003S](https://wiki.seeedstudio.com/Grove-MP3-v3/ "Grove - MP3 v3.0")|
|903|同上|[WT2605](https://wiki.seeedstudio.com/grove_mp3_v4/ "Grove - MP3 v4.0")|
|904|[DFPlayer lib](https://github.com/DFRobot/DFRobotDFPlayerMini "DFPlayer - A Mini MP3 Player For Arduino")|[DFPlayer Mini](https://wiki.dfrobot.com/DFPlayer_Mini_SKU_DFR0299 "DFPlayer Mini")|


### グラフィックディスプレイ

| デバイスタイプ番号 | デバイスドライバ | 製品例 |
|---|---|---|
|1001|[U8g2](https://docs.arduino.cc/libraries/u8g2/ "U8g2")||
|1002|[Arduino_GigaDisplay_GFX](https://github.com/arduino-libraries/Arduino_GigaDisplay_GFX "Arduino_GigaDisplay_GFX")|[GIGA Display Shield](https://docs.arduino.cc/hardware/giga-display-shield/ "GIGA Display Shield")|
|1003|[TFT_eSPI](https://github.com/Bodmer/TFT_eSPI "TFT_eSPI")||
|1004|[Adafruit GFX Library](https://github.com/adafruit/Adafruit-GFX-Library "Adafruit GFX Library")||



## キャラクタディスプレイ用コマンド

### ``Clear``

- 機能 : 画面消去
- コマンド番号 : 1
- パラメータ　: なし

|デバイスタイプ番号| 101 | 102 | 103 |
|---|---|---|---|
|利用可能性|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 1
    paramSize: 0
```

### ``Home``

- 機能 : カーソル位置を画面上の原点に設定
- コマンド番号 : 2
- パラメータ　: なし


|デバイスタイプ番号| 101 | 102 | 103 |
|---|---|---|---|
|利用可能性|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 2
    paramSize: 0
```

### ``Set mode``

- 機能 : 動作モードの設定
- コマンド番号 : 3
- パラメータ　: モードを表す整数


|値|シンボル|意味| 101 | 102 | 103 |
|---|---|---|---|---|---|
|1|NO_DISPLAY|画面を消す|◯|◯|◯|
|2|ON_DISPLAY|画面を点ける|◯|◯|◯|
|3|NO_BLINK|カーソルの点滅を止める|◯|◯|◯|
|4|BLINK|カーソルを点滅させる|◯|◯|◯|
|5|NO_CURSOR|カーソルを消す|◯|◯|◯|
|6|CURSOR|カーソルを点ける|◯|◯|◯|
|7|SCROLL_LEFT|左に向かってスクロール|◯|◯|◯|
|8|SCROLL_RIGHT|右に向かってスクロール|◯|◯|◯|
|9|LEFT_TO_RIGHT|左から右に表示|◯|◯|◯|
|10|RIGHT_TO_LEFT|右から左に表示|◯|◯|◯|
|11|AUTO_SCROLL|自動スクロールをON|◯|◯|◯|
|12|NO_AUTO_SCROLL|自動スクロールをOFF|◯|◯|◯|
|13|BLINK_BACKLIGHT|バックライトをON|◯|✕|✕|
|14|NO_BLINK_BACKLIGHT|バックライトをOFF|◯|✕|✕|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 3
    paramSize: 1
    param: [
      {
        mode: 11
      }
    ]
```

### ``Set cursor``

- 機能 : カーソル位置を設定
- コマンド番号 : 4
- パラメータ : x座標(列), y座標(行)

|デバイスタイプ番号| 101 | 102 | 103 |
|---|---|---|---|
|利用可能性|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 4
    paramSize: 1
    param: [
      {
        x: 16,
        y: 1
      }
    ]
```


### ``Set size``

- 機能 : 画面サイズの設定
- コマンド番号 : 5
- パラメータ : x座標(列), y座標(行), フォントサイズ

|デバイスタイプ番号| 101 | 102 | 103 |
|---|---|---|---|
|利用可能性|◯|△|◯|

デバイスタイプ102番(ACM1602NI使用LCD)は，フォントサイズの指定は無効

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 5
    paramSize: 1
    param: [
      {
        col: 1,
        row: 2,
        font: 3
      }
    ]
```


### ``print``

- 機能 : 文字列の印字
- コマンド番号 : 6
- パラメータ : 印字する文字列

|デバイスタイプ番号| 101 | 102 | 103 |
|---|---|---|---|
|利用可能性|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 6
    paramSize: 1
    param: [
      {
        text: '0'
      }
    ]
```

### ``Set backlight RGB``

- 機能 : バックライトの色設定
- コマンド番号 : 7
- パラメータ : r,g,b (それぞれ0から255の値)

|デバイスタイプ番号| 101 | 102 | 103 |
|---|---|---|---|
|利用可能性|◯|✕|✕|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 7
    paramSize: 1
    param: [
      {
        red: 255,
        green: 255,
        blue: 255
      }
    ]
```

## LED用コマンド

### ``Clear``


- 機能 : 消灯
- コマンド番号 : 1
- パラメータ　: なし

|デバイスタイプ番号| 201 | 202 | 203 | 204 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 101
    time: 234567890
    command: 1
    paramSize: 0
```


### ``Set blightness``

- 機能 : 明るさの設定
- コマンド番号 : 2
- パラメータ　: 0～1の数

|デバイスタイプ番号| 201 | 202 | 203 | 204 |
|---|---|---|---|---|
|利用可能性|◯|✕|✕|✕|

```
  - class : 'command'
    id: 0
    type: 201
    time: 234567890
    command: 2
    paramSize: 1
    param: [
      {
        brightness: 1.0
      }
    ]
```


### ``Set brightness of No.x``

- 機能 : 明るさの設定
- コマンド番号 : 3
- パラメータ　: LEDの番号(整数), 明るさ(0～1の数)

|デバイスタイプ番号| 201 | 202 | 203 | 204 |
|---|---|---|---|---|
|利用可能性|✕|◯|✕|✕|

```
  - class : 'command'
    id: 0
    type: 201
    time: 234567890
    command: 2
    paramSize: 1
    param: [
      {
        num: 1,
        brightness: 1.0
      }
    ]
```

### ``Set RGB``

- 機能 : 色の設定
- コマンド番号 : 4
- パラメータ　: r,g,b (それぞれ0から255の値)

|デバイスタイプ番号| 201 | 202 | 203 | 204 |
|---|---|---|---|---|
|利用可能性|✕|✕|◯|✕|

```
  - class : 'command'
    id: 0
    type: 203
    time: 234567890
    command: 4
    paramSize: 1
    param: [
      {
        red: 255,
        green: 255,
        blue: 255
      }
    ]
```

### ``Set RGB of No.x``

- 機能 : x番目のLEDの色を設定
- コマンド番号 : 5
- パラメータ　: LEDの番号(整数), r,g,b (それぞれ0から255の値)

|デバイスタイプ番号| 201 | 202 | 203 | 204 |
|---|---|---|---|---|
|利用可能性|✕|✕|✕|◯|

```
  - class : 'command'
    id: 0
    type: 204
    time: 234567890
    command: 5
    paramSize: 1
    param: [
      {
        num: 1,
        red: 255,
        green: 255,
        blue: 255
      }
    ]
```

## NセグメントLED用コマンド

### ``Clear``

- 機能 : 消灯
- コマンド番号 : 1
- パラメータ : なし

|デバイスタイプ番号| 301 | 302 | 303 | 304 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 301
    time: 234567890
    command: 1
    paramSize: 0
```

### ``Set``

- 機能 : 文字とピリオドを印字
- コマンド番号 : 4
- パラメータ : 文字列, ピリオドON/OFFを示すbit列

|デバイスタイプ番号| 301 | 302 | 303 | 304 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|✕|

| デバイスタイプ番号 | 印字可能な文字 |
|---|---|
|301|-, 0から9, A,b,C,d,E,F,G,H,I,J,k,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z|
|302|-, 0から9, A,b,C,d,E,F,G,H,I,J,k,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z|
|303|-, 0から9, A,b,C,d,E,F|
|304||

```
  - class : 'command'
    id: 0
    type: 301
    time: 234567890
    command: 4
    paramSize: 1
    param: [
      {
        text: 'a',
        period: 0
      }
    ]
```

### ``Set blightness``

- 機能 : LEDの輝度を変更
- コマンド番号 : 2
- パラメータ　: 0から1の間の値

|デバイスタイプ番号| 301 | 302 | 303 | 304 |
|---|---|---|---|---|
|利用可能性|✕|✕|✕|◯|

```
  - class : 'command'
    id: 0
    type: 304
    time: 234567890
    command: 2
    paramSize: 1
    param: [
      {
        brightness: 1.0
      }
    ]
```

### ``Set colon``

- 機能 : 中央のコロンのON/OFFを切り替え
- コマンド番号 : 3
- パラメータ　: ON/OFF (0/1)

|デバイスタイプ番号| 301 | 302 | 303 | 304 |
|---|---|---|---|---|
|利用可能性|✕|✕|✕|◯|

```
  - class : 'command'
    id: 0
    type: 304
    time: 234567890
    command: 3
    paramSize: 1
    param: [
      {
        flag: 1
      }
    ]
```

### ``Setc``

- 機能 : 文字の印字
- コマンド番号 : 5
- パラメータ　: 文字列 (-, 0から9, A,b,C,d,E,Fの組み合わせ)

|デバイスタイプ番号| 301 | 302 | 303 | 304 |
|---|---|---|---|---|
|利用可能性|✕|✕|✕|◯|

```
  - class : 'command'
    id: 0
    type: 304
    time: 234567890
    command: 5
    paramSize: 1
    param: [
      {
        text: '0123'
      }
    ]
```

## 単純ON/OFFデバイス

### ``On``

- 機能 : デジタル端子をON(電圧HIGH)に設定
- コマンド番号 : 1
- パラメータ　: なし

```
  - class : 'command'
    id: 0
    type: 401
    time: 234567890
    command: 1
    paramSize: 0
```

### ``Off``

- 機能 : デジタル端子をOFF(電圧LOW)に設定
- コマンド番号 : 2
- パラメータ　: なし

```
  - class : 'command'
    id: 0
    type: 401
    time: 234567890
    command: 2
    paramSize: 0
```

## サーボ

### ``Write``

- 機能 : パラメータで指定した角度になるまでサーボモータを回転させる
- コマンド番号 : 1
- パラメータ　: 角度

```
  - class : 'command'
    id: 0
    type: 501
    time: 234567890
    command: 1
    paramSize: 1
    param: [
      {
        angle: 180
      }
    ]
```

### ``Write micro second``

- 機能 : パラメータで指定した時間の間，サーボモータを動作(回転)させる
- コマンド番号 : 2
- パラメータ　: 時間(単位:マイクロ秒)

```
  - class : 'command'
    id: 0
    type: 501
    time: 234567890
    command: 2
    paramSize: 1
    param: [
      {
        msec: 10
      }
    ]
```

## 単純サウンド(スピーカ等)

### ``On``

- 機能 : スピーカー(やブザー)をOnに設定
- コマンド番号 : 1
- パラメータ　: なし

```
  - class : 'command'
    id: 0
    type: 601
    time: 234567890
    command: 1
    paramSize: 0
```

### ``Off``

- 機能 : スピーカー(やブザー)をOffに設定
- コマンド番号 : 2
- パラメータ　: なし

```
  - class : 'command'
    id: 0
    type: 601
    time: 234567890
    command: 2
    paramSize: 0
```

### ``Play``

- 機能 : パラメータで指定する周期や間隔でスピーカーやブザーを鳴らす
- コマンド番号 : 3
- パラメータ　: iteration(再生データの数), bass(周波数:Hz), duration(鳴らす時間:ミリ秒), interval(次の動作に移るまでの時間間隔:ミリ秒)

```
  - class : 'command'
    id: 0
    type: 601
    time: 234567890
    command: 3
    paramSize: 1
    param: [
      {
        iteration: 7,
        bass: [1911, 1702, 1516, 1431, 1275, 1136, 1012],
        duration: [100, 100, 100, 100, 100, 100, 100],
        interval: [500, 500, 500, 500, 500, 500, 500]
      }
    ]
```


## 単純PMWデバイス


### ``Apply``

- 機能 : Setコマンドで設定された出力を実施 (PMW出力を実施)
- コマンド番号 : 1
- パラメータ　: なし

```
  - class : 'command'
    id: 0
    type: 701
    time: 234567890
    command: 1
    paramSize: 0
```

### ``Set``

- 機能 : 単純PMWデバイスに出力する出力値を設定
- コマンド番号 : 3
- パラメータ　: 整数(0から255)

```
  - class : 'command'
    id: 0
    type: 701
    time: 234567890
    command: 2
    paramSize: 1
    param: [
      {
        value: 255
      }
    ]
```

### ``Off``

- 機能 : デバイスに対するPMW出力を停止
- コマンド番号 : 2
- パラメータ　: なし

```
  - class : 'command'
    id: 0
    type: 701
    time: 234567890
    command: 2
    paramSize: 0
```

## IRDA(赤外線リモコン)

赤外線リモコンのプロトコルを指定するため，以下の資料を照会してください．

- [IRremote](https://github.com/Arduino-IRremote/Arduino-IRremote "Arduino IRremote")
- [IR-resources](https://www.harctoolbox.org/IR-resources.html "IR signal resources on the Internet — an annotated collection")

「Bang Olufsen」プロトコルの場合の事例
```
  - class: 'command'
    id: 1
    type: 801
    time: 0
    command: 10
    paramSize: 1
    param: [
      { header: 1, data: 1, repeats: 1, bits:1 }
    ]
```


|プロトコル種別|プロトコル/コマンド番号|パラメータ例(デフォルト値)|
|---|---|---|
|Bang Olufsen| 10 |{ header: 1, data: 1, repeats: 1, bits:1 }|
|Bang Olufsen Link| 11 |{ header: 1, data: 1, repeats: 1, bits:1 }|
|Bose Wave| 20 |{ command: 1, repeats: 1 }|
|Sharp| 30 |{ address: 1, command: 1, repeats: 1 }|
|Denon| 31 |{ address: 1, command: 1, repeats: 1, flag: 0 }|
|Fast| 40 |{ command: 1, repeats: 1 }|
|JVC| 50 |{ address: 1, command: 1, repeats: 1 }|
|KaseiKyo| 60 |{ address: 1, command: 1, repeats: 1, vendor: 8 }|
|LG| 70 |{ address: 1, command: 1, repeats: 1 }|
|LG2| 71 |{ address: 1, command: 1, repeats: 1 }|
|LEGO| 80 |{ channel: 1, command: 1, repeats: 1, flag: 0 }|
|LEGO2| 81 |{ data: 1, channel: 1, flag: 0 }|
|Magic Quest| 90 |{ wid: 1, magnitude: 1 }|
|NEC| 100 |{ address: 1, command: 1, repeats: 1 }|
|NEC2| 101 |{ address: 1, command: 1, repeats: 1 }|
|ONKYO| 102 |{ address: 1, command: 1, repeats: 1 }|
|Apple| 103 |{ did: 1, command: 1, repeats: 1 }|
|RC5| 110 |{ address: 1, command: 1, repeats: 1, flag: 0 }|
|RC6| 111 |{ data: 1, bits: 1 }|
|RC6-2| 112 |{ data: 1, bits: 1 }|
|RC6-3| 113 |{ address: 1, command: 1, repeats: 1, flag: 0 }|
|RC6-A| 114 |{ address: 1, command: 1, repeats: 1, customer:1, flag: 0 }|
|Samsung| 120 |{ address: 1, command: 1, repeats: 1 }|
|Samsung/LG| 121 |{ address: 1, command: 1, repeats: 1 }|
|Samsung 48| 122 |{ address: 1, command: 1, repeats: 1 }|
|Sony| 130 |{ address: 1, command: 1, repeats: 1, bits: 1 }|
|DISH| 140 |{ data: 1 }|


## MP3プレーヤ

### ``Stop``

- 機能 : 再生終了
- コマンド番号 : 1
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 903
    time: 234567890
    command: 1
    paramSize: 0
```

### ``Next``

- 機能 : 次の曲
- コマンド番号 : 2
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 903
    time: 234567890
    command: 2
    paramSize: 0
```

### ``Previous``

- 機能 : 前の曲
- コマンド番号 : 3
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 903
    time: 234567890
    command: 3
    paramSize: 0
```

### ``Volume``

- 機能 : ボリューム(音量)設定
- コマンド番号 : 4
- パラメータ　: 整数(例:``{ vol: 10 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


### ``Volume Up``

- 機能 : 音量アップ
- コマンド番号 : 5
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


### ``Volume Down``

- 機能 : 音量ダウン
- コマンド番号 : 6
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

### ``Storage Selection``

- 機能 : 音源ファイルの場所(デバイス種類)の指定
- コマンド番号 : 7
- パラメータ　: 整数 (例:``{ storage: 1 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


### ``Pause``

- 機能 : 再生一時停止
- コマンド番号 : 8
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

### ``Start``

- 機能 : 再生スタート
- コマンド番号 : 9
- パラメータ　: なし

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 903
    time: 234567890
    command: 9
    paramSize: 0
```

### ``Play by file index``

- 機能 : ファイル番号(ファイルシステムのインデックス番号)の音声を再生
- コマンド番号 : 10
- パラメータ　: ファイル番号(整数), 再生モード(整数) (例:``{ index: 1, mode: 1 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

### ``Play by file name``

- 機能 : ファイル番号(ファイルシステムのインデックス番号)の音声を再生
- コマンド番号 : 11
- パラメータ　: ファイル名(文字列), 再生モード(整数) (例:``{ name: 'foo', mode: 1 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

### ``Play by directory number``

- 機能 : ディレクトリ番号とファイル番号(ファイルシステムのインデックス番号)を指定して音声を再生
- コマンド番号 : 12
- パラメータ　: ディレクトリ番号(整数), ファイル番号(整数), 再生モード(整数) (例:``{ num: 1, file: 1, mode: 1 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

### ``Play by directory name``

- 機能 : ディレクトリ番号とファイル番号(ファイルシステムのインデックス番号)を指定して音声を再生
- コマンド番号 : 13
- パラメータ　: ディレクトリ名(文字列), ファイル番号(整数), 再生モード(整数) (例:``{ name: 'foo', file: 1, mode: 1 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


### ``Loop directory``

- 機能 : ディレクトリ番号で指定されたディレクトリ内の音声を繰り返し再生
- コマンド番号 : 14
- パラメータ　: ディレクトリ番号(整数) (例:``{ index: 10 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

### ``Play MP3 directory``

- 機能 : ``MP3``という名前のディレクトリ内の``index``(番号)の音声を再生
- コマンド番号 : 15
- パラメータ　: ファイル番号(整数) (例:``{ index: 10 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


### ``Cut in play``

- 機能 : 割り込み再生(再生途中でも，強制的に切り替える)
- コマンド番号 : 16
- パラメータ　: ストレージの種別(整数), 再生対象ファイルインデックス(整数) (例:``{ storage: 1, index:1 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


### ``Set Equalizer``

- 機能 : イコライザの設定
- コマンド番号 : 17
- パラメータ　: レベル(整数) (例:``{ eq: 10 }``)

|デバイスタイプ番号| 901 | 902 | 903 | 904 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|


## グラフィックディスプレイ

### ``Fill``

- 機能 : 1色で画面全体を塗る
- コマンド番号 : 
- パラメータ　: 色番号(RGBとかではない)を表す整数 (例:``{ color: 255 }``)

|デバイスタイプ番号| 1001 | 1002 | 1003 | 1004 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 1002
    time: 234567890
    command: 1
    paramSize: 1
    param: [
      {
        color: 54938
      }
    ]
```

### ``Print text``

- 機能 : 文字列を画面に印字
- コマンド番号 : 2
- パラメータ　: 座標, 描画面(表裏), フォントサイズ, 描画方式, 文字列 (例:``{ x: 1, y: 1, foreground: 1, background: 1, size: 10, wrap: 0, text: 'abcde' }``)

|デバイスタイプ番号| 1001 | 1002 | 1003 | 1004 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 1002
    time: 234567890
    command: 2
    paramSize: 1
    param: [
      {
        x: 10,
        y: 400,
        foreground: 0xFFFF,
        background: 0x03E0,
        size: 5,
        wrap: 0,
        text: 'Hello, World!'
      }
    ]
```

### ``Put image file``

- 機能 : 画像ファイルを指定された座標に描画
- コマンド番号 : 3
- パラメータ　: 座標とファイル名 (例:``{ x: 1, y: 1, filename: 'abcde' }``)

|デバイスタイプ番号| 1001 | 1002 | 1003 | 1004 |
|---|---|---|---|---|
|利用可能性|◯|◯|◯|◯|

```
  - class : 'command'
    id: 0
    type: 1002
    time: 234567890
    command: 3
    paramSize: 1
    param: [
      {
        x: 0,
        y: 0,
        filename: '/panda.jpg'
      }
    ]
```

<!--

<div style="text-align: center;">
<img src="img/.png" width="100%">
</div>

[]( "")

[ArduinoActuator](https://github.com/ArduinoActuator "ArduinoActuator")


に収録されているHardware Abstraction Layer(HAL)でサポートされている物に加えて，Arduinoの赤外線リモコン用ライブラリ[IRremote](https://docs.arduino.cc/libraries/irremote/ "IRremote")となる．


-->

