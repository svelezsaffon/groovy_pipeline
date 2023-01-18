echo 'Configuring additional steps'

PLATFORM=$1

SCONS_PARAMS=$2

echo "this fedora ${FINAL_IMAGE}"

scons -j6 platform=${PLATFORM} ${SCONS_PARAMS}