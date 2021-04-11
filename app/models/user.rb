# typed: strict
class User < ApplicationRecord
  include Clearance::User
end
