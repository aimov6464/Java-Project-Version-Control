
mkdir versions
rm versions/project-$1.deb
rm -rf versions/project-$1

создаем папку versions (если она уже есть то инструкция ничего не сделает)
Затем удаляем деб пакет и папку с конкретным номером версии
Этот конкретный номер версии - передаем параметром к скрипту

Например: 
./do-pack.sh 6.686

mkdir versions/project-$1
mkdir versions/project-$1/opt
mkdir versions/project-$1/opt/project
mkdir versions/project-$1/opt/project/Logs
mkdir versions/project-$1/opt/project/Temp
Создаем необходимые для разворачивания ПО папки
rm -rf aterminal
rm -rf devices
rm -rf ntwrk
rm -rf notwork
rm -rf mytools
rm -rf mydb
rm -rf myservice
rm -rf core
rm -rf customlog
Удаляем временные для сборки папки в которых хранятся классы соотвествующих пакейджей

cp -la ../target/classes/aterminal .
cp -la ../target/classes/devices .
cp -la ../target/classes/ntwrk .
cp -la ../target/classes/notwork .
cp -la ../target/classes/mytools .
cp -la ../target/classes/core .
cp -la ../target/classes/customlog .
cp -la ../target/classes/myservice .
cp -la ../target/classes/mydb .
Копируем из указанного места папки ( с классами) для сборки 

echo "Manifest-Version: 1.0" > MANIFEST_A.txt
echo "Main-Class: aterminal.AppStarter" >> MANIFEST_A.txt
echo "Created-By: $1 (TOO some company)" >> MANIFEST_A.txt
echo "Class-Path: devices.jar jssc.jar guava27.jar Java-WebSocket-1.4.1.jar tritonus_share.jar " >> MANIFEST_A.txt
echo " swt.jar rxtx-2.1.7.jar core.jar interfaces.jar MEI-java.jar log4j-core-2.11.1.jar " >> MANIFEST_A.txt
echo " mytools.jar myservice.jar mydb.jar customlog.jar log4j-api-2.11.1.jar tools24.jar " >> MANIFEST_A.txt
echo " sqlite4java.jar core-3.3.0.jar commons-logging-1.0.4.jar ntwrk.jar json.jar " >> MANIFEST_A.txt
echo " xmlgraphics-commons-2.2.jar javase-3.3.0.jar commons-io-2.6.jar MPLib.jar mp3spi1.9.5.jar " >> MANIFEST_A.txt
echo " jl1.0.1.jar httpclient-4.5.6.jar httpcore-4.4.10.jar httpmime-4.5.6.jar essp24.jar LCDM2000.jar commons-net-3.8.0.jar " >> MANIFEST_A.txt
echo "MIDlet-Version: $1" >> MANIFEST_A.txt
echo "" >> MANIFEST_A.txt

echo "Manifest-Version: 1.0" > MANIFEST_N.txt
echo "Main-Class: notwork.FrmNotWork" >> MANIFEST_N.txt
echo "Created-By: $1 (TOO some company)" >> MANIFEST_N.txt
echo "Class-Path: swt.jar tools24.jar mytools.jar customlog.jar mydb.jar commons-io-2.6.jar " >> MANIFEST_N.txt
echo "MIDlet-Version: $1" >> MANIFEST_N.txt
echo "" >> MANIFEST_N.txt

echo "Manifest-Version: 1.0" > MANIFEST.txt
echo "Created-By: $1 (TOO some company)" >> MANIFEST.txt
echo "MIDlet-Version: $1" >> MANIFEST.txt
echo "" >> MANIFEST.txt

Создаем манифесты - для атерминала, нотворка и рядового джарника

jar cvfm versions/project-$1/opt/project/aterminal.jar MANIFEST_A.txt aterminal/.class
jar cvfm versions/project-$1/opt/project/devices.jar MANIFEST.txt devices/.class
jar cvfm versions/project-$1/opt/project/ntwrk.jar MANIFEST.txt ntwrk/.class
jar cvfm versions/project-$1/opt/project/notwork.jar MANIFEST_N.txt notwork/.class
jar cvfm versions/project-$1/opt/project/mytools.jar MANIFEST.txt mytools/.class
jar cvfm versions/project-$1/opt/project/myservice.jar MANIFEST.txt myservice/.class
jar cvfm versions/project-$1/opt/project/mydb.jar MANIFEST.txt mydb/.class
jar cvfm versions/project-$1/opt/project/core.jar MANIFEST.txt core/.class
jar cvfm versions/project-$1/opt/project/customlog.jar MANIFEST.txt customlog/*.class

Собираем из соответсвующих пакейджей джарники с указанием классов и манифеста

cp ../exter-lib/etalonMain.db3 versions/project-$1/opt/project/etalonMain.db3
...
cp ../exter-lib/DetectCamera.jar versions/project-$1/opt/project/DetectCamera.jar

копируем необходимые для запуска ПО файлы, все локальные автономные джарники (зависимости) и другие (скрипты/шаблоны и т.д.)

rm -rf aterminal
rm -rf devices
rm -rf ntwrk
rm -rf notwork
rm -rf mytools
rm -rf myservice
rm -rf mydb
rm -rf customlog
rm -rf core

Чистим временные папки пакейджей с классами

rm "MANIFEST_A.txt"
rm "MANIFEST.txt"
rm "MANIFEST_N.txt"
чистим манифесты

mkdir versions/project-$1/DEBIAN
создаем структурку для деб пакета

chmod 777 -R versions/project-$1/opt/project
Ставим права доступа все разрешено

cd versions

echo "cwd=project-$1" > project-$1/DEBIAN/md5sums
md5deep -r project-$1/opt > project-$1/DEBIAN/md5sums

echo "" > project-$1/DEBIAN/dirs

echo "Package: project" > project-$1/DEBIAN/control
echo "Version: $1" >> project-$1/DEBIAN/control
echo "Maintainer: info info@some company.kz" >> project-$1/DEBIAN/control
echo "Architecture: all" >> project-$1/DEBIAN/control
echo "Section: misc" >> project-$1/DEBIAN/control
echo "Description: Client for payment some company." >> project-$1/DEBIAN/control
echo " Client for payment some company on ASO." >> project-$1/DEBIAN/control

Заполняем структурку деб пакета

fakeroot dpkg-deb --build project-$1
собираем деб пакет

rm -rf project-$1/opt/project/shell/images/services
rm -rf project-$1/opt/project/shell/images/samples

Удаляем папки картинок сервисов и сэмплов (пример куда платить для сервиса)

../indexator.sh $1

И запускаем индексатор - который нам просчитывает и заполняет специальный файл (хмл) содержащий все файлы и их размеры/хэши в получившейся сборке

../comparehash.py

