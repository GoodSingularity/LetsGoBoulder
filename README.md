# LetsGoBoulder

This is an API of climbing wall app.
* install Min.io https://linuxhint.com/installing_minio_ubuntu/

API uses:
* Min.io server to store files.
* Graphql
* RSpec, testing framework
* Pry, debugger

Initialize an app:
* rails db:create
* rails db:migrate

If you want to start server:
* sudo ./minio server /minio
* rails s

If you want to run all tests using rspec:
* rspec .


Application features:

- Creating the route
- Uploading File
- Listing all routes
- Filtering routes
- Searching routes by name, level or route setter


Explanation:
- Climbers climb on routes. 
- Routes are set by routeSetters. 
- Climbing route has its level and name.



To do
- Adding users model, authentication feature
- Adding ascention model. Climber can prove that this particular route was climbed on. 
- Adding likes system to ascention model
- Adding listing current logged in user, ascentions
