# Image_sort
Used to sort and backup images based on metadata. Furthermore it is able to backup the 
pictures in the same structure on an external Volume.

## Usage
The script takes (currently) all pictures from the folder ~/Pictures/toSort and creates 
folders based on the Image creation date.
If you want to backup the files afterwards you can enter after executing a Volume.

## Example
```
$ ./image_sort.rb
Select a backup volume. Mounted volumes:
Pictures

$ Pictures
Start:
Directory: <directory> created!
Moving <file>.JPG to <destination directory> ...
Backup directory: <destination directory> created!
Backing up <file>.JPG
Moving <file2>.JPG to <destination directory> ...
Backing up <file2>.JPG
Done!
```

## ToDo
Make origin and destination path configurable.
