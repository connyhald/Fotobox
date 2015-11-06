# Fotobox

1) Install qt build deps
 * qt stuff
 * libgphoto2-dev
 * wiringpi

2) Compile and install Qt

Qt 5.5.1
Raspian Jessie on Raspberry Pi2

QtWidgets are needed to build QtPrintsupport

```
./configure -opengl es2 -force-pkg-config -device linux-rasp-pi2-g++ -device-option CROSS_COMPILE=/usr/bin/ -opensource -confirm-license -release -qt-pcre -prefix /usr/local/qt5 -no-xcb -no-linuxfb -nomake examples -I /opt/vc/include -I /opt/vc/include/interface/vcos/pthreads -I /opt/vc/include/interface/vmcs_host/linux -skip qt3d -skip qtwebengine -skip qtwebkit
```

3) Set PATH and LD_LIBRARY_PATH

4) Build and install https://github.com/dept2/qtmultimedia-gphoto

5) git clone this project

6) qmake && make

7) Run and have fun :)

Other stuff

* Disable console blanking
setterm -blank 0 -powersave off

