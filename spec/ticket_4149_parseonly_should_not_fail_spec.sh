#!/bin/bash

. `dirname $0`/setup.sh
driver_standalone_using_files

execute_manifest --parseonly <<PP
class someclass {
        notify{'hello world':}
}
PP
