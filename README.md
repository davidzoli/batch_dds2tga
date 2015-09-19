# batch_dds2tga
Windows batch files to convert dds files to tga files.

You can easily drop some files or a folder to make dds files converted to tga files.

convert_file.bat - Bat for convert file(s). 
Drop a file or set of files onto the bat. Converter will be called and make a tga file beside of the original dds.

convert_folder.bat - File process a dropped folder. 
User can deside to do the process recursively or not. Not recursive run will convert the files only in the dropped folder.
Recursive run will create the whole directory structure.
Folder convert always create a folder (*_converted) beside of the original folder and copy the dds files in the original folders structure. 
User can decide wether keep the copied dds files or not.

convert_log.txt
Log fil of the last run process.

readdxt.exe
The readdxt.exe is developerd and property of NVIDIA Corporation.
https://developer.nvidia.com/legacy-texture-tools
