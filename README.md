### Here is our AI Prompt with out business rules : 

> You work in the field of data analysis. Your company is involved in the domain of textiles,
yarns, fibers etc... It is a company such as the danish brand Hobbii or French brand Tissus
des Ursules. The data being collected are clients, inventory, the fabric/textile/yarn
attributes, and workers. Take inspiration from the following websites : https://hobbii.fr/ ,
https://www.tissusdesursules.fr/.
Your company wants to apply MERISE to design an information system. You are
responsible for the analysis part, i.e., gathering the company's requirements. It has called
on computer engineering students to carry out this project, and you must provide them
with the necessary information so that they can then apply the following steps of
database design and development themselves.
First, establish the data business rules for your company in the form of a bulleted list. It
must correspond to the information provided by someone who knows how the company
works, but not how an information system is built.
Next, based on these rules, provide a raw data dictionary with the following columns,
grouped in a table: meaning of the data, type, size in number of characters or digits. There
should be between 25 and 35 data items. It is used to provide additional information
about each data item (size and type) but without any assumptions about how the data will
be modeled later. 
Provide the business rules and the data dictionary.


### And here is the data dictionary : 

Meaning of the Data Type Size (characters / digits)
Customer unique number Integer 10 digits
Customer last name Alphanumeric 50 characters
Customer first name Alphanumeric 50 characters
Customer email address Alphanumeric 100 characters
Customer phone number Alphanumeric 20 characters
Customer loyalty points balance Integer 6 digits
Delivery street address Alphanumeric 120 characters
Delivery postal code Alphanumeric 10 characters
Delivery city Alphanumeric 50 characters
Delivery country Alphanumeric 50 characters
Order number Integer 12 digits
Order date Date 10 characters (YYYY-MM-DD)
Meaning of the Data Type Size (characters / digits)
Order status Alphanumeric 20 characters
Total order amount (incl. tax) Decimal 10 digits (8,2)
Payment method Alphanumeric 30 characters
Product internal reference Alphanumeric 30 characters
Product name Alphanumeric 100 characters
Product category Alphanumeric 50 characters
Product description Alphanumeric 500 characters
Product selling price Decimal 8 digits (6,2)
Product purchase price Decimal 8 digits (6,2)
Product color Alphanumeric 30 characters
Product size or length Alphanumeric 30 characters
Product composition (fiber content) Alphanumeric 100 characters
Unit of measure (unit, meter, gram) Alphanumeric 20 characters
Available stock quantity Integer 8 digits
Stock movement quantity Integer 8 digits
Stock movement date Date 10 characters
Supplier code Alphanumeric 20 characters
Supplier company name Alphanumeric 100 characters
Supplier contact email Alphanumeric 100 characters
Purchase order number Integer 12 digits
Employee number Integer 8 digits
Employee role Alphanumeric 50 characters
Store or warehouse identifier Alphanumeric 30 characters


[Here](Updated_MCD.png) is linked our MCD


### Here is our AI prompt for your LDM :

--  "You are a SQL data generator, you must help me for a textile retail database.
--   Generate realistic INSERT statements for the following tables in order
--   (respecting foreign key dependencies):
--   headquarters, material, sellingtype, client, payment, store, employee,
--   item, order, is_made_of, belongs_to, has, contains, paid.
--   Rules:
--   - Generate at least 5 rows per table, more for junction tables.
--   - All values must be consistent with each other (FK values must exist).
--   - Respect all CHECK constraints: prices > 0, emails contain '@',
--     order must be physical XOR online, status in known list, etc.
--   - The context is a yarn/fabric/textile retail brand with physical and online stores.
--   - Return only valid SQL INSERT statements, no commentary."


The usage scenario is explained in the READM
