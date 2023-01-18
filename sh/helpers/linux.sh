echo 'Configuring additional steps'

SCONS_PARAMS=$1

PLATFORM=$2

echo "this fedora ${FINAL_IMAGE}"

scons -j6 platform=${PLATFORM} ${SCONS_PARAMS}