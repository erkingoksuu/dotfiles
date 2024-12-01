# ------------------------------------------------------
# Check for automation.sh
# ------------------------------------------------------

if [ -f $temp_directory/automation.sh ] ;then
    _writeLogTerminal 0 "AUTOMATION: automation.sh found. Automatic installation/update started"
    source $temp_directory/automation.sh
    echo
fi