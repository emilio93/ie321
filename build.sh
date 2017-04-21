mkdir -p build

mkdir -p build/tarea1
cd tarea1
./build.sh
mv build/* ../build/tarea1
rm -r build

cd ..
mkdir -p build/tarea2
cd tarea2
./build.sh
mv build/* ../build/tarea2
rm -r build
