Stateful web application

We are trying to create a fully scalable wordpress website
we want that website to access and correctly display picture uploads
Our User data, and the blog content should be stored in a mysql database
Global scale!

--------------------

Multi-az read replicas with Aurora MySQL (scaled better)
Store pictures with EBS Volumes - send image to LB and connects to EBS, however now that when scaling, images doesnt get responded with all instances.
EBS volumes is only good for single instance use so now we want EFS
Now letsuse EFS on the side to store the pictures (ENI's) are now used in all ec2 instances
Storage is now shared between all instances! 
ENI - EFS (efs stores images)
Good for any AZ/All INstance storages

-------------------------
We taught

Aurora Database to have easy multi-az and read replicas
Storing data in EBS for single
Storing data in EFS for distributed
  EFS  is more expensive
  but better for traffic
