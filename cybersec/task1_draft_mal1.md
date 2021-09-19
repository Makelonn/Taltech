## File 1

### Filename 

0d11a13f54d6003a51b77df355c6aa9b1d9867a5af7661745882b61d9b75bccf

### Sha256 or md5 Hash

d2b5a2547e2246694148ece3cf74de0e

### General summary about particular sample (your ideas and ..)

Trojan

Name Rombertik -> propagate through spam and phishing

.SCR screensaver executable

Majority of the file is unncessary data which is probably why "free automated malware analysis" don't seems to finish the analysis

Goal is to get sentive information & credentials in the user's browser

Other files related : 
d2b5a2547e2246694148ece3cf74de0e_0d11a13f54d6003a51b77df355c6aa9b1d9867a5af7661745882b61d9b75bccf
VirusShare_d2b5a2547e2246694148ece3cf74de0e
2
trojan.exe
rombertik.exe
0d11a13f54d6003a51b77df355c6aa9b1d9867a5af7661745882b61d9b75bccf.exe
Copy.zip
Copy
Copy#064046.gz
0d11a13f54d6003a51b77df355c6aa9b1d9867a5af7661745882b61d9b75bccf.infected


### General characteristic
* Delivery method : phishing email / spam
* If detect that it is analyse it will try to overwrite the master boot record / if it fails, it encrypte all files in the home folder with a randomly generated key
* ultimately designed to steal user's data

### Antivirus detection results 

https://cuckoo.cert.ee/submit/post/3173329
https://www.virustotal.com/gui/file/0d11a13f54d6003a51b77df355c6aa9b1d9867a5af7661745882b61d9b75bccf/community
https://www.hybrid-analysis.com/sample/0d11a13f54d6003a51b77df355c6aa9b1d9867a5af7661745882b61d9b75bccf

### File System IOC (indicator of compromise)

### Network IOC

### Registry IOC

### Behavior and control flow
* Anti-analysis check -> not in a sandbox
* if no sandbox, it decrypts and install itself on the computer
* then launch a copy and overwrite it with the core functionality
* before beginning to spy, last check
* if the check fail, try to destroy the master boot record / or encrypte all the files in the home folder

### Appendix (links to analyses, etc)

https://blogs.cisco.com/security/talos/rombertik
https://www.hybrid-analysis.com/sample/77bacb44132eba894ff4cb9c8aa50c3e9c6a26a08f93168f65c48571fdf48e2a