
````markdown
# Dating App – WebRTC Görüşme Altyapısı

Bu proje, Flutter kullanılarak geliştirilmiş bir **Dating App** uygulamasıdır.  
Uygulama; kullanıcı doğrulama, oda oluşturma ve **WebRTC tabanlı sesli/görüntülü görüşme** özelliklerini içerir.

## 🚀 Kurulum

### 1. Ortam değişkenleri

* `.env` dosyasında API adreslerini tanımla:

```
API_URL=https://example.com/api
```
* gen.sh dosyasından ilgili Flavor run komutunu bulabilirsiniz.
* gen.sh dosyasından ilgili runner run komutunu bulabilirsiniz (generating routes,assets.).

## 📂 Proje Yapısı (Clean Architecture)

## 📡 WebRTC Akışı

1. initRenderers()

    * `localRenderer` ve `remoteRenderer` başlatılır.
    * `getUserMedia()` ile kamera/mikrofon başlatılır.
    * Yerel video ekrana basılır.

2. **Peer Connection**

    * STUN server bilgileri ile `RTCPeerConnection` oluşturulur.
    * Local track’ler (`audio`, `video`) eklenir.
    * `onTrack` event’i ile karşı tarafın videosu `remoteRenderer`’a bağlanır.
    * `onIceCandidate` ile ICE candidate’ler sinyalleşme servisine gönderilir.
    * İleri seviye LTE-LTE veya Prod ortam için TURN serveri kurulmalıdır.

3. **Signaling** (Harici Sunucu ile)

    * **Caller** → `createOffer()` → karşıya gönder.
    * **Callee** → `createAnswer()` → cevap gönder.
    * ICE candidate’ler karşılıklı eklenir.



## 📲 Oda Paylaşımı

`share_plus` ile oda bilgisi paylaşılır:


## ⚠ Notlar

* WebRTC için **signaling server** bu projede Cloud Firestore Üzerinden Çağrılır.
* STUN server olarak Google’ın public server’ları kullanıldı; production için TURN eklenmesi önerilir.
*Direct WebRTC paketinin seçilme sebebi config yapmaya daha müsait olması (p2p).
Signaling için firestore un kullanılması sebebi de serverless bir şekilde implemente edilebilmesidir.
Daha complex çözümler için socket io kurulabilir.
---



