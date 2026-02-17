# Choose how to set up this script

## 1st Solution

### WARNING: This solution will make clients crash if you restart the script

Head over to `fxmanifest.lua` of this script and <strong> uncomment </strong> the last lines found at the bottom of the file.


## 2nd Solution

1. Copy the `stream` folder from the script files.
2. Create a new folder inside your resources folder and name it `wheel_spacers_stream`.
3. Paste the `stream` folder inside `wheel_spacers_stream`.
4. Create a new file `fxmanifest.lua` and paste contents from 5<sup>th</sup> step
5. ```lua
    fx_version "cerulean"
    games      { "gta5" }
    
    files {
    "stream/wheel_spacer.ytyp"
    }
    
    data_file "DLC_ITYP_REQUEST" "stream/wheel_spacer.ytyp"
    ```

6. Restart your server and enjoy! :)

