# Tripda Search Worker

The Tripda Search Worker has the RabbitMQ consumers to do create, update and delete actions into ElasticSearch. Its core was written using ruby programming language and Sneakers framework.

## Requirements
- Ruby 1.9.3 >
- Tripda-Search-Box

## Dependencies
- Bundler 1.9.6
- Sneakers 1.0.4
- Redis 3.2.1
- Elasticsearch-api 1.0.7

## Instalation
Using the Tripda-Search-Box execute the commands below:

- sudo apt-get install ruby-full
- sudo gem install sneakers
- sudo gem install bundler

Enter into repository root and execute the command below:
- bundler install

# Configuration
## RabbitMQ
- sudo service rabbitmq-server start
- sudo rabbitmqctl add_user test test
- sudo rabbitmqctl set_user_tags test administrator
- sudo rabbitmqctl add_vhost /trip
- sudo rabbitmqctl set_permissions -p /trip test ".*" ".*" ".*"
- sudo service rabbitmq-server restart

## Workers

- ruby search_worker.rb start
- ruby search_worker.rb stop
- ruby search_worker.rb run
- ruby search_worker.rb status

## Application
Change config.dist.yml to config.yml

## How to create a message
Access the rabbitmq panel: http://192.168.33.20:15672/
- user: test
- pass: test

After, access the exchange page and click in "tripda.trip.direct" to open the exchange and compose a message. To compose a message choose a routing key and put a json into payload.


