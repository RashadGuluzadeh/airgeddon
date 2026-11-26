# airgeddon — fərdiləşdirmələr

Bu, [airgeddon](https://github.com/v1s1t0r1sh3r3/airgeddon)-un şəxsi fork-udur.
Kibertəhlükəsizlik (Red Team) kursu üçün bir sıra əlavələr və düzəlişlər edilib.
Bütün fərdiləşdirmələr **plagin** kimi yazılıb (monolit kod stock-a yaxın saxlanıb),
beləcə yuxarı axın (upstream) yeniləmələri rahat çəkilə bilər.

> airgeddon GPLv3 lisenziyalı açıq koddur. Bu fork həmin lisenziya altındadır.
> Orijinal müəllif: v1s1t0r1sh3r3.

---

## 1. Captive portal — Azərbaycan dili + yeni dizayn

**Plagin:** `plugins/airgeddon_portal.sh`

- Evil Twin captive portal dil menyusuna **"Azerbaijani"** seçimi əlavə edilib.
- Portal mətnləri Azərbaycanca (Parol, Təsdiqlə, "Wi-Fi şəbəkənizin parolunu daxil edin" və s.).
- Portal səhifəsi **mavi kart dizaynına** keçirilib: ağ kart, qradiyent başlıq,
  generik Wi-Fi logosu (heç bir brendə aid deyil).
- Texniki olaraq `set_captive_portal_page` və `set_captive_portal_language`
  funksiyaları plagin vasitəsilə **override** edilir, dil sətirləri isə
  `hookable_for_languages` posthook ilə yüklənir.

## 2. Hədəflərin siqnala görə sıralanması

**Plagin:** `plugins/sort_targets.sh`

- Şəbəkə axtarışından (explore) sonra çıxan hədəf siyahısı **ən güclü
  siqnaldan ən zəifə** sıralanır (ən yaxın/güclü AP yuxarıda).
- `select_target` funksiyasına prehook edib, siyahı ekrana çıxmazdan əvvəl
  `wnws.txt` faylını güc üzrə yenidən sıralayır.

## 3. Avtomatik monitor rejimi

**Plagin:** `plugins/auto_monitor.sh`

- Əsas interfeys seçiləndən sonra avtomatik olaraq monitor rejiminə keçir —
  ayrıca "Put interface in monitor mode" addımı lazım deyil.
- `select_interface`-ə posthook edir; interfeys artıq monitor rejimindədirsə, toxunmur.

## 4. Monitor konflikt düzəlişi

**Plagin:** `plugins/monitor_fix.sh`

- Monitor rejiminə keçməzdən əvvəl NetworkManager-ə həmin interfeysi
  buraxmağı deyir (`nmcli dev set <iface> managed no`), beləcə NM interfeysi
  geri "managed" rejiminə qapmır — "Unable to identify interface" xətasının
  qarşısını alır.
- `monitor_option`-a prehook edir.

## 5. Sessiya loglama

**Plagin:** `plugins/session_logger.sh`

- Çıxışda (müvəqqəti fayllar təmizlənməzdən əvvəl) sessiya faylları —
  handshake (`.cap`), skan nəticələri (`.csv`), tapılan açarlar —
  **hədəf şəbəkənin adı (ESSID) ilə adlanan** qovluğa yazılır:
  `~/airgeddon-logs/<ESSID>/session_<tarix>/`.
- `exit_script_option`-a prehook edir.

## 6. Təhlükəsizlik düzəlişi — ESSID command injection

**Fayl:** `airgeddon.sh` (əsas kod)

- Evil Twin control, Enterprise control və WEP key skriptləri ESSID-i
  **generasiya olunan və icra olunan** skriptin içində, cüt dırnaqlı `echo`
  sətrində xam saxlayırdı. Adında command substitution (`$(...)`) olan bir AP
  bu yolla **root səlahiyyəti ilə əmr icra etdirə bilərdi**.
- Həmin sətirlərdə ESSID artıq `escaped_essid` (`printf %q` — layihənin başqa
  yerlərində onsuz da işlənən üsul) ilə shell-təhlükəsiz formada yazılır.
- hostapd config və WEP pot (mətn) sətirləri — shell icra olunmadığı üçün —
  toxunulmayıb.

## 7. Açılış tənzimləmələri

**Fayl:** `.airgeddonrc`

- `AIRGEDDON_SKIP_INTRO=true` — intro ekranı keçilir.
- `AIRGEDDON_SILENT_CHECKS=true` — açılışda alət yoxlaması promptsuz, səssiz keçir.
- `AIRGEDDON_AUTO_UPDATE=false` — avtomatik yeniləmə söndürülüb ki, fərdiləşdirmələr
  üzərinə yazılmasın.

---

## Quraşdırma (Kali Linux)

```bash
git clone https://github.com/RashadGuluzadeh/airgeddon.git
cd airgeddon
sudo bash airgeddon.sh
```

Plaginlər `plugin_enabled=1` olduğu üçün avtomatik yüklənir. Hər hansı birini
söndürmək üçün müvafiq `plugins/*.sh` faylında `plugin_enabled=0` qoyun.

> **Qeyd:** Real Evil Twin / monitor rejimi üçün monitor mode və paket injection
> dəstəkləyən Wi-Fi adapteri lazımdır (VM-də USB passthrough ilə). VM-in virtual
> şəbəkə kartı monitor rejimini dəstəkləmir.

## İstifadə haqqında

Bu alət yalnız **öz şəbəkələrinizdə və ya yazılı icazəniz olan şəbəkələrdə**,
təhsil və icazəli pentest məqsədilə istifadə üçündür.
