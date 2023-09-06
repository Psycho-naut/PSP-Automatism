# PSP-Automatism
A script to automate copying ps1 and psp games from an external HDD to the PSP.

## How does it work
The script checks that the psp is connected and that the mountpoint has been created, it also checks that the external HDD is connected and that the mountpoint exists.
Later if PSP/{PS1,ISO} directories do not exist in HDD are created.
If the check conditions are not satisfied the script does not start.

## Configuration
To make the script work you need to change the path present in some variables:

```bash
PATH_PSP=(Enter the mount point of your psp.)
HDD=(Enter HDD name - You can recover it with lsusb command-)
PATH_HDD=(Enter the mount point of your HDD.)
```
