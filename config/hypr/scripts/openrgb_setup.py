#!/usr/bin/python

from openrgb import OpenRGBClient
from openrgb.utils import DeviceType
# from openrgb.utils import Profile

# with open('/home/quentin/.config/OpenRGB/matugen.orp', 'rb') as f:
#    profile = Profile(f, version = "5")

cli = OpenRGBClient()

mobo = cli.get_devices_by_type(DeviceType.MOTHERBOARD)[0]
gpu = cli.get_devices_by_type(DeviceType.GPU)[0]

print(mobo.zones, gpu.zones)
cli.clear()
