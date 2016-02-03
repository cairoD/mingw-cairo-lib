Copies cairo DLLs and dependecies from MSYS2 to the results folder. Also
generates import libraries.

1. Install MSYS2 from http://msys2.github.io/
2. Install the cairo library in the MSYS2 prompt:

  ```bash
  pacman -S mingw-w64-i686-cairo mingw-w64-x86_64-cairo
  ```
3. Install the DMD implib library somewhere in $PATH: http://ftp.digitalmars.com/bup.zip
4. Run the install.sh script
