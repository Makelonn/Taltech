# Notes on CM1

Use teams to communicate

Book :

Applied information Security : A Hands on approach *David Basin, Patrick Schaller, Michael Schlapfer*

Grading:  
* groupworks & assignements : 40%
* Labs&Homeworks : 60%
* Bonus labs for bonus :)

Labs need to be done on date !!

## Principle of security

- keep it simple
  - less flaws
  - less time to design and maintain
- Open design
  - security shouldn't depend on the secu of the protection mechanism
  - kerchhoff's principe; cryptosystem should be secure even if all aspect of the system (except key) are public
- Compartmentalization
- Minimum exposure
  - reduce external surface
  - limit the amount given
  - minimize opportunity for attack
- minimum trust and maximize trustworthiness
  - system meets expectations = trusthworthy
  - trusted system : assumption
  - trust but verify before validate
- Secure / faile safe default
  - if a default the system should return to safe state 
  - deny everything unless explicitly granted
-  Access to any object must be monitored & controlled (complete mediation)
-  no single point of failure
   -  redundant security when feqsible
   -  remove single points of faile 
   -  mecanism 'Shamir's Secret Sharding' (different people have different part of a key and you need all of them to change smth)
- Traceability
- Generating secrets : maximize the entropy of secret (not predictable as much as possible)
- Usability : if not easy may corrupt the process
