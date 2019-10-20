class ProfileImage < ApplicationRecord


	@@versions = {
    :square => [300, 300]
  }

  def self.versions
    @@versions
  end
end
