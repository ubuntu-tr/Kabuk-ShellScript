# grafikbilgi.sh

Bu betik, Linux İşletim Sisteminizde mevcut durumdaki grafik kartı bilgilerini ve yüklü olan sürücüleri ekrana yazdırır. Grafik kartınız ile ilgili yardıma ihtiyacınız olduğunda, bu bilgileri toplu olarak paylaşmanız yardım edeceklerin soracakları sorulara cevap olacaktır. Zaman kazanmanız açısından kullanmanızı tavsiye ediyoruz.

## Açıklamalar

1. Betik, apt paket yöneticisi kullanan sistemler için yazılmıştır.
2. ```grafikbilgi.sh``` dosyasını indirdikten sonra aşağıdaki komutla çalıştırılabilir hale getirin.

```sh
chmod +x grafikbilgi.sh
```

3. Betik dosyasını artık  ```./grafikbilgi.sh``` komutu ile çalıştırabilirsiniz.

## Betik Hangi İşlemleri Yapıyor?

**1.Adım:**

Program öncelikle sisteminizde ```mesa-utils``` paketinin kurulu olup olmadığını kontrol eder. Kurulu ise bir sonraki adıma geçer. Kurulu değilse ```sudo apt-get install -y mesa-utils``` komutu ile paketi kurar.

**2. Adım:**

```lsb_release -a``` komutuna ait Dağıtım bilgilerini ekrana yazdırır.

**3. Adım:**

```lspci -nnk | egrep "VGA|3D|Display" -A2``` komutuna ait PCI cihaz bilgilerini ekrana yazdırır.

**4. Adım:**

```glxinfo | grep render``` komutunu çıktılarını ekrana yazdırır.

**5. Adım:**

```xrandr``` komutunun çıktılarını ekrana yazdırır.

**6. Adım:**

```dpkg -l | egrep "nvidia|bumblebee|nvidia-prime|fglrx"``` komutunun çıktılarını ekrana yazdırır.

---

**Örnek Çıktı**

Aşağıda, ```./grafikbilgi.sh``` komutuna ait örnek bir çıktı görülmektedir.

```sh
Aşağıda yer alan bilgileri paylaşabilirsiniz.
----------------------------------------
Dağıtım bilgileri.
----------------------------------------
No LSB modules are available.
Distributor ID:	LinuxMint
Description:	Linux Mint 18.1 Serena
Release:	18.1
Codename:	serena
----------------------------------------
PCI cihaz bilgileri.
-----------------------------------------
00:02.0 VGA compatible controller [0300]: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller [8086:0416] (rev 06)
	Subsystem: ASUSTeK Computer Inc. 4th Gen Core Processor Integrated Graphics Controller [1043:178d]
	Kernel driver in use: i915
--
01:00.0 3D controller [0302]: NVIDIA Corporation GM107M [GeForce GTX 950M] [10de:139a] (rev a2)
	Subsystem: ASUSTeK Computer Inc. GM107M [GeForce GTX 950M] [1043:178d]
	Kernel driver in use: nvidia
----------------------------------------
glxinfo bilgileri.
-----------------------------------------
direct rendering: Yes
    GLX_MESA_multithread_makecurrent, GLX_MESA_query_renderer,
    GLX_MESA_multithread_makecurrent, GLX_MESA_query_renderer,
Extended renderer info (GLX_MESA_query_renderer):
OpenGL renderer string: Mesa DRI Intel(R) Haswell Mobile
    GL_ARB_conditional_render_inverted, GL_ARB_conservative_depth,
    GL_NV_conditional_render, GL_NV_depth_clamp, GL_NV_packed_depth_stencil,
    GL_ARB_compute_shader, GL_ARB_conditional_render_inverted,
    GL_NV_blend_square, GL_NV_conditional_render, GL_NV_depth_clamp,
    GL_OES_fbo_render_mipmap, GL_OES_get_program_binary, GL_OES_mapbuffer,
----------------------------------------
xrandr bilgileri.
----------------------------------------
Screen 0: minimum 8 x 8, current 1366 x 768, maximum 32767 x 32767
eDP1 connected primary 1366x768+0+0 (normal left inverted right x axis y axis) 344mm x 193mm
   1366x768      60.00*+
   1360x768      59.80    59.96  
   1280x720      60.00  
   1024x768      60.00  
   1024x576      60.00  
   960x540       60.00  
   800x600       60.32    56.25  
   864x486       60.00  
   640x480       59.94  
   720x405       60.00  
   680x384       60.00  
   640x360       60.00  
HDMI1 disconnected (normal left inverted right x axis y axis)
VGA1 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
----------------------------------------
Ekran Kartı Sürücü bilgileri.
----------------------------------------
ii  nvidia-375                                  375.66-0ubuntu0.16.04.1                    amd64        NVIDIA binary driver - version 375.66
ii  nvidia-opencl-icd-375                       375.66-0ubuntu0.16.04.1                    amd64        NVIDIA OpenCL ICD
ii  nvidia-prime                                0.8.2linuxmint1                            amd64        Tools to enable NVIDIA's Prime
ii  nvidia-prime-applet                         1.0.6                                      all          An applet for NVIDIA Prime
ii  nvidia-settings                             361.42-0ubuntu1                            amd64        Tool for configuring the NVIDIA graphics driver
---------------bitti---------------------
Yukarıda özetlenen bilgileri problem çözümü için paylaşabilirsiniz.

```
