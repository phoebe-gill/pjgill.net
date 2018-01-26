+++
title = "Using a Yubikey inside a VirtualBox VM"
description = "An introductory guide"
draft = true
date = "2018-01-26"
tags = ["software", "metaswitch"]
+++

I've got a [Yubikey](https://www.yubico.com/product/yubikey-4-series/), a little USB security key. It's main intended use is for two-factor authentication, but I mostly use mine for its ability to act as a [GPG smartcard](https://wiki.gnupg.org/SmartCard). The Yubikey stores the private key I use to sign the code I write[^1] and some of the e-mails I send.

[^1]: Prompted by https://mikegerwitz.com/papers/git-horror-story.html

At home, this is easy - my PC dual-boots into an Ubuntu environment I use for writing code. At work, though, we have Windows computers. For development, we then use CentOS 7 VMs running through VirtualBox.

It took me _quite_ a while to get my Yubikey working with the VM, so I'm documenting some of the steps I took here in the hope that they may be more broadly useful.

# Adding GPG smart-card support to CentOS 7

Install the smart card daemon with: `sudo yum install gnupg2-smime`
Ensure that the following files exist with the given contents:
    ~/.gnupg/gpg-agent.conf

    default-cache-ttl 14400

    max-cache-ttl 14400

    enable-ssh-support

    ~/.gnupg/gpg.conf
    use-agent

    ~/.gnupg/scdaemon.conf

    reader-port "Yubico Yubikey 4 OTP+U2F+CCID 00 00"
Run `sudo service pcscd start`
At this point, you may need to sudo killall gpg-agent and/or sudo killall scdaemon
gpg --card-status should now start providing useful output.

# Mapping a specific USB port to a VirtualBOx VM

1. Via the VirtualBox GUI, go to the settings page for your VM whilst the VM is halted.
2. Enable the USB controller (1.1 worked for me; YMMV)
3. To actually get anything passed through, you now need to add a filter.
  1. If you want to grab only a specific device, create the filter by selecting the appropriate option from the '+' menu. Otherwise, use the 'blue circle' option.
4. Now, to get a specific port, you need to find out the correct number to plug into the 'port' field in your new filter. `"c:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list usbhost` is your friend here. With a device inserted into the desired port, start the dev VM, then run that command. You should see something like:
```
Host USB Devices:

UUID:               xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
VendorId:           0x1050 (1050)
ProductId:          0x0407 (0407)
Revision:           4.53 (0453)
Port:               0
USB version/speed:  2/Full
Manufacturer:       Yubico
Product:            Yubikey 4 OTP+U2F+CCID
Address:            \\?\usb#vid_80ee&pid_cafe#x&xxxxxx&x&4#{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
Current State:      Captured
```
The port number appears to be the number just before the final '#' in the 'Address' - i.e. 4, here.
5. Now, edit the filter, and add the port number. Note that you may need to pad the port number out to 4 digits with '0's (i.e. my current filter is '0003').
