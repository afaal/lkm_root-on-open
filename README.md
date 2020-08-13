# Root on Open

> This is very heavily inspired by: https://blog.sourcerer.io/writing-a-simple-linux-kernel-module-d9dc3762c234

This is a first attempt at a small linux kernel module (LKM), most of the code in this repo is copied from Robert W. Oiver's great introduction to writing LKMs. My own addition to the code is to change the process opening the device uid to 0, effecively making them root.

**This should never be run on a machine you care about** 

## Running the code 
To compile and insert the module run the following commands from within the project directory
```
make
make test
``` 

This will output the Major number of the device 

we will then use that to create a device 

``` 
sudo mknod /dev/lkm_example c MAJOR 0 
``` 
where MAJOR is the number outputted when executing `make test`

The module has now been inserted, we have created a device for intacting with the device driver.

Running 
```
cat /dev/lkm_example
```
should output "Hello, World!" a bunch of times. You'll notice that this won't magically elevate your bash user to root, as `cat` is spawned in its own process and that is being elevated to root, not your shell. 


## Getting root 

We should instead open the device and run our commands from wihin the same process. 

This could be in python like so: 

```
python3 -c "import os; f=open('/dev/lkm_example', 'r'); os.system('id');"
```

Exchange `id` with whatever commands you wish to run.
