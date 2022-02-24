
# **Introduction**

    Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a  risky venture and opens up a cute 
    little restaurant that sells his 3 favourite foods: sushi, curry  and ramen. 
                                 Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has 
    captured some very basic data from their few months of operation but have no idea how  to use their data to help them run the business. 


## Table of Contents
1. [Problem Statement](problem-statement)
2. [Entity Relationship Diagram](Entity-Relationship-Diagram)
3. [Tables](Tables)
4. [Case Study Questions](Case-Study-Questions)

## **Problem Statement**

    Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much
    money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him 
    deliver a better and more personalised experience for his loyal customers.

    Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough 
    for you to write fully functioning SQL queries to help him answer his questions! 

    Danny has shared with you 3 key datasets for this case study: 

     sales 

     menu 

     members
# **Entity Relationship Diagram**

<img width="518" alt="Entity_Relationship_Diagram" src="https://user-images.githubusercontent.com/100192227/155489740-32d2f980-cbdd-4831-acb4-73a224a36c5d.png">


# **Table 1:** sales 
    The sales table captures all customer_id level purchases with a corresponding order date and product_id information for when and what 
    menu items were ordered. 

<img width="230" alt="sales_table" src="https://user-images.githubusercontent.com/100192227/155490476-68b4f497-77db-46af-ab7c-d5b21fbcf09b.png">

# **Table 2:** menu 
    The menu table maps the product_id to the actual product_name and price of each menu item.

<img width="211" alt="menu_table" src="https://user-images.githubusercontent.com/100192227/155490577-5a5ba71b-05ec-4a51-ab8b-da27e7602ab5.png">

# **Table 3:** members 
    The final members table captures the join_date when a customer_id joined the beta version of the Danny’s Diner loyalty program.

<img width="172" alt="member_table" src="https://user-images.githubusercontent.com/100192227/155490786-4d47e404-7001-416b-8c7d-9a32ec8c9374.png">

# **Case Study Questions:**

## 1) What is the total amount each customer spent at the restaurant? 
## 2) How many days has each customer visited the restaurant? 
## 3) What was the first item from the menu purchased by each customer? 
## 4) What is the most purchased item on the menu and how many times was it purchased by all customers? 
## 5) Which item was the most popular for each customer? 
## 6) Which item was purchased first by the customer after they became a member? 
## 7) Which item was purchased just before the customer became a member? 
## 8) What is the total items and amount spent for each member before they became a member? 
## 9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? 
## 10) In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
