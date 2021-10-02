module Types
  class FileType < Types::BaseObject
    field :id, ID, null: false
    field :last_modified, GraphQL::Types::ISO8601DateTime, null: false
    field :size, String, null: false
  end
end
