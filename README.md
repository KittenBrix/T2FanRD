# T2FanRD

Simple Fan Daemon for T2 Macs, rewritten from the [original Python version](https://github.com/NoaHimesaka1873/t2fand).

## Compilation
`cargo build --release`

## Installation
1. Copy the `target/release/t2fanrd` executable to wherever your distro wants executables to be run by root.
2. Setup the executable to be run automatically at startup, like via a [systemd service](https://github.com/t2linux/fedora/blob/2947fdc909a35f04eb936a4f9c0f33fe4e52d9c2/t2fanrd/t2fanrd.service).
3. Move the folder `t2fanrd-config` to `/etc/t2fanrd`. you may need sudo.
4. run `chmod +x /etc/t2fanrd/fan_util.sh` to ensure it can be executed by your user(s).
5. add the following commands to your aliases file (bash). You can name your aliases whatever, but this just isolates the shell functions inside /etc/t2fanrd/fan_util.sh:
```
    # Fan Controls
    source /etc/t2fanrd/fan_util.sh
    alias fanspeed=use_fan_config
    complete -F _use_fan_config_completions fanspeed
```
note that the functions do call sudo for the purpose of restarting the system service to run your conf file immediately.

## Configuration
Initial configuration will be done automatically.

For manual config, the config file can be found at `/etc/t2fand.conf`. Using installation steps 3 through 5 will allow you to dynamically move a conf file into this path and restart your service. Provided with this repo are min, mid, and max, however any *.conf files you add in the folder should be available to use.

There's four options for each fan.
|        Key        |                            Value                            |
|:-----------------:|:-----------------------------------------------------------:|
|      low_temp     |        Temperature that will trigger higher fan speed       |
|     high_temp     |         Temperature that will trigger max fan speed         |
|    speed_curve    |   Three options present. Will be explained in table below.  |
| always_full_speed | if set "true", the fan will be at max speed no matter what. |

For `speed_curve`, there's three options.
|     Key     |                   Value                   |
|:-----------:|:-----------------------------------------:|
|    linear   |     Fan speed will be scaled linearly.    |
| exponential |  Fan speed will be scaled exponentially.  |
| logarithmic | Fan speed will be scaled logarithmically. |

Here's an image to better explain this. (Red: linear, blue: exponential, green: logarithmic)
![Image of fan curve graphs](https://user-images.githubusercontent.com/39993457/233580720-cfdaba12-a2d8-430c-87a2-15209dcfec6d.png)
