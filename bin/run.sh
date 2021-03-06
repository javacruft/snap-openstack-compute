#!/bin/bash -e

if [ $(id -u) -eq 0 ]; then
    mkdir -p $SNAP_COMMON/nova.conf.d $SNAP_COMMON/instances
    sed -e "s|__SNAP_DATA__|$SNAP_COMMON|g" \
        -e "s|__SNAP__|$SNAP|g" \
        $SNAP/templates/nova-snap.conf > $SNAP_COMMON/nova.conf.d/nova-snap.conf
fi

exec "$SNAP/usr/bin/python" "$SNAP/usr/bin/$1" --config-file=$SNAP/etc/nova/nova.conf --config-dir=$SNAP_COMMON/nova.conf.d "${@:2}"
