Stateless Web
WhatIsTheTime.com allows people to know what time it is
We dont need a database
We want to start small and can accept downtime
we want to scale vertically and horizontally, no downtime
lets go
proceed!

----------
Start from the beginning, what time is it?
Want a user to ask "what time it is" you want the ec2 to respond with current time (per user!/location)
you need elastic ip address for public

start with t2.micro but now you need more space!!
Stop instance --> change instance type ----> Now M5.xlarge!
Stays the same IP because of elastic IP, but downtime happens
---------
Scaling horizontally

Now with many users! 9+ now  you need to scale horizontally so you add 3 m5.xlarge instances but now all instances have its own elastic IP

3 ec2 instances m5.xlarge but now we remove elastic IP! Now we use route 53 with the website url with an A record on TTL of 1 hour.  
Now the users go through route 53 and all  users can get into these instances.

-----------

Adding a load balancer! now that all ec2 instances are private
Make an ELB + health checks
Now users query to route 53 website however the ELB is added you need an ALIAS record
alias perfectly goes into the ELB all the time
ELB than redirects and balances the traffic

-------
Now we need an auto scaling group!
Now we get into an AZ, but now you put it in an auto scaling group for cost-effectiveness
but now we need to put this is more availability zones!
Make your website a multi-az!

-----

ELB becomes multi-az now! zones 1-3
and now the autoscaling group is for 3 AZ's
and each zone has its specific ec2 instances
2 azs but knowing 2 instances must be running so now we reserve instances which cost savings

Being an aws solutions architect you have to think of "how can we make this better constantly and safely"
Well architected framework!!!!
Costs -  scaling, asg, making reverse instances (think make it cheap!)
Performance - vertical scaling ,ELB, auto scaling groups.
Reliability - How route 53 being used to reliably send users, multi -az 
Operational excellence - How we can always make this automated!
Security - how we can use security groups for saftey and reliably connect stuff together

-----------------------------

