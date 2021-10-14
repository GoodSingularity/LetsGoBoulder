module Context
  module Users
    module Commands
      class CreateSingleUser
        def call(event)
          stream = event.data
          user = stream[:adapter].create!(
            name: stream[:name],
            email: stream[:email],
            password: stream[:password],
            phone_number: stream[:phone_number],
            avatar_id: stream[:avatar_id]
          )
          SignUpMailer.with(receiver: stream[:email], phone_number: stream[:phone_number], name: stream[:name]).afterwards.deliver_now!
        end
      end
    end
  end
end
