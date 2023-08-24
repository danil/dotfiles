#!/bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

acpi --battery | grep -P -o '[0-9]+(?=%)'
