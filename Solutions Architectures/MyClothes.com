Stateful web application


MyClothes.Com allows people to buy clothes online
Theres is a shopping cart
our website is having hundreds of users at a time
we need to scale, maintain horizontal scalability and keep our web application as stateless as possible
users should not lose their shopping cart
users should have their details in a database
Proceed!

--------------------
ELB Stickyness keeps that shopping cart for every instance! (always go to same instance)
Cookies are what to use as the user should send the shopping cart content.
HTTP requests become heavier
Security Risk 
Cookies have to be validated
Cookies must be less than 4kb

----------------------------

Server session! 
Send a session ID from the user
ElastiCache is going to run in the backround. Once ec2 instance has a cart, it will be sent to the Cache so next time the the user goes into another instance, the users session ID pulls the elasticache information 
Amazon DynamoDB can be used also
sub millisecond
more secure!
-------------------------------

Data in a database

This time we have the EC2 instance talks to the AWS RDS (store/retrieve data)
------------------------

Scale Reads!

We can reach from RDS Replicas as the master writes, so now we can scale to make it faster
Lazy loading --- EC2 Instances --- does have info? --- read/write in RDS
Cache maintenance now
-------------------

Multi AZ it!

Select RDS Multi AZ, and ElastiCache has Multi AZ!
Everything needs to be multi AZ
--------

Security groups (secure)

We want http/https traffic from anywhere on the ELB side.
Instance side we want to restrict traffic to the EC2 froim the LB
Same for ElastiCache/RDS from instances

-----------------------

ELB Sticky Sessions
Web Clients for storing cookies/stateless
ElastiCache
  For storing sessions
  For caching data from RDS
  Multi AZ
RDS
  For storing user data 
  Read replicas for scaling reads
  Multi AZ for disaster recovery
Tight security with security groups referencing each other

More complicated (3 tier)
Client
Web
Database 
(more $$$$ though)

