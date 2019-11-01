#To upload data to the JHPCE cluster from the Lieber servers

login to the Lieber server through terminal on mac, Mobaxterm, WinSCP, PUTTY etc 

``` Bash
Madhavis-MacBook-Pro:~ madhavitippan$ ssh madhavi.tippani@10.17.9.104
madhavi.tippani@10.17.9.104's password: Enter your password you use to login to Lieber server 10.17.9.104
Last login: Fri Nov  1 15:45:27 2019 from 10.194.129.92
[srv07 /data/users/madhavi.tippani]$ 
```
If you are not able to login, contact Bill Ulrich to set up a login directory for your account on Lieber server.

Use command [rsync](https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/) to transfer data to JHPCE through the transfer node. Transfer node on JHPCE is used for data transfer.

Syntax for [rsync](https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/) 
rsync [options] source destination

``` Bash
[srv07 /data/users/madhavi.tippani]$ rsync -avzh --progress /data/Neural_Plasticity/Maddy/Ca_Img/test ssh mtippani@jhpce-transfer01.jhsph.edu:/dcl01/lieber/ajaffe/Maddy/Ca_Img/vignette 
Enter passphrase for key '/data/users/madhavi.tippani/.ssh/id_rsa': Enter your password for JHPCE or the Key if you have your system setup with SSH Keypair

rsync: link_stat "/data/users/madhavi.tippani/ssh" failed: No such file or directory (2)
test/

sent 96 bytes  received 16 bytes  14.93 bytes/sec
total size is 0  speedup is 0.00

```

To setup SSH Keypair for password less login [SSH Keypair](https://jhpce.jhu.edu/knowledge-base/authentication/ssh-key-setup/)
