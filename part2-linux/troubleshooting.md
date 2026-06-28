# Linux System Administration



Web Server: **10.0.1.50**

SSH connection times out.

---

# 1. Verify Network Connectivity

First, verify that the server is reachable.

ping 10.0.1.50

Check whether port 22 is open.



```bash
telnet 10.0.1.50 22

Check routing.

traceroute 10.0.1.50


nslookup webserver.example.com

---

# 2. Verify SSH Service

If network connectivity is confirmed, access the server through the console (AWS EC2 Serial Console, Systems Manager, VMware console, or KVM).

Check SSH service.

sudo systemctl status sshd

If stopped:

sudo systemctl start sshd
sudo systemctl enable sshd

Check listening ports.



sudo netstat -tualpn | grep 22


# 3. SSH Running but Connection Still Fails

Possible causes include:

- Security Group blocking port 22
- Network ACL blocking traffic
- Local firewall (iptables, ufw, firewalld)
- SSH configuration issue
- Disk full preventing login

Useful commands:

sudo iptables -L
sudo ufw status
sudo firewall-cmd --list-all

cat /etc/ssh/sshd_config


# 4. Check Resource Utilization
htop
free -h
df -h
iostat
ps aux --sort=-%cpu | head
journalctl -xe
dmesg

journalctl -b #check boot logs 


