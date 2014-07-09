# platform.sh - os/vendor detection

kernel() {
    if [ "$( uname -a | grep -ci 'linux' )" -gt "0" ]; then
        echo "linux"
        return 0
    fi

    if [ "$( uname -a | grep -ci 'bsd' )" -gt "0" ]; then
        echo "bsd" 
        return 0
    fi

    echo "unknown"
    return 1
}

arch() {
	if [ "$( getconf LONG_BIT | grep -ci '64' )" -gt "0" ]; then
	echo "X86_64"
	return 0
	fi

	if [ "$( getconf LONG_BIT | grep -ci '32' )" -gt "0" ]; then
	echo "i686"
	return 0
	fi

	echo "unknown architecture"
	return 1
}

vendor() {
    if [ -f /etc/lsb-release ]; then
        for vendor in "ubuntu" "debian"; do
            if [ "$( grep -ci "${vendor}" /etc/lsb-release)" -gt "0" ]; then
                echo "${vendor}"
                return 0
            fi
        done
    fi
   
    if [ -f /etc/gentoo-release ]; then
        echo "gentoo"
        return 0
    fi

    echo "generic"
    return 1
}

os() {
    echo "$(kernel).$(vendor).$(arch)"
}

arch="$(arch)"
kernel="$(kernel)"
vendor="$(vendor)"
os="$(os)"
