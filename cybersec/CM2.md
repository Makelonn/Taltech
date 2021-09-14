# Notes on CM2

Keep an eye on moodle to have complementary info

## Some definition
information security != cybersecurity

remember CIA :
* confidentiality
* availability
* integrity

### Confidentiality

data is today valuable

### Integrity

The validity of data : you have to be sure that it is **accurate**, **complete** and **correct**.

### Availability

denial of service attack

### Authenticity

The data is from the source it should be from : proof of identity

### Nonrepudiation

### Privacy

rgpd in EU

### Security controls

how a risk or compliance requirement is being adressed
* controle lifecycle
* roles

### cybersecurity vs compliance ?

compliance doesn't implies cybersecurity

they overlap but you need both of them

### Security incidents

* identification
* containement
* eradication
* recovery
* lesson learned
    we don't want the same thing to happen again

cybersecurity is for everybody ! training others is really important

You need regular training and to keep it interesting

Creating security culture so employees can start noticing irregularities

People should'nt be scared to report incidents

Many false positive : answer and tell when it's true case and tell when it's false !

### Cybersec science - research fileds

* attack detection
* secure mechanism design
* software secu
* malware / threat analysis
* risk management
* cryptography
* human behaviour

### who are the bad guys ?

* script kiddies
    for fun basically
* hacktivists
    political / white hat hackers (if we want to do that message the guy)
* cybercriminals
* state sponsored hackers

### Vulnerability

a flaw in the measure you take to secure an asset

traditionnal definition : only flaws or weakness in systems or networks (rfc 2828). vulnerabilities expose assets to harm

exist in operating systems, applications or hardware to use

### Exploit

software program that has been developed to attack an asset by **taking advantage of a vulnerability**

### payload vs exploit

### Threat

an expressed or demonstrated intent to harm an asset or cause it to become unavailable

hostile acts, not repecting the motive, are considered threats

acts of nature / human error / negligence are also threat

### Threat actor

someone or smthg that pose a threat

### Risk

the potential for loss / damage / destruction of an asset as a result of a threat exploiting a vulnerability

### Malware

malicious softwaree

## History

in 1980s and 1990s: 

* *brain* was the first "stealth" virus (hide itself)
* *jerusalem* DOS virus discovered in 1987
* *the morris worm* first known to be distributed via the internet
* *michelangelo* infect DOS-based systems
* *CIH* was a microsoft windows 9x virus
* *Melissa* was a macro virus

New millenium :
* *iloveyou* 10millions of windows based system attacked
* *the anna kournikova* email worm
* *sircam* on windows through email
* *codered worm* buffer overflow vulnerability
* *nimda*

*Zero Days* documentation about stuxnet

## Threat vectors and delivery channels

### pishing

email disguised as a legitimate message, enticing the recipient to open an infected attachment or click a link to an infected website

### Drive by download

malware is inadvertently dl from a legitimate site that has been compromised

### Ad-based malware

### Trojan horses

* remote administration (RAT)
* backdoor trojans
* network redirection
*  distributed attacks

### Rootkits

set of malicious tools that can be used to get root access on a system

2 types : user mode or kernel mode rootkit

### Logic bombs

programmed malfunction of a legitimate application

scenarios is realistic when dealing with large projects driven by limited code reviews

### Downloaders

### Droppers

installer part to downloaders

injectors (special kinds of dropper that usually install virus code in memory)

### Backdoors

method, often secret, of bypassing normal authentification or encryption in acomputer system, a product, or an embedded device (ex: home router)

### Ransomware

Type of malicious software or malware designed to deny access to a system or data until ransom is paid

