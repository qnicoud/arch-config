#!/usr/bin/python

from openrgb import OpenRGBClient
from openrgb.utils import DeviceType, RGBColor
import json
import os
from sys import exit
# from openrgb.utils import ProfileO

# with open('/home/quentin/.config/OpenRGB/matugen.orp', 'rb') as f:
#    profile = Profile(f, version = "5")

cli = OpenRGBClient()

mobo = cli.get_devices_by_type(DeviceType.MOTHERBOARD)[0]
gpu = cli.get_devices_by_type(DeviceType.GPU)[0]

# print(mobo.zones, gpu.zones)

openrgb_config_path = "~/.config/OpenRGB/colors.json"

if not os.path.exists(openrgb_config_path):
    exit

with open(os.path.expanduser(openrgb_config_path), "r") as json_file:
    openrgb_colors = json.load(json_file)

accent_color = RGBColor.fromHSV(
    int(float(openrgb_colors["accent_color"]["hue"])), 80, 90
)
print(
    max(openrgb_colors["accent_color"], key=openrgb_colors["accent_color"].get),
    openrgb_colors,
)
bg_color = RGBColor.fromHEX("#FDD4D4")

gpu.set_color(accent_color)
mobo.zones[1].set_color(bg_color)
mobo.zones[2].set_color(accent_color)
