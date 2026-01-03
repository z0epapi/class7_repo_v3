IPv4



FIRST OCTET IS '10' FOR CLASSES PURPOSES ONLY



CHANGE 2ND OCTET ONLY!!!



1-99 = AWS

100-199 = GCP / Oracle

200-255 = Azure





Examples: 



Main Ireland 10.32.0.0/16 (DO NOT MESS WITH 10)



Public A: 10.32.1.0/24 (DO NOT LEAVE WHITE SPACE IN THE OCTETS)

Public B: 10.32.2.0/24

Public C: 10.32.3.0/24



Private A: 10.32.11.0/24

Private B: 10.32.12.0/24

Private C: 10.32.13.0/24



Note: 

One public per AZ

Multiple private per AZ



Video Explanation: https://www.youtube.com/watch?v=POPoAjWFkGg





**Hungry Wolves CIDR Ranges Template**



x.x.x.x/16 (Main)

x.x.x.x/24 (subnets)

1st x = 10 (FOR CLASS PURPOSES)

2nd x = number familiar to you

3rd x = public or private

4th x = dont touch



x.x.x.x/24



Main <insert Region> 10.80.0.0/16 (DO NOT MESS WITH 10)



Public A: 10.80.1.0/24

Public B: 10.80.2.0/24

Public C: 10.80.3.0/24

Public D: 10.80.4.0/24



Private A: 10.80.11.0/24

Private B: 10.80.12.0/24

Private C: 10.80.13.0/24

Private D: 10.80.14.0/24



