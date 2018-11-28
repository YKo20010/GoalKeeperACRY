# vm
Docker setup to simulate a virtual machine for development purposes.

## Running the dev VM

First, set up [Docker](https://www.docker.com/get-started).

On a Unix system, simply execute `./vm_run` to initialize and run the development virtual machine.

`./vm_run rebuild` rebuilds the VM image from the Dockerfile, leaving data intact.
`./vm_run reset` changes the mount point of the data volume.

### Manual setup

To create the data volume:
    
    docker rm vm-data # skip for initial setup
    docker create -v <host directory>:/home/vm-user --name vm-data busybox /bin/true # <host directory> will be the home directory in the VM

To rebuild the VM image:

    docker rmi vm-image # skip for initial setup
    docker build . -t vm-image

To run the VM:

    docker run -it --rm --volumes-from vm-data --name vm-container vm-image /tmp/vm_init 

