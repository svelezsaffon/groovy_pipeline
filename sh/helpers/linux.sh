echo 'Configuring additional steps'

SCONS_PARAMS=$1


echo "this fedora ${FINAL_IMAGE}"

scons -j6 platform=linuxbsd ${SCONS_PARAMS}