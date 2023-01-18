echo 'Configuring additional steps'

SCONS_PARAMS=$1

scons -j6 platform=linuxbsd ${SCONS_PARAMS}