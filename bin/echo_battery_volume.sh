#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

battery_level=`acpi --battery | grep -P -o '[0-9]+(?=%)'`
