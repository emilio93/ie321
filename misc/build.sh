mkdir -p build
cat \
misc.s \
impresion.s \
lectura.s \
potencia.s \
raiz_cuadrada.s \
> \
build/misc.s

cat \
misc_tests.s \
misc.s \
impresion.s \
lectura.s \
potencia.s \
raiz_cuadrada.s \
> \
build/misc_tests.s
