module Types
  class RouteType < Types::BaseObject
    field :files, [Types::FileType], null: false
    field :name, String, null: false
    field :creator, [Types::UserType], null: false
    field :color, Integer, null: false
    field :status, Boolean, null: false

    def files
      array = []
      object.files.each{|file| data= $s3.get_object(bucket: 'routes', key: file)
        array.push(
          {
            id: data.etag[1..-2],
            last_modified: data.last_modified,
            size: data.content_length.to_s + ' ' + data. accept_ranges.to_s
           }
         )
       }
       array
    end

    def creator
      BatchLoader::GraphQL.for([object.route_setter].uniq).batch(default_value: []) do |user_ids, loader|
        User.search(user_ids).each { |user|
          loader.call([object.route_setter].uniq) { |data|
            data << user
          }
        }
      end
    end
  end
end
