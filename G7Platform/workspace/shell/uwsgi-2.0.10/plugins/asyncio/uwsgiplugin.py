from distutils import sysconfig

NAME='asyncio'
CFLAGS = ['-I' + sysconfig.get_python_inc(), '-I' + sysconfig.get_python_inc(plat_specific=True)]
LDFLAGS = []
LIBS = []

GCC_LIST = ['asyncio']
