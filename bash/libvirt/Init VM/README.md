# Initialization script for virsh VMs.

This script generate a new VM into virsh by:
- Generating a QCOW2 image file.
- Creating an awaiting install into virsh associated with the image file, accessible by VNC.

## TODO
- limit the script arguments to one, being a manually written parameters file containing:
  - VM name
  - Image file size
  - MAC Address (might as well do some collision check there)
  - RAM
  - VCPUs
  - OS variant (maybe not)
- afterwards control system specific parameters, with a global parameters file:
  - the network type, source and model
  - graphics access (other than vnc or none if pxe is auto selected somehow)
