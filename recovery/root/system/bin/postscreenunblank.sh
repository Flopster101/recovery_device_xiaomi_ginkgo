#!/system/bin/sh

TSP_DT2W="/sys/touchpanel/double_tap"

if [ -w "$TSP_DT2W" ]; then
	echo 0 > "$TSP_DT2W"
fi
