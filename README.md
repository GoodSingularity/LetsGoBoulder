# LetsGoBoulder

This is an API of climbing wall app.
* install Min.io https://linuxhint.com/installing_minio_ubuntu/

API uses:
* Min.io server to store files.
* Graphql
* RSpec, testing framework
* Pry, debugger
* Batch Loader for N+1 Query problem
* Rails Event Store
* Twilio API (sending text messages)


Initialize an app:
* rails db:create
* rails db:migrate

Credentials needed:

- Postgres
Your Super User Credentials in Postgres
You can create Credentials: https://stackoverflow.com/questions/57975093/create-a-superuser-in-postgres
  * ENV['POSTGRES_USERNAME']
  * ENV['POSTGRES_PASSWORD']

- Twilio
You can create Credentials: https://www.twilio.com/docs/sms/quickstart/ruby
  * ENV['TWILIO_ACCOUNT_SID']
  * ENV['TWILIO_AUTH_TOKEN']
  * ENV['TWILIO_PHONE_NUMBER']

- Gmail
You can create Credentials: https://support.google.com/accounts/answer/185833?hl=pl
  * ENV['GMAIL_MAIL']
  * ENV['GMAIL_PASSWORD']

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
- Authentication (Sign In / Sign Out)
- Liking Ascend
- UnLiking Ascend
- Mailer
- Sending Text Message after log in.
- etc


Explanation:
- Climbers climb on routes. 
- Routes are set by routeSetters. 
- Climbing route has its level and name.



To do
