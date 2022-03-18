# Rails Engine

## Background and Description 
Rails Engine is the backend for a fictitious E-Commerce application. The project is modeled after a service-oriented architecture, as a separate backend that provides information to the front end via APIs. 


## Requirements and Setup
### Ruby/Rails 
- Ruby 2.7.2
- Rails 5.2.6

### Setup 
1. Clone this repo. On your local machine, open the terminal and enter the following command:

```
$ git clone git@github.com:croixk/rails_engine.git
```

2. You can now enter the project directory ```$ cd rails_engine```

3. Now, install the required gems using ```$ bundle install```

4. Run database migrations with ```$ rails rake db:{drop,create,migrate,seed}```

5. Before consuming the APIs, you will need to start the local server ```$ rails s```

## Endpoints 
This project exposes the following endpoints for a front end team

### Merchants
- get all merchants - ```GET /api/v1/merchants```
- get one merchant - ```GET /api/v1/merchants/:merchant_id```
- get all items for a given merchant ID - ```GET /api/v1/merchants/:merchant_id/items```

### Items
- get all items - ```GET /api/v1/items```
- get one item - ```GET /api/v1/items/:item_id```
- create an item - ```POST /api/v1/items```
- edit an item - ```PATCH /api/v1/items```
- delete an item - ```DELETE /api/v1/items/:item_id```
- get the merchant data for a given item ID - ```GET /api/v1/items/:item_id/merchant```
