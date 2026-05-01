function fixwifi --wraps="cd ~/AIC8800-Linux-Driver/drivers/aic8800 && make clean && make && sudo make install && sudo modprobe aic_load_fw && sudo modprobe aic8800_fdrv && echo 'WiFi Driver Rebuilt!'" --description "alias fixwifi=cd ~/AIC8800-Linux-Driver/drivers/aic8800 && make clean && make && sudo make install && sudo modprobe aic_load_fw && sudo modprobe aic8800_fdrv && echo 'WiFi Driver Rebuilt!'"
    cd ~/AIC8800-Linux-Driver/drivers/aic8800 && make clean && make && sudo make install && sudo modprobe aic_load_fw && sudo modprobe aic8800_fdrv && echo 'WiFi Driver Rebuilt!' $argv
end
